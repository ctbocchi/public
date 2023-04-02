giant_decay_mite_sentry = Creature:new {
	objectName = "@mob/creature_names:giant_decay_mite_sentry",
	socialGroup = "mite",
	faction = "",
	level = 41,
	chanceHit = 0.41,
	damageMin = 350,
	damageMax = 425,
	baseXp = 3840,
	baseHAM = 13000,
	baseHAMmax = 17000,
	armor = 0,
	resists = {120,120,155,170,0,-1,190,190,-1},
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "hide_scaley",
	hideAmount = 123,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/decay_mite.iff"},
	scale = 1.8,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"knockdownattack",""},
		{"mediumdisease",""}
	}
}

CreatureTemplates:addCreatureTemplate(giant_decay_mite_sentry, "giant_decay_mite_sentry")
