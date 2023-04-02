kima = Creature:new {
	objectName = "@mob/creature_names:kima",
	socialGroup = "kima",
	faction = "",
	level = 56,
	chanceHit = 1.25,
	damageMin = 475,
	damageMax = 660,
	baseXp = 4719,
	baseHAM = 9780,
	baseHAMmax = 11345,
	armor = 0,
	resists = {55,145,5,-1,180,5,-1,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kima.iff"},
	controlDeviceTemplate = "object/intangible/pet/kima_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(kima, "kima")
