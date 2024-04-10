/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "pch.hpp"

#include "creatures/players/grouping/party.hpp"
#include "game/game.hpp"
#include "lua/creature/events.hpp"
#include "lua/callbacks/event_callback.hpp"
#include "lua/callbacks/events_callbacks.hpp"

std::shared_ptr<Party> Party::create(std::shared_ptr<Player> leader) {
	auto party = std::make_shared<Party>();
	party->m_leader = leader;
	leader->setParty(party);
	if (g_configManager().getBoolean(PARTY_AUTO_SHARE_EXPERIENCE, __FUNCTION__)) {
		party->setSharedExperience(leader, true);
	}
	return party;
}

void Party::disband() {
	if (!g_events().eventPartyOnDisband(getParty())) {
		return;
	}

	if (!g_callbacks().checkCallback(EventCallback_t::partyOnDisband, &EventCallback::partyOnDisband, getParty())) {
		return;
	}

	auto currentLeader = getLeader();
	if (!currentLeader) {
		return;
	}
	m_leader.reset();

	currentLeader->setParty(nullptr);
	currentLeader->sendClosePrivate(CHANNEL_PARTY);
	g_game().updatePlayerShield(currentLeader);
	g_game().updatePlayerHelpers(currentLeader);
	currentLeader->sendCreatureSkull(currentLeader);
	currentLeader->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, "Your party has been disbanded.");

	for (auto invitee : getInvitees()) {
		invitee->removePartyInvitation(getParty());
		currentLeader->sendCreatureShield(invitee);
	}
	inviteList.clear();

	auto members = getMembers();
	for (auto member : members) {
		member->setParty(nullptr);
		member->sendClosePrivate(CHANNEL_PARTY);
		member->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, "Your party has been disbanded.");
	}

	for (auto member : members) {
		g_game().updatePlayerShield(member);

		for (auto otherMember : members) {
			otherMember->sendCreatureSkull(member);
		}

		member->sendCreatureSkull(currentLeader);
		currentLeader->sendCreatureSkull(member);
		g_game().updatePlayerHelpers(member);
	}
	memberList.clear();
	membersData.clear();
}

bool Party::leaveParty(std::shared_ptr<Player> player) {
	if (!player) {
		return false;
	}

	auto leader = getLeader();
	if (!leader) {
		return false;
	}

	if (player->getParty().get() != this && leader != player) {
		return false;
	}

	if (!g_events().eventPartyOnLeave(getParty(), player)) {
		return false;
	}

	if (!g_callbacks().checkCallback(EventCallback_t::partyOnLeave, &EventCallback::partyOnLeave, getParty(), player)) {
		return false;
	}

	bool missingLeader = false;
	if (leader == player) {
		if (!memberList.empty()) {
			if (memberList.size() == 1 && inviteList.empty()) {
				missingLeader = true;
			} else {
				auto newLeader = memberList.front();
				while (!newLeader) {
					memberList.erase(memberList.begin());
					if (memberList.empty()) {
						missingLeader = true;
						break;
					}
					newLeader = memberList.front();
				}
				if (newLeader) {
					passPartyLeadership(newLeader);
				}
			}
		} else {
			missingLeader = true;
		}
	}

	// since we already passed the leadership, we remove the player from the list
	auto it = std::find(memberList.begin(), memberList.end(), player);
	if (it != memberList.end()) {
		memberList.erase(it);
	}

	player->setParty(nullptr);
	player->sendClosePrivate(CHANNEL_PARTY);
	g_game().updatePlayerShield(player);
	g_game().updatePlayerHelpers(player);

	for (auto member : getMembers()) {
		member->sendCreatureSkull(player);
		player->sendPlayerPartyIcons(member);
		member->sendPartyCreatureUpdate(player);
		g_game().updatePlayerHelpers(member);
	}

	player->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, "You have left the party.");

	updateSharedExperience();

	clearPlayerPoints(player);

	std::ostringstream ss;
	ss << player->getName() << " has left the party.";
	broadcastPartyMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	if (missingLeader || empty()) {
		disband();
	}

	player->sendCreatureSkull(player);
	leader->sendCreatureSkull(player);
	player->sendPlayerPartyIcons(leader);
	leader->sendPartyCreatureUpdate(player);

	return true;
}

