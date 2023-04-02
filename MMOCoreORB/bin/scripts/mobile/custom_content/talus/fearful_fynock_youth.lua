fearful_fynock_youth = Creature:new {
	objectName = "@mob/creature_names:fearful_fynock_youth",
	socialGroup = "fynock",
	faction = "",
	level = 24,
	chanceHit = 0.33,
	damageMin = 290,
	damageMax = 450,
	baseXp = 2143,
	baseHAM = 6300,
	baseHAMmax = 7100,
	armor = 0,
	resists = {135,10,120,-1,-1,-1,-1,-1,-1},
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
	scale = 0.7,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(fearful_fynock_youth, "fearful_fynock_youth")
