defector_quest_lethin = Creature:new {
	objectName = "@mob/creature_names:imperial_medic",
	socialGroup = "imperial",
	faction = "rebel",
	level = 16,
	chanceHit = 0.31,
	damageMin = 170,
	damageMax = 180,
	baseXp = 960,
	baseHAM = 2900,
	baseHAMmax = 3500,
	armor = 0,
	resists = {0,0,0,0,0,0,0,-1,-1},
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
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED + CONVERSABLE,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_imperial_medic1_human_male_01.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "lethin_bludder_mission_target_convotemplate",
	reactionStf = "@npc_reaction/military",
	attacks = merge(brawlermaster, teraskasinovice)
}

CreatureTemplates:addCreatureTemplate(defector_quest_lethin, "defector_quest_lethin")