bool Party::passPartyLeadership(std::shared_ptr<Player> player) {
	auto leader = getLeader();
	if (!leader || !player || leader == player || player->getParty().get() != this) {
		return false;
	}

	// Remove it before to broadcast the message correctly
	auto it = std::find(memberList.begin(), memberList.end(), player);
	if (it != memberList.end()) {
		memberList.erase(it);
	}

	std::ostringstream ss;
	ss << player->getName() << " is now the leader of the party.";
	broadcastPartyMessage(MESSAGE_PARTY_MANAGEMENT, ss.str(), true);

	auto oldLeader = leader;
	m_leader = player;

	memberList.insert(memberList.begin(), oldLeader);

	updateSharedExperience();
	updateTrackerAnalyzer();

	for (auto member : getMembers()) {
		member->sendPartyCreatureShield(oldLeader);
		member->sendPartyCreatureShield(player);
	}

	for (auto invitee : getInvitees()) {
		invitee->sendCreatureShield(oldLeader);
		invitee->sendCreatureShield(player);
	}

	player->sendPartyCreatureShield(oldLeader);
	player->sendPartyCreatureShield(player);

	player->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, "You are now the leader of the party.");
	return true;
}

bool Party::joinParty(const std::shared_ptr<Player> &player) {
	auto leader = getLeader();
	if (!leader) {
		return false;
	}

	if (!g_events().eventPartyOnJoin(getParty(), player)) {
		return false;
	}

	if (!g_callbacks().checkCallback(EventCallback_t::partyOnJoin, &EventCallback::partyOnJoin, getParty(), player)) {
		return false;
	}

	auto it = std::find(inviteList.begin(), inviteList.end(), player);
	if (it == inviteList.end()) {
		return false;
	}

	inviteList.erase(it);

	std::ostringstream ss;
	ss << player->getName() << " has joined the party.";
	broadcastPartyMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	player->setParty(getParty());

	g_game().updatePlayerShield(player);

	for (auto member : getMembers()) {
		member->sendCreatureSkull(player);
		member->sendPlayerPartyIcons(player);
		player->sendPlayerPartyIcons(member);
	}

	leader->sendCreatureSkull(player);
	player->sendCreatureSkull(player);
	leader->sendPlayerPartyIcons(player);
	player->sendPlayerPartyIcons(leader);

	memberList.push_back(player);

	g_game().updatePlayerHelpers(player);

	updatePlayerStatus(player);

	player->removePartyInvitation(getParty());
	updateSharedExperience();

	const std::string &leaderName = leader->getName();
	ss.str(std::string());
	ss << "You have joined " << leaderName << "'" << (leaderName.back() == 's' ? "" : "s") << " party. Open the party channel to communicate with your companions.";
	player->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());
	updateTrackerAnalyzer();
	return true;
}

bool Party::removeInvite(const std::shared_ptr<Player> &player, bool removeFromPlayer /* = true*/) {
	auto leader = getLeader();
	if (!leader) {
		return false;
	}

	auto it = std::find(inviteList.begin(), inviteList.end(), player);
	if (it == inviteList.end()) {
		return false;
	}

	inviteList.erase(it);

	leader->sendCreatureShield(player);
	player->sendCreatureShield(leader);

	if (removeFromPlayer) {
		player->removePartyInvitation(getParty());
	}

	if (empty()) {
		disband();
	} else {
		for (auto member : getMembers()) {
			g_game().updatePlayerHelpers(member);
		}

		g_game().updatePlayerHelpers(leader);
	}

	return true;
}

