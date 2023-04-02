ig_assassin_droid = Creature:new {
	objectName = "@mob/creature_names:ig_assassin_droid",
	socialGroup = "",
	faction = "",
	level = 21,
	chanceHit = 0.33,
	damageMin = 220,
	damageMax = 230,
	baseXp = 1803,
	baseHAM = 2400,
	baseHAMmax = 3000,
	armor = 0,
	resists = {125,125,5,5,5,-1,5,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = NONE,

	templates = {"object/mobile/ig_assassin_droid.iff"},
	lootGroups = {
	     {
			groups = {
				{group = "junk",				chance =  65 * (100000)},
				{group = "nyms_common",			chance =  10 * (100000)},
				{group = "pistols",				chance =  10 * (100000)},
				{group = "carbines",			chance =  10 * (100000)},
				{group = "tailor_components",	chance =   5 * (100000)}
			}
		},
		{
			groups = 
			{
				{group = "eta1_autopilot_group", chance = 10000000},
			},
			lootChance = 2 * (100000), -- 2% chance for this group
		},
	},
	conversationTemplate = "",
	defaultWeapon = "object/weapon/ranged/droid/droid_droideka_ranged.iff",
	defaultAttack = "attack"
}

CreatureTemplates:addCreatureTemplate(ig_assassin_droid, "ig_assassin_droid")
