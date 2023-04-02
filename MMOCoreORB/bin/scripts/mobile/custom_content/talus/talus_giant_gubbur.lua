talus_giant_gubbur = Creature:new {
	objectName = "@mob/creature_names:giant_gubbur",
	socialGroup = "gubbur",
	faction = "",
	level = 38,
	chanceHit = 0.42,
	damageMin = 244,
	damageMax = 319,
	baseXp = 2719,
	baseHAM = 5685,
	baseHAMmax = 7052,
	armor = 0,
	resists = {115,110,5,-1,5,5,-1,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/giant_gubbur.iff"},
	scale = 1.5,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(talus_giant_gubbur, "talus_giant_gubbur")
