glutted_fynock_queen = Creature:new {
	objectName = "@mob/creature_names:glutted_fynock_queen",
	socialGroup = "fynock",
	faction = "",
	level = 42,
	chanceHit = 0.4,
	damageMin = 390,
	damageMax = 540,
	baseXp = 3727,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 0,
	resists = {140,22.5,155,20,5,-1,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/glutted_fynock_queen.iff"},
	scale = 1.25,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(glutted_fynock_queen, "glutted_fynock_queen")
