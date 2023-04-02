jungle_fynock = Creature:new {
	objectName = "@mob/creature_names:jungle_fynock",
	socialGroup = "fynock",
	faction = "",
	level = 38,
	chanceHit = 0.4,
	damageMin = 330,
	damageMax = 490,
	baseXp = 3233,
	baseHAM = 8650,
	baseHAMmax = 9790,
	armor = 0,
	resists = {155,22.5,150,15,5,-1,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/fynock_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/fynock_hue.iff",
	scale = 1.15,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"posturedownattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(jungle_fynock, "jungle_fynock")
