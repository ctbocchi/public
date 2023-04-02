rebel_battle_droid = Creature:new {
	objectName = "@mob/creature_names:rebel_battle_droid",
	socialGroup = "rebel",
	faction = "rebel",
	level = 134,
	chanceHit = 5.5,
	damageMin = 795,
	damageMax = 1300,
	baseXp = 12612,
	baseHAM = 56000,
	baseHAMmax = 68000,
	armor = 2,
	resists = {75,75,75,60,75,25,40,85,-1},
	-- {kinetic,energy,blast,heat,cold,electricity,acid,stun,ls}
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.15,

	templates = {
		"object/mobile/battle_droid.iff"
	},
	lootGroups = {
		{
			groups = {
				{group = "airstrike_group", chance = 100 * (100000)},
			},
			lootChance = 7 * (100000),
		},
	},
	weapons = {"battle_droid_weapons"},
	attacks = merge(pistoleermaster,carbineermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(rebel_battle_droid, "rebel_battle_droid")
