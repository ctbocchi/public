talus_vynock = Creature:new {
	objectName = "@mob/creature_names:vynock",
	socialGroup = "self",
	faction = "",
	level = 70,
	chanceHit = 1.53,
	damageMin = 772,
	damageMax = 889,
	baseXp = 6590,
	baseHAM = 15864,
	baseHAMmax = 17590,
	armor = 1,
	resists = {130,130,20,65,20,20,55,45,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/vynock.iff"},
	controlDeviceTemplate = "object/intangible/pet/vynock_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"mildpoison",""},
	}
}

CreatureTemplates:addCreatureTemplate(talus_vynock, "talus_vynock")
