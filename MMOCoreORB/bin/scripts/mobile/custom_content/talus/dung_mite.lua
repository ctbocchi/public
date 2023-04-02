dung_mite = Creature:new {
	objectName = "@mob/creature_names:dung_mite",
	socialGroup = "mite",
	faction = "",
	level = 34,
	chanceHit = 0.4,
	damageMin = 325,
	damageMax = 450,
	baseXp = 2770,
	baseHAM = 7400,
	baseHAMmax = 8400,
	armor = 0,
	resists = {125,20,140,65,-1,0,175,185,-1},	
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "hide_scaley",
	hideAmount = 123,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/dung_mite.iff"},
	controlDeviceTemplate = "object/intangible/pet/bark_mite_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(dung_mite, "dung_mite")
