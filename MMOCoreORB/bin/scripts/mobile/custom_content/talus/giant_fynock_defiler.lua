giant_fynock_defiler = Creature:new {
	customName = "a giant fynock defiler",
	socialGroup = "fynock",
	faction = "",
	level = 120,
	chanceHit = 2.3,
	damageMin = 820,
	damageMax = 1725,
	baseXp = 8784,
	baseHAM = 16471,
	baseHAMmax = 19812,
	armor = 1,
	resists = {45,55,45,75,85,90,55,25,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 9,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/fynock_hue.iff"},
	scale = 4,
	lootGroups = {},
	weapons = {"creature_spit_small_red"},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(giant_fynock_defiler, "giant_fynock_defiler")