void Party::revokeInvitation(const std::shared_ptr<Player> &player) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	std::ostringstream ss;
	ss << leader->getName() << " has revoked " << leader->getPossessivePronoun() << " invitation.";
	player->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	ss.str(std::string());
	ss << "Invitation for " << player->getName() << " has been revoked.";
	leader->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	removeInvite(player);
}

bool Party::invitePlayer(const std::shared_ptr<Player> &player) {
	auto leader = getLeader();
	if (!leader) {
		return false;
	}

	if (isPlayerInvited(player)) {
		return false;
	}

	std::ostringstream ss;
	ss << player->getName() << " has been invited to join the party (Share range: " << getMinLevel() << "-" << getMaxLevel() << ").";

	if (empty()) {
		ss << " Open the party channel to communicate with your members.";
		g_game().updatePlayerShield(leader);
		leader->sendCreatureSkull(leader);
	}

	leader->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	inviteList.push_back(player);

	for (auto member : getMembers()) {
		g_game().updatePlayerHelpers(member);
	}

	g_game().updatePlayerHelpers(leader);
	leader->sendCreatureShield(player);
	player->sendCreatureShield(leader);

	player->addPartyInvitation(getParty());

	ss.str(std::string());
	ss << leader->getName() << " has invited you to " << leader->getPossessivePronoun() << " party (Share range: " << getMinLevel() << "-" << getMaxLevel() << ").";
	player->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, ss.str());

	return true;
}

bool Party::isPlayerInvited(const std::shared_ptr<Player> &player) const {
	return std::find(inviteList.begin(), inviteList.end(), player) != inviteList.end();
}

void Party::updateAllPartyIcons() {
	auto leader = getLeader();
	if (!leader) {
		return;
	}
	auto members = getMembers();
	for (auto member : members) {
		for (auto otherMember : members) {
			member->sendPartyCreatureShield(otherMember);
		}

		member->sendPartyCreatureShield(leader);
		leader->sendPartyCreatureShield(member);
	}
	leader->sendPartyCreatureShield(leader);
	updateTrackerAnalyzer();
}

void Party::broadcastPartyMessage(MessageClasses msgClass, const std::string &msg, bool sendToInvitations /*= false*/) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}
	for (auto member : getMembers()) {
		member->sendTextMessage(msgClass, msg);
	}

	leader->sendTextMessage(msgClass, msg);

	if (sendToInvitations) {
		for (auto invitee : getInvitees()) {
			invitee->sendTextMessage(msgClass, msg);
		}
	}
}

void Party::updateSharedExperience() {
	if (sharedExpActive) {
		bool result = getSharedExperienceStatus() == SHAREDEXP_OK;
		if (result != sharedExpEnabled) {
			sharedExpEnabled = result;
			updateAllPartyIcons();
		}
	}
}

const char* Party::getSharedExpReturnMessage(SharedExpStatus_t value) {
	switch (value) {
		case SHAREDEXP_OK:
			return "Shared Experience is now active.";
		case SHAREDEXP_TOOFARAWAY:
			return "Shared Experience has been activated, but some members of your party are too far away.";
		case SHAREDEXP_LEVELDIFFTOOLARGE:
			return "Shared Experience has been activated, but the level spread of your party is too wide.";
		case SHAREDEXP_MEMBERINACTIVE:
			return "Shared Experience has been activated, but some members of your party are inactive.";
		case SHAREDEXP_EMPTYPARTY:
			return "Shared Experience has been activated, but you are alone in your party.";
		default:
			return "An error occured. Unable to activate shared experience.";
	}
}

