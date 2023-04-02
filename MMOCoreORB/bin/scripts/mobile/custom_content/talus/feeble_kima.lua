feeble_kima = Creature:new {
	objectName = "@mob/creature_names:feeble_kima",
	socialGroup = "kima",
	faction = "",
	level = 36,
	chanceHit = 1.15,
	damageMin = 390,
	damageMax = 540,
	baseXp = 2771,
	baseHAM = 7680,
	baseHAMmax = 10690,
	armor = 0,
	resists = {45,130,0,0,160,0,0,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kima_hue.iff"},
	scale = 0.9,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(feeble_kima, "feeble_kima")
