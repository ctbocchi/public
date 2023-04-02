talus_devil_gulginaw = Creature:new {
	objectName = "@mob/creature_names:devil_gulginaw",
	socialGroup = "gulginaw",
	faction = "",
	level = 44,
	chanceHit = 0.54,
	damageMin = 340,
	damageMax = 770,
	baseXp = 4196,
	baseHAM = 6032,
	baseHAMmax = 8513,
	armor = 0,
	resists = {65,45,25,25,25,-1,65,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/devil_gulginaw.iff"},
	controlDeviceTemplate = "object/intangible/pet/devil_gulginaw_hue.iff",
	scale = 1.15,
	lootGroups = {},
	weapons = {"creature_spit_small_red"},
	conversationTemplate = "",
	attacks = {
		{"mediumpoison",""},
		{"dizzyattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(talus_devil_gulginaw, "talus_devil_gulginaw")
