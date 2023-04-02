clipped_fynock = Creature:new {
	objectName = "@mob/creature_names:clipped_fynock",
	socialGroup = "fynock",
	faction = "",
	level = 26,
	chanceHit = 0.36,
	damageMin = 275,
	damageMax = 440,
	baseXp = 2137,
	baseHAM = 5400,
	baseHAMmax = 6600,
	armor = 0,
	resists = {145,15,140,-1,-1,-1,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/clipped_fynock.iff"},
	scale = 0.9,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(clipped_fynock, "clipped_fynock")
