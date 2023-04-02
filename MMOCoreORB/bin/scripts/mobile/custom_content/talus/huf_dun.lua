huf_dun = Creature:new {
	objectName = "@mob/creature_names:huf_dun",
	socialGroup = "huf_dun",
	faction = "",
	level = 39,
	chanceHit = 0.44,
	damageMin = 335,
	damageMax = 385,
	baseXp = 3915,
	baseHAM = 21000,
	baseHAMmax = 25000,
	armor = 0,
	resists = {155,135,175,-1,-1,-1,15,175,-1},
	meatType = "meat_herbivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 1000,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 4,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/huf_dun.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"blindattack",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(huf_dun, "huf_dun")
