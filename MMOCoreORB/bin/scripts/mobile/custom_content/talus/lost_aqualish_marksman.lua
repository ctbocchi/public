lost_aqualish_marksman = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_marksman",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 89,
	chanceHit = 9.0,
	damageMin = 695,	
	damageMax = 725,
	baseXp = 7036,
	baseHAM = 18340,
	baseHAMmax = 22008,
	armor = 1,
	resists = {65,45,25,15,15,50,15,25,-1},
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
		"object/mobile/dressed_lost_aqualish_marksman_female_01.iff",
		"object/mobile/dressed_lost_aqualish_marksman_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2500000},
				{group = "wearables_common", chance = 2000000},
				{group = "rifles", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "color_crystals", chance = 500000}
			}
		}
	},
	weapons = {"jawa_warlord_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(riflemanmaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_marksman, "lost_aqualish_marksman")
