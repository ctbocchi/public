female_roba = Creature:new {
	objectName = "@mob/creature_names:roba_female",
	socialGroup = "roba",
	faction = "",
	level = 41,
	chanceHit = 0.41,
	damageMin = 345,
	damageMax = 400,
	baseXp = 3515,
	baseHAM = 9300,
	baseHAMmax = 11300,
	armor = 0,
	resists = {35,35,35,175,-1,135,30,30,-1},
	meatType = "meat_carnivore",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/roba_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/roba_hue.iff",
	scale = 0.95,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(female_roba, "female_roba")
