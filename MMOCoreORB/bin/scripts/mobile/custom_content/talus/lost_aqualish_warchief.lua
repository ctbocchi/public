lost_aqualish_warchief = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_warchief",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 100,
	chanceHit = 2.5,
	damageMin = 625,	
	damageMax = 925,
	baseXp = 7906,
	baseHAM = 31000,
	baseHAMmax = 37200,
	armor = 1,
	resists = {85,70,65,65,85,75,55,50,-1},
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
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_lost_aqualish_warchief_female_01.iff",
		"object/mobile/dressed_lost_aqualish_warchief_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 1500000},
				{group = "wearables_uncommon", chance = 500000},
				{group = "heavy_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
		{
			groups = {
				{group = "art_newhope1",       chance = 100 * (100000)},
			},
			lootChance = 5 * (100000)
		}
	},
	weapons = {"ranged_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(marksmanmaster,carbineermaster)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_warchief, "lost_aqualish_warchief")
