local callback = EventCallback()

function callback.playerOnLookInTrade(player, partner, item, distance)
	player:sendTextMessage(MESSAGE_LOOK, "You see " .. item:getDescription(distance))
end

callback:register()
