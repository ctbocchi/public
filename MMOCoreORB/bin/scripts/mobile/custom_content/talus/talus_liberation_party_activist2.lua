talus_liberation_party_activist2 = Creature:new {
	customName = "Liberation Army Occupation Forces",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "liberation_party",
	faction = "liberation_party",
	level = 140,
	chanceHit = 1.1,
	damageMin = 750,
	damageMax = 970,
	baseXp = 8389,
	baseHAM = 36000,
	baseHAMmax = 48000,
	armor = 2,
	resists = {35,75,75,65,65,40,5,25,-1},
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

	templates = {"object/mobile/dressed_talus_sif_mercenary_rodian_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "rifles", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
		{
			groups = {
				{group = "art_myriad2",       chance = 100 * (100000)},
			},
			lootChance = 4 * (100000)
		}
	},
	weapons = {"nyaxs_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(brawlermaster,marksmanmaster,swordsmanmaster,fencermaster)
}

CreatureTemplates:addCreatureTemplate(talus_liberation_party_activist2, "talus_liberation_party_activist2")
