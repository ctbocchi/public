genetically_enhanced_kahmurra = Creature:new {
	objectName = "@mob/creature_names:genetically_enhanced_kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 90,
	chanceHit = 2.5,
	damageMin = 960,
	damageMax = 1550,
	baseXp = 6200,
	baseHAM = 29600,
	baseHAMmax = 34400,
	armor = 1,
	resists = {80,175,165,45,15,185,177.5,25,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milkType = "milk_wild",
	milk = 2 * 250,
	tamingChance = 0.03,
	ferocity = 6,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kahmurra.iff"},
	controlDeviceTemplate = "object/intangible/pet/murra_hue.iff",
	scale = 1.4,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(genetically_enhanced_kahmurra, "genetically_enhanced_kahmurra")
