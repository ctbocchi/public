binayre_chief = Creature:new {
	objectName = "@mob/creature_names:binayre_chief",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "binayre",
	faction = "binayre",
	level = 89,
	chanceHit = 1.56,
	damageMin = 560,
	damageMax = 860,
	baseXp = 7981,
	baseHAM = 46000,
	baseHAMmax = 52000,
	armor = 1,
	resists = {55,65,45,15,15,60,45,35,-1},
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
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_binayre_chief_human_female_01.iff",
		"object/mobile/dressed_binayre_chief_human_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "binayre_common", chance = 4550000},
				{group = "color_crystals", chance = 450000}
			}
		}
	},
	weapons = {"melee_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(brawlermaster,fencermaster,pikemanmaster,swordsmanmaster)
}

CreatureTemplates:addCreatureTemplate(binayre_chief, "binayre_chief")
