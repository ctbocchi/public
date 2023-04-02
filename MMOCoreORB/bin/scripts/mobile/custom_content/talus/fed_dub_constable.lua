fed_dub_constable = Creature:new {
	objectName = "@mob/creature_names:fed_dub_constable",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "fed_dub",
	faction = "fed_dub",
	level = 78,
	chanceHit = 2,
	damageMin = 590,
	damageMax = 820,
	baseXp = 7612,
	baseHAM = 12000,
	baseHAMmax = 15000,
	armor = 1,
	resists = {50,55,25,-1,-1,60,30,42.5,-1},
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
		"object/mobile/dressed_fed_dub_constable_twk_male_01.iff",
		"object/mobile/dressed_fed_dub_constable_twk_female_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "carbines", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
	},
	weapons = {"st_assault_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmaster,marksmanmaster,carbineermaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(fed_dub_constable, "fed_dub_constable")
