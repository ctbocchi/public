talus_liberation_party_volunteer = Creature:new {
	objectName = "@mob/creature_names:liberation_volunteer",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "liberation_party",
	faction = "liberation_party",
	level = 60,
	chanceHit = 1.15,
	damageMin = 340,
	damageMax = 520,
	baseXp = 6226,
	baseHAM = 8500,
	baseHAMmax = 10500,
	armor = 0,
	resists = {25,30,145,140,140,0,5,25,-1},
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
				{group = "melee_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"pirate_weapons_light"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmannovice,brawlernovice,pikemanmaster,fencermaster,pistoleermaster)
}

CreatureTemplates:addCreatureTemplate(talus_liberation_party_volunteer, "talus_liberation_party_volunteer")
