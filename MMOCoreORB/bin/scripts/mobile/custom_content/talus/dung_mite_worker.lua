dung_mite_worker = Creature:new {
	objectName = "@mob/creature_names:sickening_dung_mite_worker",
	socialGroup = "mite",
	faction = "",
	level = 43,
	chanceHit = 0.41,
	damageMin = 365,
	damageMax = 460,
	baseXp = 3279,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 0,
	resists = {145,110,-1,5,-1,-1,180,185,-1},	
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/sickening_dung_mite_worker.iff"},
	controlDeviceTemplate = "object/intangible/pet/bark_mite_hue.iff",
	scale = 1.05,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"mediumdisease",""}
	}
}

CreatureTemplates:addCreatureTemplate(dung_mite_worker, "dung_mite_worker")
