percussive_rasp = Creature:new {
	objectName = "@mob/creature_names:percussive_rasp",
	socialGroup = "rasp",
	faction = "",
	level = 48,
	chanceHit = 0.38,
	damageMin = 425,
	damageMax = 600,
	baseXp = 3412,
	baseHAM = 9800,
	baseHAMmax = 11400,
	armor = 0,
	resists = {155,145,0,5,15,110,0,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + STALKER + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/flite_rasp_hue.iff"},
	scale = 1.1,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(percussive_rasp, "percussive_rasp")
