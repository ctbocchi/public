lost_aqualish_captain = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_captain",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 110,
	chanceHit = 2.25,
	damageMin = 515,	
	damageMax = 1000,
	baseXp = 8697,
	baseHAM = 24670,
	baseHAMmax = 29604,
	armor = 2,
	resists = {65,85,45,55,40,60,75,40,-1},
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
		"object/mobile/dressed_lost_aqualish_captain_female_01.iff",
		"object/mobile/dressed_lost_aqualish_captain_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "heavy_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
		{
			groups = {
				{group = "captain_ring_group", chance = 10000000},
			},
			lootChance = .25 * (100000)
		}
	},
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(brawlermaster,marksmanmaster,carbineermid,swordsmannovice)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_captain, "lost_aqualish_captain")
