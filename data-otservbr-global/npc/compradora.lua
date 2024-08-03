local npcName = "Compradora"

local npcType = Game.createNpcType(npcName)
local npcConfig = {}

npcConfig.name = npcName
npcConfig.description = npcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 1772,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 2
}

npcConfig.voices = {
	interval = 15000,
	chance = 20,
	{ text = "Aqui Ce vende tudo tche!" }
}

npcConfig.sounds = {
	ticks = 5000,
	chance = 25,
	ids = {
		SOUND_EFFECT_TYPE_ACTION_HITING_FORGE,
		SOUND_EFFECT_TYPE_ACTION_WOOD_HIT,
		SOUND_EFFECT_TYPE_ACTION_CRATE_BREAK_MAGIC_DUST,
		SOUND_EFFECT_TYPE_ACTION_SWORD_DRAWN
	}
}

npcConfig.flags = {
	floorchange = false
}

-- Npc shop
npcConfig.shop = {
	{ itemName = "ragnir helmet", clientId = 7462, sell = 400 },
	{ itemName = "relic sword", clientId = 7383, sell = 25000 },
	{ itemName = "rift bow", clientId = 22866, sell = 45000 },
	{ itemName = "eternal ultimate spirit potion", clientId = 45237, buy = 898},
	{ itemName = "eternal supreme health potion", clientId = 23375, buy = 925 },
	{ itemName = "eternal ultimate mana potion", clientId = 45236, buy = 738 },	
	{ itemName = "rift crossbow", clientId = 22867, sell = 45000 },
	{ itemName = "rift lance", clientId = 22727, sell = 30000 },
	{ itemName = "rift shield", clientId = 22726, sell = 50000 },
	{ itemName = "ring of the sky", clientId = 3006, sell = 30000 },
	{ itemName = "royal axe", clientId = 7434, sell = 40000 },
	{ itemName = "ruby necklace", clientId = 3016, sell = 2000 },
	{ itemName = "ruthless axe", clientId = 6553, sell = 45000 },
	{ itemName = "sacred tree amulet", clientId = 9302, sell = 3000 },
	{ itemName = "sapphire hammer", clientId = 7437, sell = 7000 },
	{ itemName = "scarab amulet", clientId = 3018, sell = 200 },
	{ itemName = "scarab shield", clientId = 3440, sell = 2000 },
	{ itemName = "shockwave amulet", clientId = 9304, sell = 3000 },
	{ itemName = "silver brooch", clientId = 3017, sell = 150 },
	{ itemName = "silver dagger", clientId = 3290, sell = 500 },
	{ itemName = "skull helmet", clientId = 5741, sell = 40000 },
	{ itemName = "skullcracker armor", clientId = 8061, sell = 18000 },
	{ itemName = "spiked squelcher", clientId = 7452, sell = 5000 },
	{ itemName = "steel boots", clientId = 3554, sell = 30000 },
	{ itemName = "swamplair armor", clientId = 8052, sell = 16000 },
	{ itemName = "taurus mace", clientId = 7425, sell = 500 },
	{ itemName = "tempest shield", clientId = 3442, sell = 35000 },
	{ itemName = "terra amulet", clientId = 814, sell = 1500 },
	{ itemName = "terra boots", clientId = 813, sell = 2500 },
	{ itemName = "terra hood", clientId = 830, sell = 2500 },
	{ itemName = "terra legs", clientId = 812, sell = 11000 },
	{ itemName = "terra mantle", clientId = 811, sell = 11000 },
	{ itemName = "the justice seeker", clientId = 7390, sell = 40000 },
	{ itemName = "tortoise shield", clientId = 6131, sell = 150 },
	{ itemName = "vile axe", clientId = 7388, sell = 30000 },
	{ itemName = "voodoo doll", clientId = 3002, sell = 400 },
	{ itemName = "war axe", clientId = 3342, sell = 12000 },
	{ itemName = "war horn", clientId = 2958, sell = 8000 },
	{ itemName = "witch hat", clientId = 9653, sell = 5000 },
	{ itemName = "wyvern fang", clientId = 7408, sell = 1500 },
	{ itemName = "ankh", clientId = 3214, sell = 100 },
	{ itemName = "dragon necklace", clientId = 3085, buy = 1000, sell = 100, count = 200 },
	{ itemName = "dwarven ring", clientId = 3097, buy = 2000, sell = 100 },
	{ itemName = "energy ring", clientId = 3051, buy = 2000, sell = 100 },
	{ itemName = "glacial rod", clientId = 16118, sell = 6500 },
	{ itemName = "hailstorm rod", clientId = 3067, sell = 3000 },
	{ itemName = "life ring", clientId = 3052, buy = 900, sell = 50 },
	{ itemName = "might ring", clientId = 3048, buy = 5000, sell = 250, count = 20 },
	{ itemName = "moonlight rod", clientId = 3070, sell = 200 },
	{ itemName = "muck rod", clientId = 16117, sell = 6000 },
	{ itemName = "mysterious fetish", clientId = 3078, sell = 50 },
	{ itemName = "necrotic rod", clientId = 3069, sell = 1000 },
	{ itemName = "northwind rod", clientId = 8083, sell = 1500 },
	{ itemName = "protection amulet", clientId = 3084, buy = 700, sell = 100, count = 250 },
	{ itemName = "ring of healing", clientId = 3098, buy = 2000, sell = 100 },
	{ itemName = "silver amulet", clientId = 3054, buy = 100, sell = 50, count = 200 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 100 },
	{ itemName = "springsprout rod", clientId = 8084, sell = 3600 },
	{ itemName = "strange talisman", clientId = 3045, buy = 100, sell = 30, count = 200 },
	{ itemName = "terra rod", clientId = 3065, sell = 2000 },
	{ itemName = "time ring", clientId = 3053, buy = 2000, sell = 100 },
	{ itemName = "underworld rod", clientId = 8082, sell = 4400 },
	{ itemName = "Broken Slicer", clientId = 11661, sell = 120 },
	{ itemName = "Elite Draken Mail", clientId = 11651, sell = 50000 },
	{ itemName = "axe", clientId = 3274, sell = 7 },
	{ itemName = "battle axe", clientId = 3266, sell = 80 },
	{ itemName = "battle hammer", clientId = 3305, sell = 120 },
	{ itemName = "battle shield", clientId = 3305, sell = 95 },
	{ itemName = "bone shoulderplate", clientId = 10404, sell = 150 },
	{ itemName = "brass armor", clientId = 3359, sell = 150 },
	{ itemName = "brass helmet", clientId = 3354, sell = 30 },
	{ itemName = "brass legs", clientId = 3372, sell = 49 },
	{ itemName = "brass shield", clientId = 3411, sell = 25 },
	{ itemName = "broken draken mail", clientId = 11660, sell = 340 },
	{ itemName = "broken halberd", clientId = 10418, sell = 100 },
	{ itemName = "broken slicer", clientId = 11661, sell = 120 },
	{ itemName = "carlin sword", clientId = 3283, sell = 118 },
	{ itemName = "chain armor", clientId = 3358, sell = 70 },
	{ itemName = "chain helmet", clientId = 3352, sell = 17 },
	{ itemName = "chain legs", clientId = 3558, sell = 25 },
	{ itemName = "club", clientId = 3270, sell = 1 },
	{ itemName = "coat", clientId = 3562, sell = 1 },
	{ itemName = "crowbar", clientId = 3304, sell = 50 },
	{ itemName = "cursed shoulder spikes", clientId = 10410, sell = 320 },
	{ itemName = "dagger", clientId = 3267, sell = 2 },
	{ itemName = "doublet", clientId = 3379, sell = 3 },
	{ itemName = "drachaku", clientId = 10391, sell = 10000 },
	{ itemName = "draken boots", clientId = 4033, sell = 40000 },
	{ itemName = "draken wristbands", clientId = 11659, sell = 430 },
	{ itemName = "drakinata", clientId = 10388, sell = 10000 },
	{ itemName = "dwarven shield", clientId = 3425, sell = 100 },
	{ itemName = "elite draken mail", clientId = 11651, sell = 50000 },
	{ itemName = "guardian boots", clientId = 10323, sell = 35000 },
	{ itemName = "hand axe", clientId = 3268, sell = 4 },
	{ itemName = "high guard's shoulderplates", clientId = 10416, sell = 130 },
	{ itemName = "leather armor", clientId = 3361, sell = 12 },
	{ itemName = "leather boots", clientId = 3552, sell = 2 },
	{ itemName = "leather helmet", clientId = 3355, sell = 9 },
	{ itemName = "leather legs", clientId = 3559, sell = 9 },
	{ itemName = "lizard weapon rack kit", clientId = 10209, buy = 500 },
	{ itemName = "longsword", clientId = 3285, sell = 51 },
	{ itemName = "mace", clientId = 3286, sell = 30 },
	{ itemName = "morning star", clientId = 3282, sell = 100 },
	{ itemName = "plate armor", clientId = 3357, sell = 400 },
	{ itemName = "plate shield", clientId = 3410, sell = 45 },
	{ itemName = "rapier", clientId = 3272, sell = 5 },
	{ itemName = "sabre", clientId = 3273, sell = 12 },
	{ itemName = "sais", clientId = 10389, sell = 16500 },
	{ itemName = "scale armor", clientId = 3377, sell = 75 },
	{ itemName = "short sword", clientId = 3294, sell = 10 },
	{ itemName = "sickle", clientId = 3293, sell = 3 },
	{ itemName = "soldier helmet", clientId = 3375, sell = 16 },
	{ itemName = "spear", clientId = 3277, sell = 3 },
	{ itemName = "spike sword", clientId = 3271, sell = 240 },
	{ itemName = "spiked iron ball", clientId = 10408, sell = 100 },
	{ itemName = "steel helmet", clientId = 3351, sell = 293 },
	{ itemName = "steel shield", clientId = 3409, sell = 80 },
	{ itemName = "studded armor", clientId = 3378, sell = 25 },
	{ itemName = "studded helmet", clientId = 3376, sell = 20 },
	{ itemName = "studded legs", clientId = 3362, sell = 15 },
	{ itemName = "studded shield", clientId = 3426, sell = 16 },
	{ itemName = "swampling club", clientId = 17824, sell = 40 },
	{ itemName = "sword", clientId = 3264, sell = 25 },
	{ itemName = "throwing knife", clientId = 3298, buy = 25 },
	{ itemName = "twiceslicer", clientId = 11657, sell = 28000 },
	{ itemName = "twin hooks", clientId = 10392, sell = 500 },
	{ itemName = "two handed sword", clientId = 3265, sell = 450 },
	{ itemName = "wailing widow's necklace", clientId = 10412, sell = 3000 },
	{ itemName = "warmaster's wristguards", clientId = 10405, sell = 200 },
	{ itemName = "wooden shield", clientId = 3412, sell = 3 },
	{ itemName = "zaoan armor", clientId = 10384, sell = 14000 },
	{ itemName = "zaoan halberd", clientId = 10406, sell = 500 },
	{ itemName = "zaoan helmet", clientId = 10385, sell = 45000 },
	{ itemName = "zaoan legs", clientId = 10387, sell = 14000 },
	-- 3 tomes
	{itemName = "lizard weapon rack kit", clientId = 10209, buy = 500},
	-- 9 tomes
	{itemName = "bone shoulderplate", clientId = 10404, sell = 150},
	{itemName = "broken draken mail", clientId = 11660, sell = 340},
	{itemName = "broken halberd", clientId = 10418, sell = 100},
	{itemName = "Broken Slicer", clientId = 11661, sell = 120},
	{itemName = "cursed shoulder spikes", clientId = 10410, sell = 320},
	{itemName = "drachaku", clientId = 10391, sell = 10000},
	{itemName = "draken boots", clientId = 4033, sell = 40000},
	{itemName = "draken wristbands", clientId = 11659, sell = 430},
	{itemName = "drakinata", clientId = 10388, sell = 10000},
	{itemName = "Elite Draken Mail", clientId = 11651, sell = 50000},
	{itemName = "guardian boots", clientId = 10323, sell = 35000},
	{itemName = "high guard's shoulderplates", clientId = 10416, sell = 130},
	{itemName = "sais", clientId = 10389, sell = 16500},
	{itemName = "spiked iron ball", clientId = 10408, sell = 100},
	{itemName = "twiceslicer", clientId = 11657, sell = 28000},
	{itemName = "twin hooks", clientId = 10392, buy = 1100, sell = 500},
	{itemName = "wailing widow's necklace", clientId = 10412, sell = 3000},
	{itemName = "warmaster's wristguards", clientId = 10405, sell = 200},
	{itemName = "zaoan armor", clientId = 10384, sell = 14000},
	{itemName = "zaoan halberd", clientId = 10406, buy = 1200, sell = 500},
	{itemName = "zaoan helmet", clientId = 10385, sell = 45000},
	{itemName = "zaoan legs", clientId = 10387, sell = 14000},
	{itemName = "zaoan shoes", clientId = 10386, sell = 5000},
	{itemName = "zaoan sword", clientId = 10390, sell = 30000},
	{itemName = "zaogun's shoulderplates", clientId = 10414, sell = 150},
	{ itemName = "ancient shield", clientId = 3432, buy = 5000, sell = 900 },
	{ itemName = "black shield", clientId = 3429, sell = 800 },
	{ itemName = "bonebreaker", clientId = 7428, sell = 10000 },
	{ itemName = "dark armor", clientId = 3383, buy = 1500, sell = 400 },
	{ itemName = "dark helmet", clientId = 3384, buy = 1000, sell = 250 },
	{ itemName = "dragon hammer", clientId = 3322, sell = 2000 },
	{ itemName = "dreaded cleaver", clientId = 7419, sell = 15000 },
	{ itemName = "giant sword", clientId = 3281, sell = 17000 },
	{ itemName = "haunted blade", clientId = 7407, sell = 8000 },
	{ itemName = "ice rapier", clientId = 3284, buy = 5000 },
	{ itemName = "knight armor", clientId = 3370, sell = 5000 },
	{ itemName = "knight axe", clientId = 3318, sell = 2000 },
	{ itemName = "knight legs", clientId = 3371, sell = 5000 },
	{ itemName = "mystic turban", clientId = 3574, sell = 150 },
	{ itemName = "onyx flail", clientId = 7421, sell = 22000 },
	{ itemName = "ornamented axe", clientId = 7411, sell = 20000 },
	{ itemName = "poison dagger", clientId = 3299, sell = 50 },
	{ itemName = "scimitar", clientId = 3307, sell = 150 },
	{ itemName = "serpent sword", clientId = 3297, buy = 6000, sell = 900 },
	{ itemName = "skull staff", clientId = 3324, sell = 6000 },
	{ itemName = "strange helmet", clientId = 3373, sell = 500 },
	{ itemName = "titan axe", clientId = 7413, sell = 4000 },
	{ itemName = "tower shield", clientId = 3428, sell = 8000 },
	{ itemName = "vampire shield", clientId = 3434, sell = 15000 },
	{ itemName = "warrior helmet", clientId = 3369, sell = 5000 },
	{ itemName = "axe ring", clientId = 3092, buy = 500, sell = 100 },
	{ itemName = "bronze amulet", clientId = 3056, buy = 100, sell = 50, count = 200 },
	{ itemName = "club ring", clientId = 3093, buy = 500, sell = 100 },
	{ itemName = "elven amulet", clientId = 3082, buy = 500, sell = 100, count = 50 },
	{ itemName = "garlic necklace", clientId = 3083, buy = 100, sell = 50 },
	{ itemName = "life crystal", clientId = 4840, sell = 50 },
	{ itemName = "magic light wand", clientId = 3046, buy = 120, sell = 35 },
	{ itemName = "mind stone", clientId = 3062, sell = 100 },
	{ itemName = "orb", clientId = 3060, sell = 750 },
	{ itemName = "power ring", clientId = 3050, buy = 100, sell = 50 },
	{ itemName = "stealth ring", clientId = 3049, buy = 5000, sell = 200 },
	{ itemName = "stone skin amulet", clientId = 3081, buy = 5000, sell = 500, count = 5 },
	{ itemName = "sword ring", clientId = 3091, buy = 500, sell = 100 },
	{ itemName = "wand of cosmic energy", clientId = 3073, sell = 2000 },
	{ itemName = "wand of cosmic energy", clientId = 3073, sell = 2000 },
	{ itemName = "wand of decay", clientId = 3072, sell = 1000 },
	{ itemName = "wand of defiance", clientId = 16096, sell = 6500 },
	{ itemName = "wand of draconia", clientId = 8093, sell = 1500 },
	{ itemName = "wand of dragonbreath", clientId = 3075, sell = 200 },
	{ itemName = "wand of everblazing", clientId = 16115, sell = 6000 },
	{ itemName = "wand of inferno", clientId = 3071, sell = 3000 },
	{ itemName = "wand of starstorm", clientId = 8092, sell = 3600 },
	{ itemName = "blue gem", clientId = 3041, sell = 5000 },
	{ itemName = "golden mug", clientId = 2903, sell = 250 },
	{ itemName = "green gem", clientId = 3038, sell = 5000 },
	{ itemName = "red gem", clientId = 3039, sell = 1000 },
	{ itemName = "violet gem", clientId = 3036, sell = 10000 },
	{ itemName = "white gem", clientId = 32769, sell = 12000 },
	{ itemName = "yellow gem", clientId = 3037, sell = 1000 },
	{ itemName = "batwing hat", clientId = 9103, sell = 8000 },
	{ itemName = "ethno coat", clientId = 8064, buy = 750, sell = 200 },
	{ itemName = "focus cape", clientId = 8043, sell = 6000 },
	{ itemName = "jade hat", clientId = 10451, sell = 9000 },
	{ itemName = "magicians robe", clientId = 7991, buy = 450 },
	{ itemName = "spellweavers rob", clientId = 10438, sell = 12000 },
	{ itemName = "spirit cloak", clientId = 8042, buy = 1000, sell = 350 },
	{ itemName = "zaoan robe", clientId = 10439, sell = 12000 },
		{ itemName = "amber", clientId = 32626, sell = 20000 },
	{ itemName = "amber with a bug", clientId = 32624, sell = 41000 },
	{ itemName = "amber with a dragonfly", clientId = 32625, sell = 56000 },
	{ itemName = "ancient coin", clientId = 24390, sell = 350 },
	{ itemName = "black pearl", clientId = 3027, buy = 560, sell = 280 },
	{ itemName = "blue crystal shard", clientId = 16119, sell = 1500 },
	{ itemName = "blue crystal splinter", clientId = 16124, sell = 400 },
	{ itemName = "bronze goblet", clientId = 5807, buy = 2000 },
	{ itemName = "brown crystal splinter", clientId = 16123, sell = 400 },
	{ itemName = "brown shimmering pearl", clientId = 282, sell = 3000 },
	{ itemName = "coral brooch", clientId = 24391, sell = 750 },
	{ itemName = "crunor idol", clientId = 30055, sell = 30000 },
	{ itemName = "cyan crystal fragment", clientId = 16125, sell = 800 },
	{ itemName = "dragon figurine", clientId = 30053, sell = 45000 },
	{ itemName = "gemmed figurine", clientId = 24392, sell = 3500 },
	{ itemName = "giant amethyst", clientId = 30061, sell = 60000 },
	{ itemName = "giant emerald", clientId = 30060, sell = 90000 },
	{ itemName = "giant ruby", clientId = 30059, sell = 70000 },
	{ itemName = "giant sapphire", clientId = 30061, sell = 50000 },
	{ itemName = "giant topaz", clientId = 32623, sell = 80000 },
	{ itemName = "gold ingot", clientId = 9058, sell = 5000 },
	{ itemName = "gold nugget", clientId = 3040, sell = 850 },
	{ itemName = "golden amulet", clientId = 3013, buy = 6600 },
	{ itemName = "golden goblet", clientId = 5805, buy = 5000 },
	{ itemName = "green crystal fragment", clientId = 16127, sell = 800 },
	{ itemName = "green crystal shard", clientId = 16121, sell = 1500 },
	{ itemName = "green crystal splinter", clientId = 16122, sell = 400 },
	{ itemName = "green giant shimmering pearl", clientId = 281, sell = 3000 },
	{ itemName = "lion figurine", clientId = 33781, sell = 10000 },
	{ itemName = "onyx chip", clientId = 22193, sell = 400 },
	{ itemName = "opal", clientId = 22194, sell = 500 },
	{ itemName = "ornate locket", clientId = 30056, sell = 18000 },
	{ itemName = "prismatic quartz", clientId = 24962, sell = 450 },
	{ itemName = "red crystal fragment", clientId = 16126, sell = 800 },
	{ itemName = "ruby necklace", clientId = 3016, buy = 3560 },
	{ itemName = "silver goblet", clientId = 5806, buy = 3000 },
	{ itemName = "skull coin", clientId = 32583, sell = 12000 },
	{ itemName = "small amethyst", clientId = 3033, buy = 400, sell = 200 },
	{ itemName = "small diamond", clientId = 3028, buy = 600, sell = 300 },
	{ itemName = "small emerald", clientId = 3032, buy = 500, sell = 250 },
	{ itemName = "small enchanted amethyst", clientId = 678, sell = 200 },
	{ itemName = "small enchanted emerald", clientId = 677, sell = 250 },
	{ itemName = "small enchanted ruby", clientId = 676, sell = 250 },
	{ itemName = "small enchanted sapphire", clientId = 675, sell = 250 },
	{ itemName = "small ruby", clientId = 3030, buy = 500, sell = 250 },
	{ itemName = "small sapphire", clientId = 3029, buy = 500, sell = 250 },
	{ itemName = "small topaz", clientId = 9057, sell = 200 },
	{ itemName = "tiger eye", clientId = 24961, sell = 350 },
	{ itemName = "unicorn figurine", clientId = 30054, sell = 50000 },
	{ itemName = "violet crystal shard", clientId = 16120, sell = 1500 },
	{ itemName = "white silk flower", clientId = 34008, sell = 9000 },
	{ itemName = "wedding ring", clientId = 3004, buy = 990 },
	{ itemName = "white pearl", clientId = 3026, buy = 320 },
	{ itemName = "avalanche rune", clientId = 3161, buy = 57 },
		{ itemName = "stonerefiner's skull", clientId = 27606, sell = 100 },
	{ itemName = "strand of medusa hair", clientId = 10309, sell = 600 },
	{ itemName = "strange proto matter", clientId = 23513, sell = 300 },
	{ itemName = "strange symbol", clientId = 3058, sell = 200 },
	{ itemName = "striped fur", clientId = 10293, sell = 50 },
	{ itemName = "swamp grass", clientId = 9686, sell = 20 },
	{ itemName = "swampling moss", clientId = 17822, sell = 20 },
	{ itemName = "swarmer antenna", clientId = 14076, sell = 130 },
	{ itemName = "tail of corruption", clientId = 11672, sell = 240 },
	{ itemName = "tarantula egg", clientId = 10281, sell = 80 },
	{ itemName = "tarnished rhino figurine", clientId = 24387, sell = 320 },
	{ itemName = "tattered piece of robe", clientId = 9684, sell = 120 },
	{ itemName = "telescope eye", clientId = 33934, sell = 1600 },
	{ itemName = "tentacle of tentugly", clientId = 35611, sell = 27000 },
	{ itemName = "tentacle piece", clientId = 11666, sell = 5000 },
	{ itemName = "tentugly's eye", clientId = 35610, sell = 52000 },
	{ itemName = "tentugly's jaws", clientId = 35612, sell = 80000 },
	{ itemName = "terramite eggs", clientId = 10453, sell = 50 },
	{ itemName = "terramite legs", clientId = 10454, sell = 60 },
	{ itemName = "terramite shell", clientId = 10452, sell = 170 },
	{ itemName = "terrorbird beak", clientId = 10273, sell = 95 },
	{ itemName = "the handmaiden's protector", clientId = 6539, sell = 50000 },
	{ itemName = "the imperor's trident", clientId = 6534, sell = 50000 },
	{ itemName = "the plasmother's remains", clientId = 6535, sell = 50000 },
	{ itemName = "thick fur", clientId = 10307, sell = 150 },
	{ itemName = "thorn", clientId = 9643, sell = 100 },
	{ itemName = "tiara", clientId = 35578, sell = 11000 },
	{ itemName = "token of love", clientId = 31594, sell = 440000 },
	{ itemName = "tooth file", clientId = 18924, sell = 60 },
	{ itemName = "tooth of tazhadur", clientId = 24940, sell = 10000 },
	{ itemName = "torn shirt", clientId = 25744, sell = 250 },
	{ itemName = "trapped bad dream monster", clientId = 20203, sell = 900 },
	{ itemName = "troll green", clientId = 3741, sell = 25 },
	{ itemName = "trollroot", clientId = 11515, sell = 50 },
	{ itemName = "tunnel tyrant head", clientId = 27595, sell = 500 },
	{ itemName = "tunnel tyrant shell", clientId = 27596, sell = 700 },
	{ itemName = "turtle shell", clientId = 5899, sell = 90 },
	{ itemName = "tusk", clientId = 3044, sell = 100 },
	{ itemName = "undead heart", clientId = 10450, sell = 200 },
	{ itemName = "unholy bone", clientId = 10316, sell = 480 },
	{ itemName = "urmahlullus mane", clientId = 31623, sell = 490000 },
	{ itemName = "urmahlullus paws", clientId = 31624, sell = 245000 },
	{ itemName = "urmahlullus tail", clientId = 31622, sell = 210000 },
	{ itemName = "utua's poison", clientId = 34101, sell = 230 },
	{ itemName = "vampire dust", clientId = 5905, sell = 100 },
	{ itemName = "vampire teeth", clientId = 9685, sell = 275 },
	{ itemName = "vampire's cape chain", clientId = 18927, sell = 150 },
	{ itemName = "veal", clientId = 32009, sell = 40 },
	{ itemName = "venison", clientId = 18995, sell = 55 },
	{ itemName = "vexclaw talon", clientId = 22728, sell = 1100 },
	{ itemName = "vial of hatred", clientId = 33927, sell = 737000 },
	{ itemName = "vibrant heart", clientId = 34143, sell = 2100 },
	{ itemName = "vibrant robe", clientId = 34144, sell = 1200 },
	{ itemName = "violet glass plate", clientId = 29347, sell = 2150 },
	{ itemName = "volatile proto matter", clientId = 23514, sell = 300 },
	{ itemName = "warmaster's wristguards", clientId = 10405, sell = 200 },
	{ itemName = "warwolf fur", clientId = 10318, sell = 30 },
	{ itemName = "waspoid claw", clientId = 14080, sell = 320 },
	{ itemName = "waspoid wing", clientId = 14081, sell = 190 },
	{ itemName = "weaver's wandtip", clientId = 10397, sell = 250 },
	{ itemName = "werebadger claws", clientId = 22051, sell = 160 },
	{ itemName = "werebadger skull", clientId = 22055, sell = 185 },
	{ itemName = "werebear fur", clientId = 22057, sell = 85 },
	{ itemName = "werebear skull", clientId = 22056, sell = 195 },
	{ itemName = "wereboar hooves", clientId = 22053, sell = 175 },
	{ itemName = "wereboar tusks", clientId = 22054, sell = 165 },
	{ itemName = "werefox tail", clientId = 27463, sell = 200 },
	{ itemName = "werehyaena nose", clientId = 33943, sell = 220 },
	{ itemName = "werehyaena talisman", clientId = 33944, sell = 350 },
	{ itemName = "werewolf fangs", clientId = 22052, sell = 180 },
	{ itemName = "werewolf fur", clientId = 10317, sell = 380 },
	{ itemName = "white piece of cloth", clientId = 5909, sell = 100 },
	{ itemName = "widow's mandibles", clientId = 10411, sell = 110 },
	{ itemName = "wild flowers", clientId = 25684, sell = 120 },
	{ itemName = "wimp tooth chain", clientId = 17847, sell = 120 },
	{ itemName = "winged tail", clientId = 10313, sell = 800 },
	{ itemName = "winter wolf fur", clientId = 10295, sell = 20 },
	{ itemName = "witch broom", clientId = 9652, sell = 60 },
	{ itemName = "withered pauldrons", clientId = 27607, sell = 850 },
	{ itemName = "withered scalp", clientId = 27608, sell = 900 },
	{ itemName = "wolf paw", clientId = 5897, sell = 70 },
	{ itemName = "wood", clientId = 5901, sell = 5 },
	{ itemName = "wool", clientId = 10319, sell = 15 },
	{ itemName = "writhing brain", clientId = 32600, sell = 370000 },
	{ itemName = "writhing heart", clientId = 32599, sell = 185000 },
	{ itemName = "wyrm scale", clientId = 9665, sell = 400 },
	{ itemName = "wyvern talisman", clientId = 9644, sell = 265 },
	{ itemName = "yellow piece of cloth", clientId = 5914, sell = 150 },
	{ itemName = "yielowax", clientId = 12742, sell = 600 },
	{ itemName = "yirkas' egg", clientId = 34102, sell = 280 },
	{ itemName = "young lich worm", clientId = 31590, sell = 25000 },
	{ itemName = "zaogun flag", clientId = 10413, sell = 600 },
	{ itemName = "zaogun shoulderplates", clientId = 10414, sell = 150 },
		{ itemName = "angelic axe", clientId = 7436, sell = 5000 },
	{ itemName = "blue robe", clientId = 3567, sell = 10000 },
	{ itemName = "bonelord shield", clientId = 3418, buy = 7000, sell = 1200 },
	{ itemName = "boots of haste", clientId = 3079, sell = 30000 },
	{ itemName = "broadsword", clientId = 3301, sell = 500 },
	{ itemName = "butcher's axe", clientId = 7412, sell = 18000 },
	{ itemName = "crown armor", clientId = 3381, sell = 12000 },
	{ itemName = "crown helmet", clientId = 3385, sell = 2500 },
	{ itemName = "crown legs", clientId = 3382, sell = 12000 },
	{ itemName = "crown shield", clientId = 3419, sell = 8000 },
	{ itemName = "crusader helmet", clientId = 3391, sell = 6000 },
	{ itemName = "dragon lance", clientId = 3302, sell = 9000 },
	{ itemName = "dragon shield", clientId = 3416, sell = 4000 },
	{ itemName = "fire axe", clientId = 3320, sell = 8000 },
	{ itemName = "fire sword", clientId = 3280, sell = 4000 },
	{ itemName = "glorious axe", clientId = 7454, sell = 3000 },
	{ itemName = "guardian shield", clientId = 3415, sell = 2000 },
	{ itemName = "ice rapier", clientId = 3284, sell = 1000 },
	{ itemName = "noble armor", clientId = 3380, buy = 8000, sell = 900 },
	{ itemName = "obsidian lance", clientId = 3313, buy = 3000, sell = 500 },
	{ itemName = "phoenix shield", clientId = 3439, sell = 16000 },
	{ itemName = "queen's sceptre", clientId = 7410, sell = 20000 },
	{ itemName = "royal helmet", clientId = 3392, sell = 30000 },
	{ itemName = "shadow sceptre", clientId = 7451, sell = 10000 },
	{ itemName = "spike sword", clientId = 3271, buy = 8000, sell = 1000 },
	{ itemName = "thaian sword", clientId = 7391, sell = 16000 },
	{ itemName = "war hammer", clientId = 3279, buy = 10000, sell = 1200 },
	{ itemName = "abyss hammer", clientId = 7414, sell = 20000 },
	{ itemName = "albino plate", clientId = 19358, sell = 1500 },
	{ itemName = "amber staff", clientId = 7426, sell = 8000 },
	{ itemName = "ancient amulet", clientId = 3025, sell = 200 },
	{ itemName = "assassin dagger", clientId = 7404, sell = 20000 },
	{ itemName = "bandana", clientId = 5917, sell = 150 },
	{ itemName = "beastslayer axe", clientId = 3344, sell = 1500 },
	{ itemName = "beetle necklace", clientId = 10457, sell = 1500 },
	{ itemName = "berserker", clientId = 7403, sell = 40000 },
	{ itemName = "blacksteel sword", clientId = 7406, sell = 6000 },
	{ itemName = "blessed sceptre", clientId = 7429, sell = 40000 },
	{ itemName = "bone shield", clientId = 3441, sell = 80 },
	{ itemName = "bonelord helmet", clientId = 3408, sell = 7500 },
	{ itemName = "brutetamer's staff", clientId = 7379, sell = 1500 },
	{ itemName = "buckle", clientId = 17829, sell = 7000 },
	{ itemName = "castle shield", clientId = 3435, sell = 5000 },
	{ itemName = "chain bolter", clientId = 8022, sell = 40000 },
	{ itemName = "chaos mace", clientId = 7427, sell = 9000 },
	{ itemName = "cobra crown", clientId = 11674, sell = 50000 },
	{ itemName = "coconut shoes", clientId = 9017, sell = 500 },
	{ itemName = "blank rune", clientId = 3147, buy = 10 },
	{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
	{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
	{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
	{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
	{ itemName = "durable exercise rod", clientId = 35283, buy = 2945000, count = 7220 },
	{ itemName = "durable exercise sword", clientId = 35279, buy = 2945000, count = 7220 },
	{ itemName = "durable exercise axe", clientId = 35280, buy = 2945000, count = 7220 },
	{ itemName = "durable exercise club", clientId = 35281, buy = 2945000, count = 7220 },
	{ itemName = "durable exercise bow", clientId = 35282, buy = 2945000, count = 7220 },
	{ itemName = "durable exercise wand", clientId = 35284, buy = 2945000, count = 7220 },
	{ itemName = "empty potion flask", clientId = 283, sell = 5 },
	{ itemName = "empty potion flask", clientId = 284, sell = 5 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "energy field rune", clientId = 3164, buy = 38 },
	{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
	{ itemName = "exercise rod", clientId = 28556, buy = 262500, count = 500 },
	{ itemName = "exercise wand", clientId = 28557, buy = 262500, count = 500 },
	{ itemName = "explosion rune", clientId = 3200, buy = 31 },
	{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
	{ itemName = "fire field rune", clientId = 3188, buy = 28 },
	{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
	{ itemName = "great fireball rune", clientId = 3191, buy = 57 },
	{ itemName = "great health potion", clientId = 239, buy = 225 },
	{ itemName = "great mana potion", clientId = 238, buy = 144 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 228 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
	{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise sword", clientId = 35285, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise axe", clientId = 35286, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise club", clientId = 35287, buy = 7560000, count = 14400 },
	{ itemName = "lasting exercise bow", clientId = 35288, buy = 7560000, count = 14400 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 625 },
    { itemName = "ultimate spirit potion", clientId = 23374, buy = 438},
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 438 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
	{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
	{ itemName = "Springsprout Rod", clientId = 8084, buy = 3600 },
	{ itemName = "poison field rune", clientId = 3172, buy = 21 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
	{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
	{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
	{ itemName = "spellbook", clientId = 3059, buy = 150 },
	{ itemName = "spellwand", clientId = 651, sell = 299 },
	{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
	{ itemName = "strong health potion", clientId = 236, buy = 115 },
	{ itemName = "strong mana potion", clientId = 237, buy = 93 },
	{ itemName = "sudden death rune", clientId = 3155, buy = 135 },
	{ itemName = "terra rod", clientId = 3065, buy = 10000 },
	{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 379 },
	{ itemName = "vial", clientId = 2874, sell = 5 },
	{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
	{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
	{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
	{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
		{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "assassin star", clientId = 7368, buy = 100 },
	{ itemName = "blue quiver", clientId = 35848, buy = 400 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "bow", clientId = 3350, buy = 400 },
	{ itemName = "burst arrow", clientId = 3449, buy = 10 },
	{ itemName = "crossbow", clientId = 3349, buy = 250 },
	{ itemName = "crystalline arrow", clientId = 15793, buy = 20 },
	{ itemName = "diamond arrow", clientId = 35901, buy = 100 },
	{ itemName = "drill bolt", clientId = 16142, buy = 12 },
	{ itemName = "earth arrow", clientId = 774, buy = 5 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 12 },
	{ itemName = "flaming arrow", clientId = 763, buy = 5 },
	{ itemName = "flash arrow", clientId = 761, buy = 5 },
	{ itemName = "infernal bolt", clientId = 6528, buy = 110 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 7 },
	{ itemName = "piercing bolt", clientId = 7363, buy = 5 },
	{ itemName = "power bolt", clientId = 3450, buy = 7 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 20 },
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "protective charm", clientId = 11444, sell = 60 },
	{ itemName = "purified soul", clientId = 32228, sell = 260 },
	{ itemName = "purple robe", clientId = 11473, sell = 110 },
	{ itemName = "quara bone", clientId = 11491, sell = 500 },
	{ itemName = "quara eye", clientId = 11488, sell = 350 },
	{ itemName = "quara pincers", clientId = 11490, sell = 410 },
	{ itemName = "quara tentacle", clientId = 11487, sell = 140 },
	{ itemName = "quill", clientId = 28567, sell = 1100 },
	{ itemName = "rare earth", clientId = 27301, sell = 80 },
	{ itemName = "ratmiral's hat", clientId = 35613, sell = 150000 },
	{ itemName = "ravenous circlet", clientId = 32597, sell = 220000 },
	{ itemName = "red dragon leather", clientId = 5948, sell = 200 },
	{ itemName = "red dragon scale", clientId = 5882, sell = 200 },
	{ itemName = "red goanna scale", clientId = 31558, sell = 270 },
	{ itemName = "red hair dye", clientId = 17855, sell = 40 },
	{ itemName = "red piece of cloth", clientId = 5911, sell = 300 },
	{ itemName = "rhino hide", clientId = 24388, sell = 175 },
	{ itemName = "rhino horn", clientId = 24389, sell = 265 },
	{ itemName = "rhino horn carving", clientId = 24386, sell = 300 },
	{ itemName = "rod", clientId = 33929, sell = 2200 },
	{ itemName = "roots", clientId = 33938, sell = 1200 },
	{ itemName = "rope belt", clientId = 11492, sell = 66 },
	{ itemName = "rorc egg", clientId = 18996, sell = 120 },
	{ itemName = "rorc feather", clientId = 18993, sell = 70 },
	{ itemName = "rotten heart", clientId = 31589, sell = 74000 },
	{ itemName = "rotten piece of cloth", clientId = 10291, sell = 30 },
	{ itemName = "sabretooth", clientId = 10311, sell = 400 },
	{ itemName = "safety pin", clientId = 11493, sell = 120 },
	{ itemName = "red quiver", clientId = 35849, buy = 400 },
	{ itemName = "jungle quiver", clientId = 35524, buy = 5000 },
	{ itemName = "eldritch quiver", clientId = 36666, buy = 50000 },
	{ itemName = "royal spear", clientId = 7378, buy = 15 },
	{ itemName = "shiver arrow", clientId = 762, buy = 5 },
	{ itemName = "small stone", clientId = 1781, buy = 100 },
	{ itemName = "sniper arrow", clientId = 7364, buy = 5 },
	{ itemName = "spear", clientId = 3277, buy = 9 },
	{ itemName = "spectral bolt", clientId = 35902, buy = 70 },
	{ itemName = "tarsal arrow", clientId = 14251, buy = 6 },
	{ itemName = "throwing star", clientId = 3287, buy = 42 },
	{ itemName = "vortex bolt", clientId = 14252, buy = 6 },
	{ itemName = "brown mushroom", clientId = 3725, buy = 10 }

	
	
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

-- Create keywordHandler and npcHandler
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- onThink
npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- onAppear 
npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

-- onDisappear
npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

-- onMove
npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

-- onSay
npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

-- Function called by the callback "npcHandler:setCallback(CALLBACK_GREET, greetCallback)" in end of file
local function greetCallback(npc, creature)
	local playerId = creature:getId()
	npcHandler:setMessage(MESSAGE_GREET, "Bem vindo |PLAYERNAME|, caso precise de mais informacoes fale {info}?")
	return true
end

-- On creature say callback
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "info") then
		npcHandler:say({
			"Bem vindo ao Elera-War Global servidor mais completo da atualidade \z
				Visite nosso site www.elera-war.com.br, \z
				 Confira nossas atualizacoes rescentes em nosso discord.",
			"See more on our {discord group}."
		}, npc, creature, 3000)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "discord group") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Acesse nosso grupo do discord: {https://discord.gg/WNXdZEXQgS}", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

-- Set to local function "greetCallback"
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
-- Set to local function "creatureSayCallback"
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Bye message
npcHandler:setMessage(MESSAGE_FAREWELL, "Obrigado! Va e ande pela sombra!")
-- Walkaway message
npcHandler:setMessage(MESSAGE_WALKAWAY, "Voce nao tem educacao filhao?")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- Register npc
npcType:register(npcConfig)
