ferine_razorfang = Creature:new {
	objectName = "@mob/creature_names:kima_ferine_razorfang",
	socialGroup = "kima",
	faction = "",
	level = 80,
	chanceHit = 9,
	damageMin = 1150,
	damageMax = 1660,
	baseXp = 6013,
	baseHAM = 48000,
	baseHAMmax = 64000,
	armor = 1,
	resists = {170,165,25,140,195,-1,-1,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.05,
	ferocity = 8,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/kima_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/kima_hue.iff",
	scale = 1.25,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"blindattack",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(ferine_razorfang, "ferine_razorfang")
