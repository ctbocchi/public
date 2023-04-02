lost_aqualish_outrider = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_outrider",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 80,
	chanceHit = 1.0,
	damageMin = 589,	
	damageMax = 687,
	baseXp = 6325,
	baseHAM = 17500,
	baseHAMmax = 21000,
	armor = 1,
	resists = {25,48,25,25,15,45,15,32,-1},
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
		"object/mobile/dressed_lost_aqualish_outrider_female_01.iff",
		"object/mobile/dressed_lost_aqualish_outrider_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "rifles", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"boba_fett_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(bountyhuntermaster,marksmanmid)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_outrider, "lost_aqualish_outrider")
