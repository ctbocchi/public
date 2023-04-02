fed_dub_patrolman = Creature:new {
	objectName = "@mob/creature_names:fed_dub_patrolman",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "fed_dub",
	faction = "fed_dub",
	level = 70,
	chanceHit = 1.1,
	damageMin = 450,
	damageMax = 770,
	baseXp = 6989,
	baseHAM = 11000,
	baseHAMmax = 14000,
	armor = 1,
	resists = {35,40,25,-1,-1,40,5,25,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_fed_dub_patrol_man_human_male_01.iff",
		"object/mobile/dressed_fed_dub_patrolman_human_female_01.iff",
		"object/mobile/dressed_fed_dub_patrolman_human_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "pistols", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
	},
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmaster,brawlermaster,riflemanmid)
}

CreatureTemplates:addCreatureTemplate(fed_dub_patrolman, "fed_dub_patrolman")
