lost_aqualish_scout = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_scout",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 70,
	chanceHit = 0.7,
	damageMin = 475,	
	damageMax = 525,
	baseXp = 5534,
	baseHAM = 12000,
	baseHAMmax = 14400,
	armor = 0,
	resists = {15,15,5,5,15,20,25,15,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_lost_aqualish_scout_female_01.iff",
		"object/mobile/dressed_lost_aqualish_scout_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "pistols", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"imperial_weapons_light"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(marksmannovice,pistoleernovice)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_scout, "lost_aqualish_scout")
