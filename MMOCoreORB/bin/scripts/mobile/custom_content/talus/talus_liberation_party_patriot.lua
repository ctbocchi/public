talus_liberation_party_patriot = Creature:new {
	objectName = "@mob/creature_names:liberation_patriot",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "liberation_party",
	faction = "liberation_party",
	level = 74,
	chanceHit = 1.45,
	damageMin = 390,
	damageMax = 580,
	baseXp = 6890,
	baseHAM = 11000,
	baseHAMmax = 14000,
	armor = 1,
	resists = {15,35,150,160,160,0,5,45,-1},
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

	templates = {"object/mobile/dressed_talus_sif_mercenary_trand_01.iff"},
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
	weapons = {"pirate_weapons_heavy"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmaster,riflemanmaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(talus_liberation_party_patriot, "talus_liberation_party_patriot")
