tortur = Creature:new {
	objectName = "@mob/creature_names:tortur",
	socialGroup = "tortur",
	faction = "",
	level = 58,
	chanceHit = 1.75,
	damageMin = 475,
	damageMax = 660,
	baseXp = 5025,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 0,
	resists = {145,25,180,180,170,-1,-1,75,-1},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 1000,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 7,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/meager_tortur.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"knockdownattack",""},
		{"dizzyattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(tortur, "tortur")
