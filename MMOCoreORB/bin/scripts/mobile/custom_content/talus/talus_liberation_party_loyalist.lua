talus_liberation_party_loyalist = Creature:new {
	objectName = "@mob/creature_names:liberation_loyalist",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "liberation_party",
	faction = "liberation_party",
	level = 84,
	chanceHit = 1.65,
	damageMin = 425,
	damageMax = 820,
	baseXp = 7237,
	baseHAM = 12000,
	baseHAMmax = 15000,
	armor = 1,
	resists = {20,35,175,175,195,10,5,40,-1},
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
				{group = "pistols", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"st_sniper_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmaster,brawlermaster,riflemanmaster)
}

CreatureTemplates:addCreatureTemplate(talus_liberation_party_loyalist, "talus_liberation_party_loyalist")
