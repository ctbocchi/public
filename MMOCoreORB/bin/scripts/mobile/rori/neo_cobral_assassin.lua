neo_cobral_assassin = Creature:new {
	objectName = "@mob/creature_names:cobral_assassin",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "cobral",
	faction = "cobral",
	level = 25,
	chanceHit = 0.36,
	damageMin = 300,
	damageMax = 310,
	baseXp = 2637,
	baseHAM = 5900,
	baseHAMmax = 7200,
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_cobral_assassin_twk_female_01.iff",
		"object/mobile/dressed_cobral_assassin_twk_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2000000},
				{group = "wearables_common", chance = 2000000},
				{group = "melee_weapons", chance = 2000000},
				{group = "tailor_components", chance = 2000000},
				{group = "loot_kit_parts", chance = 2000000}
			}
		},
		{
			groups = {
				{group = "inf_gold_4", chance =    100 * (100000)}
			},
			lootChance = 7 * (100000)
		},
	},
	weapons = {"pirate_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(neo_cobral_assassin, "neo_cobral_assassin")
