kobola_smuggler = Creature:new {
	objectName = "@mob/creature_names:kobola_smuggler",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "kobola",
	faction = "kobola",
	level = 10,
	chanceHit = 0.28,
	damageMin = 90,
	damageMax = 110,
	baseXp = 356,
	baseHAM = 810,
	baseHAMmax = 990,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
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
	creatureBitmask = PACK + STALKER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_kobola_smuggler_trandoshan_male_01.iff",
		"object/mobile/dressed_kobola_smuggler_trandoshan_female_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2400000},
				{group = "tailor_components", chance = 2000000},
				{group = "loot_kit_parts", chance = 2000000},
				{group = "kobola_common", chance = 3600000}
			}
		},
		{
			groups = {
				{group = "art_illum10", chance = 10000000}
			},
			lootChance = 500000
		},
		{
			groups =
			{
				{group = "slicing_station_group", chance = 100 * (100000)}
			},
			lootChance = 3 * (100000)
		},
	},
	weapons = {"pirate_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlernovice,marksmannovice)
}

CreatureTemplates:addCreatureTemplate(kobola_smuggler, "kobola_smuggler")