bool Party::setSharedExperience(std::shared_ptr<Player> player, bool newSharedExpActive, bool silent /*= false*/) {
	auto leader = getLeader();
	if (!player || leader != player) {
		return false;
	}

	if (this->sharedExpActive == newSharedExpActive) {
		return true;
	}

	this->sharedExpActive = newSharedExpActive;

	if (newSharedExpActive) {
		SharedExpStatus_t sharedExpStatus = getSharedExperienceStatus();
		this->sharedExpEnabled = sharedExpStatus == SHAREDEXP_OK;
		if (!silent) {
			leader->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, getSharedExpReturnMessage(sharedExpStatus));
		}
	} else {
		if (!silent) {
			leader->sendTextMessage(MESSAGE_PARTY_MANAGEMENT, "Shared Experience has been deactivated.");
		}
	}

	updateAllPartyIcons();
	return true;
}

void Party::shareExperience(uint64_t experience, std::shared_ptr<Creature> target /* = nullptr*/) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	uint64_t shareExperience = experience;
	g_events().eventPartyOnShareExperience(getParty(), shareExperience);
	g_callbacks().executeCallback(EventCallback_t::partyOnShareExperience, &EventCallback::partyOnShareExperience, getParty(), std::ref(shareExperience));

	for (auto member : getMembers()) {
		member->onGainSharedExperience(shareExperience, target);
	}
	leader->onGainSharedExperience(shareExperience, target);
}

bool Party::canUseSharedExperience(std::shared_ptr<Player> player) {
	return getMemberSharedExperienceStatus(player) == SHAREDEXP_OK;
}

SharedExpStatus_t Party::getMemberSharedExperienceStatus(std::shared_ptr<Player> player) {
	auto leader = getLeader();
	if (!leader) {
		return SHAREDEXP_EMPTYPARTY;
	}
	if (memberList.empty()) {
		return SHAREDEXP_EMPTYPARTY;
	}

	uint32_t highestLevel = getHighestLevel();
	uint32_t minLevel = getMinLevel();
	if (player->getLevel() < minLevel) {
		return SHAREDEXP_LEVELDIFFTOOLARGE;
	}

	if (!Position::areInRange<30, 30, 1>(leader->getPosition(), player->getPosition())) {
		return SHAREDEXP_TOOFARAWAY;
	}

	if (!player->hasFlag(PlayerFlags_t::NotGainInFight)) {
		if (!isPlayerActive(player)) {
			return SHAREDEXP_MEMBERINACTIVE;
		}
	}
	return SHAREDEXP_OK;
}

uint32_t Party::getHighestLevel() {
	auto leader = getLeader();
	if (!leader) {
		return 0;
	}

	uint32_t highestLevel = leader->getLevel();
	for (auto member : getMembers()) {
		if (member->getLevel() > highestLevel) {
			highestLevel = member->getLevel();
		}
	}
	return highestLevel;
}

uint32_t Party::getMinLevel() {
	return static_cast<uint32_t>(std::ceil((static_cast<float>(getHighestLevel()) * 2) / 3));
}

uint32_t Party::getLowestLevel() {
	auto leader = getLeader();
	if (!leader) {
		return 0;
	}
	uint32_t lowestLevel = leader->getLevel();
	for (auto member : getMembers()) {
		if (member->getLevel() < lowestLevel) {
			lowestLevel = member->getLevel();
		}
	}
	return lowestLevel;
}

uint32_t Party::getMaxLevel() {
	return static_cast<uint32_t>(std::floor((static_cast<float>(getLowestLevel()) * 3) / 2));
}

bool Party::isPlayerActive(std::shared_ptr<Player> player) {
	auto it = ticksMap.find(player->getID());
	if (it == ticksMap.end()) {
		return false;
	}

	uint64_t timeDiff = OTSYS_TIME() - it->second;
	return timeDiff <= 2 * 60 * 1000;
}

SharedExpStatus_t Party::getSharedExperienceStatus() {
	auto leader = getLeader();
	if (!leader) {
		return SHAREDEXP_EMPTYPARTY;
	}
	SharedExpStatus_t leaderStatus = getMemberSharedExperienceStatus(leader);
	if (leaderStatus != SHAREDEXP_OK) {
		return leaderStatus;
	}

	for (auto member : getMembers()) {
		SharedExpStatus_t memberStatus = getMemberSharedExperienceStatus(member);
		if (memberStatus != SHAREDEXP_OK) {
			return memberStatus;
		}
	}
	return SHAREDEXP_OK;
}

