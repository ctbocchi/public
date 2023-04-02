foaming_vynock = Creature:new {
	objectName = "@mob/creature_names:foaming_vynock",
	socialGroup = "self",
	faction = "",
	level = 30,
	chanceHit = 0.4,
	damageMin = 259,
	damageMax = 338,
	baseXp = 2245,
	baseHAM = 1895,
	baseHAMmax = 2436,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/vynock_hue.iff"},
	scale = 1.2,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""},
		{"milddisease",""}
	}
}

CreatureTemplates:addCreatureTemplate(foaming_vynock, "foaming_vynock")
