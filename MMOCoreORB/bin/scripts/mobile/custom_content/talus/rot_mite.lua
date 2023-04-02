rot_mite = Creature:new {
	objectName = "@mob/creature_names:rot_mite",
	socialGroup = "mite",
	faction = "",
	level = 29,
	chanceHit = 0.38,
	damageMin = 290,
	damageMax = 620,
	baseXp = 2414,
	baseHAM = 7325,
	baseHAMmax = 8128,
	armor = 0,
	resists = {125,20,137.5,165,-1,0,175,175,-1},
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

	templates = {"object/mobile/rot_mite.iff"},
	controlDeviceTemplate = "object/intangible/pet/bark_mite_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(rot_mite, "rot_mite")
