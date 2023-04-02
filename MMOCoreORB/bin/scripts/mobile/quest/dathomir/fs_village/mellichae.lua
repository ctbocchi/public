mellichae = Creature:new {
	objectName = "@mob/creature_names:mellichae",
	socialGroup = "sith_shadow",
	faction = "sith_shadow",
	level = 140,
	chanceHit = 1.5,
	damageMin = 945,
	damageMax = 1600,
	baseXp = 13273,
	baseHAM = 50000,
	baseHAMmax = 61000,
	armor = 2,
	resists = {80,80,80,80,80,80,80,80,96},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = KILLER,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_fs_village_enemy_mellichae.iff"},
	lootGroups = {},
	weapons = {"dark_jedi_weapons_gen2"},
	attacks = {{"forcelightningsingle1",""}, {"forcelightningcone1",""},{"forcelightningsingle2",""}, {"forcelightningcone2",""}, {"forcethrow2",""}}
}

CreatureTemplates:addCreatureTemplate(mellichae, "mellichae")
