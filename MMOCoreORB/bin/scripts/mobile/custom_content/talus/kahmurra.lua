kahmurra = Creature:new {
	objectName = "@mob/creature_names:kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 44,
	chanceHit = 0.41,
	damageMin = 345,
	damageMax = 400,
	baseXp = 3798,
	baseHAM = 8860,
	baseHAMmax = 9670,
	armor = 0,
	resists = {5,20,5,10,5,140,130,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milkType = "milk_wild",
	milk = 2 * 250,
	tamingChance = 0.25,
	ferocity = 5,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kahmurra.iff"},
	controlDeviceTemplate = "object/intangible/pet/murra_hue.iff",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(kahmurra, "kahmurra")
