male_roba = Creature:new {
	objectName = "@mob/creature_names:roba_male",
	socialGroup = "roba",
	faction = "",
	level = 42,
	chanceHit = 0.44,
	damageMin = 375,
	damageMax = 425,
	baseXp = 3915,
	baseHAM = 9800,
	baseHAMmax = 12200,
	armor = 0,
	resists = {40,40,40,185,-1,145,30,40,-1},
	meatType = "meat_carnivore",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 2,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/roba_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/roba_hue.iff",
	scale = 0.9,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(male_roba, "male_roba")
