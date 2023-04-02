giant_decay_mite_protector = Creature:new {
	objectName = "@mob/creature_names:giant_decay_mite_protector",
	socialGroup = "mite",
	faction = "",
	level = 36,
	chanceHit = 0.4,
	damageMin = 290,
	damageMax = 380,
	baseXp = 3142,
	baseHAM = 8750,
	baseHAMmax = 9250,
	armor = 0,
	resists = {120,120,145,165,0,-1,180,190,-1},
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "hide_scaley",
	hideAmount = 123,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/decay_mite.iff"},
	scale = 1.5,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(giant_decay_mite_protector, "giant_decay_mite_protector")
