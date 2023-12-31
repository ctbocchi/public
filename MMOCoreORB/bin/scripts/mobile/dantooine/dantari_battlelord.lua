dantari_battlelord = Creature:new {
	objectName = "@mob/creature_names:dantari_raider_battlelord",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "dantari_raiders",
	faction = "dantari_raiders",
	level = 36,
	chanceHit = 0.41,
	damageMin = 320,
	damageMax = 350,
	baseXp = 3642,
	baseHAM = 8800,
	baseHAMmax = 10800,
	armor = 0,
	resists = {25,40,40,-1,60,60,-1,25,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dantari_male.iff",
		"object/mobile/dantari_female.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk",					chance = 60 * 100000},
				{group = "loot_kit_parts",			chance = 30 * 100000},
				{group = "armor_attachments",		chance =  5 * 100000},
				{group = "clothing_attachments",	chance =  5 * 100000},
			}
		},
		{
			groups = {
				{group = "dantari_common", chance = 100 * (100000)}
			},
			lootChance = 50 * (100000)
		},
		{
			groups = {
				{group = "coffee_table_group", chance = 100 * (100000)}
			},
			lootChance = 9 * (100000)
		},
	},
	weapons = {"primitive_weapons"},
	conversationTemplate = "",
	attacks = merge(pikemanmaster,fencermaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(dantari_battlelord, "dantari_battlelord")
