binayre_smuggler = Creature:new {
	objectName = "@mob/creature_names:binayre_smuggler",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "binayre",
	faction = "binayre",
	level = 78,
	chanceHit = 1.12,
	damageMin = 620,
	damageMax = 790,
	baseXp = 7680,
	baseHAM = 34000,
	baseHAMmax = 44000,
	armor = 1,
	resists = {35,85,40,0,0,70,0,35,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_binayre_smuggler_trandoshan_female_01.iff",
		"object/mobile/dressed_binayre_smuggler_trandoshan_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2450000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "binayre_common", chance = 4550000}
			}
		},
		{
			groups = {
				{group = "art_illum25", chance = 10000000}
			},
			lootChance = 3500000
		}
	},
	weapons = {"pirate_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlermaster,marksmanmaster,tkamaster,pistoleermaster)
}

CreatureTemplates:addCreatureTemplate(binayre_smuggler, "binayre_smuggler")