void Party::updatePlayerTicks(std::shared_ptr<Player> player, uint32_t points) {
	if (points != 0 && !player->hasFlag(PlayerFlags_t::NotGainInFight)) {
		ticksMap[player->getID()] = OTSYS_TIME();
		updateSharedExperience();
	}
}

void Party::clearPlayerPoints(std::shared_ptr<Player> player) {
	auto it = ticksMap.find(player->getID());
	if (it != ticksMap.end()) {
		ticksMap.erase(it);
		updateSharedExperience();
	}
}

bool Party::canOpenCorpse(uint32_t ownerId) const {
	auto leader = getLeader();
	if (!leader) {
		return false;
	}

	if (std::shared_ptr<Player> player = g_game().getPlayerByID(ownerId)) {
		return leader->getID() == ownerId || player->getParty().get() == this;
	}
	return false;
}

void Party::showPlayerStatus(std::shared_ptr<Player> player, std::shared_ptr<Player> member, bool showStatus) {
	player->sendPartyCreatureShowStatus(member, showStatus);
	member->sendPartyCreatureShowStatus(player, showStatus);
	if (showStatus) {
		for (const auto &summon : member->getSummons()) {
			player->sendPartyCreatureShowStatus(summon, showStatus);
			player->sendPartyCreatureHealth(summon, std::ceil((static_cast<double>(summon->getHealth()) / std::max<int32_t>(summon->getMaxHealth(), 1)) * 100));
		}
		for (const auto &summon : player->getSummons()) {
			member->sendPartyCreatureShowStatus(summon, showStatus);
			member->sendPartyCreatureHealth(summon, std::ceil((static_cast<double>(summon->getHealth()) / std::max<int32_t>(summon->getMaxHealth(), 1)) * 100));
		}
		player->sendPartyCreatureHealth(member, std::ceil((static_cast<double>(member->getHealth()) / std::max<int32_t>(member->getMaxHealth(), 1)) * 100));
		member->sendPartyCreatureHealth(player, std::ceil((static_cast<double>(player->getHealth()) / std::max<int32_t>(player->getMaxHealth(), 1)) * 100));
		player->sendPartyPlayerMana(member, std::ceil((static_cast<double>(member->getMana()) / std::max<int32_t>(member->getMaxMana(), 1)) * 100));
		member->sendPartyPlayerMana(player, std::ceil((static_cast<double>(player->getMana()) / std::max<int32_t>(player->getMaxMana(), 1)) * 100));
	} else {
		for (const auto &summon : player->getSummons()) {
			member->sendPartyCreatureShowStatus(summon, showStatus);
		}
		for (const auto &summon : member->getSummons()) {
			player->sendPartyCreatureShowStatus(summon, showStatus);
		}
	}
}

void Party::updatePlayerStatus(std::shared_ptr<Player> player) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	int32_t maxDistance = g_configManager().getNumber(PARTY_LIST_MAX_DISTANCE, __FUNCTION__);
	for (auto member : getMembers()) {
		bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), member->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), member->getPosition()) <= maxDistance));
		if (condition) {
			showPlayerStatus(player, member, true);
		} else {
			showPlayerStatus(player, member, false);
		}
	}
	bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), leader->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), leader->getPosition()) <= maxDistance));
	if (condition) {
		showPlayerStatus(player, leader, true);
	} else {
		showPlayerStatus(player, leader, false);
	}
}

