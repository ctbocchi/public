mire_marauder = Creature:new {
	objectName = "@mob/creature_names:mire_marauder",
	socialGroup = "panther",
	faction = "",
	level = 200,
	chanceHit = 4.72,
	damageMin = 650,damageMax = 1125,
	baseXp = 6819,
	baseHAM = 31253,
	baseHAMmax = 41253,
	armor = 3,
	resists = {145,175,65,140,86,85,45,75,-1},
	meatType = "meat_carnivore",
	meatAmount = 150,
	hideType = "hide_leathery",
	hideAmount = 140,
	boneType = "bone_mammal",
	boneAmount = 140,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 12,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/minor_sludge_panther.iff"},
	scale = 2.4,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"posturedownattack",""},
		{"mediumpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(mire_marauder, "mire_marauder")
