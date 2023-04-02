talus_gulginaw = Creature:new {
	objectName = "@mob/creature_names:gulginaw",
	socialGroup = "gulginaw",
	faction = "",
	level = 70,
	chanceHit = 0.54,
	damageMin = 648,
	damageMax = 1245,
	baseXp = 6296,
	baseHAM = 8032,
	baseHAMmax = 9513,
	armor = 1,
	resists = {55,45,25,25,25,55,65,70,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/gulginaw.iff"},
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"mildpoison",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(talus_gulginaw, "talus_gulginaw")