void Party::updatePlayerStatus(std::shared_ptr<Player> player, const Position &oldPos, const Position &newPos) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	int32_t maxDistance = g_configManager().getNumber(PARTY_LIST_MAX_DISTANCE, __FUNCTION__);
	if (maxDistance != 0) {
		for (auto member : getMembers()) {
			bool condition1 = (Position::getDistanceX(oldPos, member->getPosition()) <= maxDistance && Position::getDistanceY(oldPos, member->getPosition()) <= maxDistance);
			bool condition2 = (Position::getDistanceX(newPos, member->getPosition()) <= maxDistance && Position::getDistanceY(newPos, member->getPosition()) <= maxDistance);
			if (condition1 && !condition2) {
				showPlayerStatus(player, member, false);
			} else if (!condition1 && condition2) {
				showPlayerStatus(player, member, true);
			}
		}

		bool condition1 = (Position::getDistanceX(oldPos, leader->getPosition()) <= maxDistance && Position::getDistanceY(oldPos, leader->getPosition()) <= maxDistance);
		bool condition2 = (Position::getDistanceX(newPos, leader->getPosition()) <= maxDistance && Position::getDistanceY(newPos, leader->getPosition()) <= maxDistance);
		if (condition1 && !condition2) {
			showPlayerStatus(player, leader, false);
		} else if (!condition1 && condition2) {
			showPlayerStatus(player, leader, true);
		}
	}
}

void Party::updatePlayerHealth(std::shared_ptr<Player> player, std::shared_ptr<Creature> target, uint8_t healthPercent) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	int32_t maxDistance = g_configManager().getNumber(PARTY_LIST_MAX_DISTANCE, __FUNCTION__);
	auto playerPosition = player->getPosition();
	auto leaderPosition = leader->getPosition();
	for (auto member : getMembers()) {
		auto memberPosition = member->getPosition();
		bool condition = (maxDistance == 0 || (Position::getDistanceX(playerPosition, memberPosition) <= maxDistance && Position::getDistanceY(playerPosition, memberPosition) <= maxDistance));
		if (condition) {
			member->sendPartyCreatureHealth(target, healthPercent);
		}
	}
	bool condition = (maxDistance == 0 || (Position::getDistanceX(playerPosition, leaderPosition) <= maxDistance && Position::getDistanceY(playerPosition, leaderPosition) <= maxDistance));
	if (condition) {
		leader->sendPartyCreatureHealth(target, healthPercent);
	}
}

void Party::updatePlayerMana(std::shared_ptr<Player> player, uint8_t manaPercent) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	int32_t maxDistance = g_configManager().getNumber(PARTY_LIST_MAX_DISTANCE, __FUNCTION__);
	for (auto member : getMembers()) {
		bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), member->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), member->getPosition()) <= maxDistance));
		if (condition) {
			member->sendPartyPlayerMana(player, manaPercent);
		}
	}
	bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), leader->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), leader->getPosition()) <= maxDistance));
	if (condition) {
		leader->sendPartyPlayerMana(player, manaPercent);
	}
}

void Party::updatePlayerVocation(std::shared_ptr<Player> player) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	int32_t maxDistance = g_configManager().getNumber(PARTY_LIST_MAX_DISTANCE, __FUNCTION__);
	for (auto member : getMembers()) {
		bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), member->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), member->getPosition()) <= maxDistance));
		if (condition) {
			member->sendPartyPlayerVocation(player);
		}
	}
	bool condition = (maxDistance == 0 || (Position::getDistanceX(player->getPosition(), leader->getPosition()) <= maxDistance && Position::getDistanceY(player->getPosition(), leader->getPosition()) <= maxDistance));
	if (condition) {
		leader->sendPartyPlayerVocation(player);
	}
}

void Party::updateTrackerAnalyzer() {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	for (auto member : getMembers()) {
		member->updatePartyTrackerAnalyzer();
	}

	leader->updatePartyTrackerAnalyzer();
}

