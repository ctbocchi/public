talus_humbaba = Creature:new {
	objectName = "@mob/creature_names:humbaba",
	socialGroup = "humbaba",
	faction = "",
	level = 46,
	chanceHit = 1.32,
	damageMin = 360,
	damageMax = 570,
	baseXp = 4202,
	baseHAM = 11200,
	baseHAMmax = 13300,
	armor = 0,
	resists = {25,35,25,5,5,5,5,45,-1},
	meatType = "meat_domesticated",
	meatAmount = 230,
	hideType = "hide_leathery",
	hideAmount = 130,
	boneType = "bone_mammal",
	boneAmount = 123,
	milkType = "milk_wild",
	milk = 2 * 250,
	tamingChance = 0.15,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/falumpaset_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/falumpaset_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(talus_humbaba, "talus_humbaba")
