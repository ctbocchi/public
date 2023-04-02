tortur_bull = Creature:new {
	objectName = "@mob/creature_names:tortur_bull",
	socialGroup = "tortur",
	faction = "",
	level = 68,
	chanceHit = 2.2,
	damageMin = 595,
	damageMax = 900,
	baseXp = 5972,
	baseHAM = 16000,
	baseHAMmax = 19000,
	armor = 1,
	resists = {165,135,190,190,190,-1,5,75,-1},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 1000,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 10,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/meager_tortur.iff"},
	scale = 1.1,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"knockdownattack",""},
		{"creatureareacombo",""}
	}
}

CreatureTemplates:addCreatureTemplate(tortur_bull, "tortur_bull")
