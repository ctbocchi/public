famished_sludge_panther = Creature:new {
	objectName = "@mob/creature_names:famished_sludge_panther",
	socialGroup = "panther",
	faction = "",
	level = 42,
	chanceHit = 0.44,
	damageMin = 305,
	damageMax = 394,
	baseXp = 3481,
	baseHAM = 4422,
	baseHAMmax = 5513,
	armor = 0,
	resists = {5,120,5,-1,-1,-1,5,-1,-1},
	meatType = "meat_carnivore",
	meatAmount = 123,
	hideType = "hide_leathery",
	hideAmount = 123,
	boneType = "bone_mammal",
	boneAmount = 123,
	milk = 2 * 0,
	tamingChance = 0.25,
	ferocity = 8,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/minor_sludge_panther.iff"},
	controlDeviceTemplate = "object/intangible/pet/corellian_sand_panther_hue.iff",
	scale = 1.1,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(famished_sludge_panther, "famished_sludge_panther")
