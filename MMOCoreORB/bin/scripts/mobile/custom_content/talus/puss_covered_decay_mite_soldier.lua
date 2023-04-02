puss_covered_decay_mite_soldier = Creature:new {
	objectName = "@mob/creature_names:puss_covered_decay_mite_soldier",
	socialGroup = "mite",
	faction = "",
	level = 75,
	chanceHit = 0.4,
	damageMin = 800,
	damageMax = 1345,
	baseXp = 5945,
	baseHAM = 21500,
	baseHAMmax = 23500,
	armor = 1,
	resists = {165,35,185,35,-1,15,165,190,-1},	
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.02,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/decay_mite.iff"},
	controlDeviceTemplate = "object/intangible/pet/bark_mite_hue.iff",
	scale = 1.1,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"blindattack",""},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(puss_covered_decay_mite_soldier, "puss_covered_decay_mite_soldier")
