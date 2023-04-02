feared_fynock_youth = Creature:new {
	objectName = "@mob/creature_names:feared_fynock_youth",
	socialGroup = "fynock",
	faction = "",
	level = 28,
	chanceHit = 0.33,
	damageMin = 325,
	damageMax = 525,
	baseXp = 2514,
	baseHAM = 6900,
	baseHAMmax = 7800,
	armor = 0,
	resists = {150,15,140,5,-1,-1,-1,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/fearful_fynock_youth.iff"},
	scale = 0.8,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(feared_fynock_youth, "feared_fynock_youth")
