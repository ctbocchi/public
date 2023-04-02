sleemo_vandal = Creature:new {
	objectName = "",
	customName = "a Sleemo Vandal",
	socialGroup = "sleemo_gang",
	faction = "",
	level = 35,
	chanceHit = 0.87,
	damageMin = 320,
	damageMax = 490,
	baseXp = 3150,
	baseHAM = 7800,
	baseHAMmax = 9200,
	armor = 0,
	resists = {15,15,35,5,-1,10,-1,15,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_hoodlum_zabrak_female_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3200000},
				{group = "wearables_common", chance = 2000000},
				{group = "rifles", chance = 700000},
				{group = "melee_knife", chance = 700000},
				{group = "pistols", chance = 700000},
				{group = "carbines", chance = 700000},
				{group = "printer_parts", chance = 1000000},
				{group = "loot_kit_parts", chance = 1000000},
			}
		}
	},
	weapons = {"melee_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang",
	attacks = merge(fencermaster,swordsmanmaster,tkamid,brawlermaster,pikemanmaster)
}

CreatureTemplates:addCreatureTemplate(sleemo_vandal, "sleemo_vandal")
