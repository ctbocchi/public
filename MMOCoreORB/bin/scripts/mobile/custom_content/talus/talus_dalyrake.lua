talus_dalyrake = Creature:new {
	objectName = "@mob/creature_names:dalyrake",
	socialGroup = "dalyrake",
	faction = "",
	level = 46,
	chanceHit = 0.44,
	damageMin = 435,
	damageMax = 532,
	baseXp = 3481,
	baseHAM = 5422,
	baseHAMmax = 6513,
	armor = 0,
	resists = {125,10,10,10,-1,10,10,-1,-1},
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
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/dalyrake.iff"},
	controlDeviceTemplate = "object/intangible/pet/dalyrake_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(talus_dalyrake, "talus_dalyrake")
