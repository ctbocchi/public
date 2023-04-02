talus_liberation_party_reactionist = Creature:new {
	objectName = "@mob/creature_names:liberation_reactionist",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "liberation_party",
	faction = "liberation_party",
	level = 80,
	chanceHit = 1.25,
	damageMin = 550,
	damageMax = 700,
	baseXp = 7198,
	baseHAM = 11000,
	baseHAMmax = 14000,
	armor = 1,
	resists = {45,25,155,150,150,5,5,35,-1},
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
				{group = "rifles", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},
	weapons = {"st_flame_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(brawlermaster,marksmanmaster,commandomaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(talus_liberation_party_reactionist, "talus_liberation_party_reactionist")
