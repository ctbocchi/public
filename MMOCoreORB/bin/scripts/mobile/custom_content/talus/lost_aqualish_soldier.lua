lost_aqualish_soldier = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_soldier",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 85,
	chanceHit = 0.8,
	damageMin = 545,	
	damageMax = 645,
	baseXp = 6720,
	baseHAM = 18500,
	baseHAMmax = 22200,
	armor = 1,
	resists = {45,33,35,25,15,30,45,65,-1},
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
		"object/mobile/dressed_lost_aqualish_soldier_female_01.iff",
		"object/mobile/dressed_lost_aqualish_soldier_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "melee_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"carbine_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(marksmanmaster,carbineermaster)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_soldier, "lost_aqualish_soldier")
