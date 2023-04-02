binayre_scalawag = Creature:new {
	objectName = "@mob/creature_names:binayre_scalawag",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "binayre",
	faction = "binayre",
	level = 64,
	chanceHit = 0.69,
	damageMin = 540,
	damageMax = 650,
	baseXp = 6261,
	baseHAM = 12600,
	baseHAMmax = 15466,
	armor = 0,
	resists = {25,35,5,0,0,35,0,32.5,-1},
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
		"object/mobile/dressed_binayre_scalawag_twk_female_01.iff",
		"object/mobile/dressed_binayre_scalawag_twk_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2450000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "binayre_common", chance = 4550000}
			}
		},
	},
	weapons = {"pirate_weapons_light"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(binayre_scalawag, "binayre_scalawag")
