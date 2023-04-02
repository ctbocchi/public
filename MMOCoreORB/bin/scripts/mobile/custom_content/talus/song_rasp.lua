song_rasp = Creature:new {
	objectName = "@mob/creature_names:song_rasp",
	socialGroup = "rasp",
	faction = "",
	level = 53,
	chanceHit = 0.37,
	damageMin = 395,
	damageMax = 500,
	baseXp = 4771,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 0,
	resists = {135,155,5,10,15,0,0,-1,-1},
	meatType = "meat_avian",
	meatAmount = 123,
	hideType = "",
	hideAmount = 0,
	boneType = "bone_avian",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/flite_rasp_hue.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
	}
}

CreatureTemplates:addCreatureTemplate(song_rasp, "song_rasp")