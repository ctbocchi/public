rabid_mutant_kahmurra = Creature:new {
	objectName = "@mob/creature_names:rabid_mutant_kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 55,
	chanceHit = 0.58,
	damageMin = 425,
	damageMax = 615,
	baseXp = 4863,
	baseHAM = 11748,
	baseHAMmax = 14488,
	armor = 0,
	resists = {165,140,15,25,15,180,180,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.15,
	ferocity = 6,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/mutated_kahmurra.iff"},
	controlDeviceTemplate = "object/intangible/pet/murra_hue.iff",
	scale = 1.3,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"strongdisease",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(rabid_mutant_kahmurra, "rabid_mutant_kahmurra")
