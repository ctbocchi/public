lost_aqualish_marshal = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_marshal",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 105,
	chanceHit = 1.5,
	damageMin = 660,	
	damageMax = 840,
	baseXp = 8300,
	baseHAM = 33250,
	baseHAMmax = 39900,
	armor = 2,
	resists = {50,20,30,35,50,85,40,65,-1},
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
		"object/mobile/dressed_lost_aqualish_marshal_female_01.iff",
		"object/mobile/dressed_lost_aqualish_marshal_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2500000},
				{group = "wearables_common", chance = 2000000},
				{group = "heavy_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "color_crystals", chance = 500000}
			}
		},
		{
			groups = {
				{group = "art_newhope1",       chance = 100 * (100000)},
			},
			lootChance = 8 * (100000)
		}
	},
	weapons = {"dark_trooper_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(brawlermaster,marksmanmaster,fencermaster,riflemanmaster)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_marshal, "lost_aqualish_marshal")
