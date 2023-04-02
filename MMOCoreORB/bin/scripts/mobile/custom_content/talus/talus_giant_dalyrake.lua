talus_giant_dalyrake = Creature:new {
	objectName = "@mob/creature_names:giant_dalyrake",
	socialGroup = "dalyrake",
	faction = "",
	level = 62,
	chanceHit = 0.44,
	damageMin = 543,
	damageMax = 689,
	baseXp = 5481,
	baseHAM = 15422,
	baseHAMmax = 16513,
	armor = 0,
	resists = {125,10,10,55,45,55,10,-1,-1},
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "hide_scaley",
	hideAmount = 123,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 4,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/giant_dalyrake.iff"},
	controlDeviceTemplate = "object/intangible/pet/dalyrake_hue.iff",
	scale = 1.5,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"mildpoison",""},
		{"dizzyattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(talus_giant_dalyrake, "talus_giant_dalyrake")
