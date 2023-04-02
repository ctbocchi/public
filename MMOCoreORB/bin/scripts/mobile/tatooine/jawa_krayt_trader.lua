jawa_krayt_trader = Creature:new {
	objectName = "@mob/creature_names:jawa_krayt",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "krayt_trader",
	faction = "jawa",
	level = 60,
	chanceHit = 0.25,
	damageMin = 350,
	damageMax = 555,
	baseXp = 1470,
	baseHAM = 3200,
	baseHAMmax = 4300,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/jawa_male.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 5000000},
				{group = "jawa_common", chance = 1500000},
				{group = "armor_all", chance = 800000},
				{group = "tailor_components", chance = 1000000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "color_crystals", chance = 200000}
			}
		},
		{
			groups = {
				{group = "krayt_body_jawa", chance = 100 * (100000)},
			},
			lootChance = 4 * (100000),
		},

	},
	weapons = {"jawa_weaker_weapons"},
	conversationTemplate = "",
	attacks = merge(marksmannovice,brawlernovice)
}

CreatureTemplates:addCreatureTemplate(jawa_krayt_trader, "jawa_krayt_trader")
