chunker_braggart = Creature:new {
	objectName = "@mob/creature_names:chunker_braggart",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	faction = "thug",
	socialGroup = "chunker",
	level = 72,
	chanceHit = 0.9,
	damageMin = 325,
	damageMax = 500,
	baseXp = 6250,
	baseHAM = 13500,
	baseHAMmax = 16500,
	armor = 1,
	resists = {25,30,35,-1,-1,30,-1,25,-1},
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
				{group = "melee_knife",          chance = 20 * (100000)},
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
	weapons = {"melee_weapons"},
	conversationTemplate = "",
	attacks = merge(fencermaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(chunker_braggart, "chunker_braggart")
