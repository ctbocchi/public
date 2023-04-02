binayre_swindler = Creature:new {
	objectName = "@mob/creature_names:binayre_swindler",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "binayre",
	faction = "binayre",
	level = 83,
	chanceHit = 1.3,
	damageMin = 640,
	damageMax = 960,
	baseXp = 7781,
	baseHAM = 36000,
	baseHAMmax = 42000,
	armor = 1,
	resists = {20,40,55,25,0,90,-1,35,-1},
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
		"object/mobile/dressed_binayre_swindler_zabrak_female_01.iff",
		"object/mobile/dressed_binayre_swindler_zabrak_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "binayre_common", chance = 4550000},
				{group = "color_crystals", chance = 450000}
			}
		}
	},
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlermaster,marksmanmaster,riflemanmaster)
}

CreatureTemplates:addCreatureTemplate(binayre_swindler, "binayre_swindler")