void Party::addPlayerLoot(std::shared_ptr<Player> player, std::shared_ptr<Item> item) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	auto playerAnalyzer = getPlayerPartyAnalyzerStruct(player->getID());
	if (!playerAnalyzer) {
		playerAnalyzer = std::make_shared<PartyAnalyzer>(player->getID(), player->getName());
		membersData.push_back(playerAnalyzer);
	}

	uint32_t count = std::max<uint32_t>(1, item->getItemCount());
	if (auto it = playerAnalyzer->lootMap.find(item->getID()); it != playerAnalyzer->lootMap.end()) {
		(*it).second += count;
	} else {
		playerAnalyzer->lootMap.insert({ item->getID(), count });
	}

	if (priceType == LEADER_PRICE) {
		playerAnalyzer->lootPrice += leader->getItemCustomPrice(item->getID()) * count;
	} else {
		std::map<uint16_t, uint64_t> itemMap { { item->getID(), count } };
		playerAnalyzer->lootPrice += g_game().getItemMarketPrice(itemMap, false);
	}
	updateTrackerAnalyzer();
}

void Party::addPlayerSupply(std::shared_ptr<Player> player, std::shared_ptr<Item> item) {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	std::shared_ptr<PartyAnalyzer> playerAnalyzer = getPlayerPartyAnalyzerStruct(player->getID());
	if (!playerAnalyzer) {
		playerAnalyzer = std::make_shared<PartyAnalyzer>(player->getID(), player->getName());
		membersData.push_back(playerAnalyzer);
	}

	if (auto it = playerAnalyzer->supplyMap.find(item->getID()); it != playerAnalyzer->supplyMap.end()) {
		(*it).second += 1;
	} else {
		playerAnalyzer->supplyMap.insert({ item->getID(), 1 });
	}

	if (priceType == LEADER_PRICE) {
		playerAnalyzer->supplyPrice += leader->getItemCustomPrice(item->getID(), true);
	} else {
		std::map<uint16_t, uint64_t> itemMap { { item->getID(), 1 } };
		playerAnalyzer->supplyPrice += g_game().getItemMarketPrice(itemMap, true);
	}
	updateTrackerAnalyzer();
}

void Party::addPlayerDamage(std::shared_ptr<Player> player, uint64_t amount) {
	auto playerAnalyzer = getPlayerPartyAnalyzerStruct(player->getID());
	if (!playerAnalyzer) {
		playerAnalyzer = std::make_shared<PartyAnalyzer>(player->getID(), player->getName());
		membersData.push_back(playerAnalyzer);
	}

	playerAnalyzer->damage += amount;
	updateTrackerAnalyzer();
}

void Party::addPlayerHealing(std::shared_ptr<Player> player, uint64_t amount) {
	auto playerAnalyzer = getPlayerPartyAnalyzerStruct(player->getID());
	if (!playerAnalyzer) {
		playerAnalyzer = std::make_shared<PartyAnalyzer>(player->getID(), player->getName());
		membersData.push_back(playerAnalyzer);
	}

	playerAnalyzer->healing += amount;
	updateTrackerAnalyzer();
}

void Party::switchAnalyzerPriceType() {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	priceType = priceType == LEADER_PRICE ? MARKET_PRICE : LEADER_PRICE;
	reloadPrices();
	updateTrackerAnalyzer();
}

void Party::resetAnalyzer() {
	trackerTime = time(nullptr);
	membersData.clear();
	updateTrackerAnalyzer();
}

void Party::reloadPrices() {
	auto leader = getLeader();
	if (!leader) {
		return;
	}

	for (const auto &analyzer : membersData) {
		if (priceType == MARKET_PRICE) {
			analyzer->lootPrice = g_game().getItemMarketPrice(analyzer->lootMap, false);
			analyzer->supplyPrice = g_game().getItemMarketPrice(analyzer->supplyMap, true);
			continue;
		}

		analyzer->lootPrice = 0;
		for (const auto it : analyzer->lootMap) {
			analyzer->lootPrice += leader->getItemCustomPrice(it.first) * it.second;
		}

		analyzer->supplyPrice = 0;
		for (const auto it : analyzer->supplyMap) {
			analyzer->supplyPrice += leader->getItemCustomPrice(it.first, true) * it.second;
		}
	}
}
