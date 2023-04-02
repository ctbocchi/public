mutated_kahmurra = Creature:new {
	objectName = "@mob/creature_names:mutated_kahmurra",
	socialGroup = "kahmurra",
	faction = "",
	level = 50,
	chanceHit = 0.46,
	damageMin = 420,
	damageMax = 550,
	baseXp = 4704,
	baseHAM = 8590,
	baseHAMmax = 10642,
	armor = 1,
	resists = {125,130,25,25,10,160,160,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.02,
	ferocity = 7,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/mutated_kahmurra.iff"},
	controlDeviceTemplate = "object/intangible/pet/murra_hue.iff",
	scale = 1.2,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"creatureareaknockdown",""}
	}
}

CreatureTemplates:addCreatureTemplate(mutated_kahmurra, "mutated_kahmurra")
