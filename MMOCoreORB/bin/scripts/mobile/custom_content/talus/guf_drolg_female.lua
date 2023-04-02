guf_drolg_female = Creature:new {
	objectName = "@mob/creature_names:guf_drolg_female",
	socialGroup = "guf_drolg",
	faction = "",
	level = 74,
	chanceHit = 0.65,
	damageMin = 500,
	damageMax = 770,
	baseXp = 5878,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 1,
	resists = {65,140,25,190,190,190,5,5,-1},
	meatType = "meat_reptilian",
	meatAmount = 325,
	hideType = "hide_leathery",
	hideAmount = 265,
	boneType = "bone_mammal",
	boneAmount = 190,
	milk = 2 * 0,
	tamingChance = 0.03,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/guf_drolg_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/guf_drolg_hue.iff",
	scale = 1.05,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(guf_drolg_female, "guf_drolg_female")
