berserk_kahmurra = Creature:new {
	objectName = "@mob/creature_names:beserk_kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 52,
	chanceHit = 0.8,
	damageMin = 445,
	damageMax = 775,
	baseXp = 3481,
	baseHAM = 10670,
	baseHAMmax = 12834,
	armor = 0,
	resists = {120,20,15,125,5,155,145,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 6,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kahmurra.iff"},
	controlDeviceTemplate = "object/intangible/pet/murra_hue.iff",
	scale = 1.1,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"stunattack",""}
	}
}
 
CreatureTemplates:addCreatureTemplate(berserk_kahmurra, "berserk_kahmurra")
