putrid_decay_mite_hatchling = Creature:new {
	objectName = "@mob/creature_names:putrid_decay_mite_hatchling",
	socialGroup = "mite",
	faction = "",
	level = 64,
	chanceHit = 0.34,
	damageMin = 470,
	damageMax = 640,
	baseXp = 5480,
	baseHAM = 14000,
	baseHAMmax = 18000,
	armor = 0,
	resists = {155,25,140,65,-1,0,175,190,-1},	
	meatType = "meat_insect",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/putrid_decay_mite_hatchling.iff"},
	scale = 0.75,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"strongdisease",""},
		{"strongpoison",""},
	}
}

CreatureTemplates:addCreatureTemplate(putrid_decay_mite_hatchling, "putrid_decay_mite_hatchling")
