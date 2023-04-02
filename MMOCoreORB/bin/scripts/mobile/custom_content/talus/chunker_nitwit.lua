chunker_nitwit = Creature:new {
	objectName = "@mob/creature_names:chunker_nitwit",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	faction = "thug",
	socialGroup = "chunker",
	level = 45,
	chanceHit = 0.54,
	damageMin = 200,
	damageMax = 420,
	baseXp = 3980,
	baseHAM = 9600,
	baseHAMmax = 11450,
	armor = 0,
	resists = {15,15,25,5,5,5,-1,10,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	
	templates = {"object/mobile/dressed_mugger.iff",
		"object/mobile/dressed_robber_human_male_01.iff",
		"object/mobile/dressed_criminal_thug_zabrak_female_01.iff",
		"object/mobile/dressed_criminal_thug_aqualish_female_02.iff",
		"object/mobile/dressed_criminal_thug_aqualish_male_02.iff",
		"object/mobile/dressed_desperado_bith_female_01.iff",
		"object/mobile/dressed_criminal_thug_human_female_01.iff",
		"object/mobile/dressed_goon_twk_female_01.iff",
		"object/mobile/dressed_criminal_thug_human_male_01.iff",
		"object/mobile/dressed_robber_twk_female_01.iff",
		"object/mobile/dressed_villain_trandoshan_male_01.iff",
		"object/mobile/dressed_desperado_bith_male_01.iff",
		"object/mobile/dressed_mugger.iff"},
	
		lootGroups = {
			{
				groups = {
					{group = "armor_attachments",    chance = 20 * (100000)},
					{group = "clothing_attachments", chance = 20 * (100000)},
					{group = "rifles",          chance = 20 * (100000)},
					{group = "pistols",              chance = 20 * (100000)},
					{group = "carbines",             chance = 20 * (100000)},
				},
				lootChance = 75 * (100000)
			},
			{
				groups = {
					{group = "chunker_common",       chance = 20 * (100000)},
					{group = "junk",                 chance = 20 * (100000)},
					{group = "wearables_common",     chance = 20 * (100000)},
					{group = "tailor_components",    chance = 20 * (100000)},
					{group = "melee_knife",          chance = 20 * (100000)},
				},
				lootChance = 50 * (100000)
			}
		},
		weapons = {"ranged_weapons"},
		conversationTemplate = "",
		attacks = merge(marksmanmaster)
	}
	
	CreatureTemplates:addCreatureTemplate(chunker_nitwit, "chunker_nitwit")
	