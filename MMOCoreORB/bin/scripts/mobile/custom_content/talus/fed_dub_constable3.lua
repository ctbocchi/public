fed_dub_constable3 = Creature:new {
	customName = "Fed Dub Occupation Forces",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "fed_dub",
	faction = "fed_dub",
	level = 150,
	chanceHit = 1.1,
	damageMin = 850,
	damageMax = 1170,
	baseXp = 8389,
	baseHAM = 36000,
	baseHAMmax = 48000,
	armor = 2,
	resists = {35,75,75,65,65,40,5,25,-1},
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
		{
			groups = {
				{group = "art_myriad1",       chance = 100 * (100000)},
			},
			lootChance = 4 * (100000)
		}
	},
	weapons = {"st_assault_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmaster,marksmanmaster,carbineermaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(fed_dub_constable3, "fed_dub_constable3")
