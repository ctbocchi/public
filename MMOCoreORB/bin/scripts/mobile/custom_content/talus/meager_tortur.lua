meager_tortur = Creature:new {
	objectName = "@mob/creature_names:meager_tortur",
	socialGroup = "tortur",
	faction = "",
	level = 42,
	chanceHit = 1.24,
	damageMin = 375,
	damageMax = 460,
	baseXp = 3934,
	baseHAM = 9000,
	baseHAMmax = 11000,
	armor = 0,
	resists = {130,20,75,60,47.5,-1,-1,55,-1},
	meatType = "meat_carnivore",
	meatAmount = 500,
	hideType = "hide_leathery",
	hideAmount = 575,
	boneType = "bone_mammal",
	boneAmount = 650,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/meager_tortur.iff"},
	scale = 0.85,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(meager_tortur, "meager_tortur")
