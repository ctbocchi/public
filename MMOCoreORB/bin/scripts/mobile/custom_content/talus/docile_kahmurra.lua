docile_kahmurra = Creature:new {
	objectName = "@mob/creature_names:docile_kahmurra",
	socialGroup = "self",
	faction = "",
	level = 30,
	chanceHit = 0.37,
	damageMin = 310,
	damageMax = 330,
	baseXp = 2632,
	baseHAM = 4350,
	baseHAMmax = 5420,
	armor = 0,
	resists = {0,15,5,0,0,120,130,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 123,
	hideType = "hide_bristley",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milkType = "milk_domesticated",
	milk = 2 * 250,
	tamingChance = 0,
	ferocity = 1,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = NONE,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/kahmurra.iff"},
	scale = 0.9,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(docile_kahmurra, "docile_kahmurra")
