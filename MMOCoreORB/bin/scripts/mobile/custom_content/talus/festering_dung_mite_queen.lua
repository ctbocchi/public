festering_dung_mite_queen = Creature:new {
	objectName = "@mob/creature_names:festering_dung_queen",
	socialGroup = "mite",
	faction = "",
	level = 68,
	chanceHit = 0.42,
	damageMin = 244,
	damageMax = 319,
	baseXp = 5450,
	baseHAM = 16500,
	baseHAMmax = 18900,
	armor = 1,
	resists = {157.5,27.5,35,60,-1,-1,165,180,-1},
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/dung_mite.iff"},
	scale = 1.25,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack",""},
		{"milddisease",""}
	}
}

CreatureTemplates:addCreatureTemplate(festering_dung_mite_queen, "festering_dung_mite_queen")
