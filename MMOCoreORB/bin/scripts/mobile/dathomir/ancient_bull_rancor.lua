ancient_bull_rancor = Creature:new {
	objectName = "@mob/creature_names:ancient_bull_rancor",
	socialGroup = "rancor",
	faction = "",
	level = 140,
	chanceHit = 2.0,
	damageMin = 800,
	damageMax = 1400,
	baseXp = 16411,
	baseHAM = 120000,
	baseHAMmax = 125000,
	armor = 1,
	-- {kinetic,energy,blast,heat,cold,electricity,acid,stun,ls}
	resists = {185,185,185,195,180,185,185,190,135},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 950,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 25,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/bull_rancor.iff"},
	scale = 1.25,
	lootGroups = {
		{
			groups = {
				{group = "rancor_common",	chance = 40 * (100000)},
				{group = "armor_all",		chance = 20 * (100000)},
				{group = "weapons_all",		chance = 25 * (100000)},
				{group = "wearables_all",	chance = 15 * (100000)}
			},
			lootChance = 2.96 * (100000)
		},
		{
			groups = {
				{group = "captain_ring_group", chance = 10000000},
			},
			lootChance = .25 * (100000)
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareableeding",""},
		{"creatureareacombo",""}
	}
}

CreatureTemplates:addCreatureTemplate(ancient_bull_rancor, "ancient_bull_rancor")
