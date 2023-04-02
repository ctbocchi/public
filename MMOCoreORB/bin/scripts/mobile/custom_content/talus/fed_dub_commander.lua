fed_dub_commander = Creature:new {
	objectName = "@mob/creature_names:fed_dub_commander",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "fed_dub",
	faction = "fed_dub",
	level = 88,
	chanceHit = 2.25,
	damageMin = 660,
	damageMax = 960,
	baseXp = 7772,
	baseHAM = 12000,
	baseHAMmax = 15000,
	armor = 1,
	resists = {60,70,15,-1,-1,75,45,45,-1},
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

	templates = {
		"object/mobile/dressed_fed_dub_commander_bith_female_01.iff",
		"object/mobile/dressed_fed_dub_commander_bith_male_01.iff"},
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
	},--
	weapons = {"st_bombardier_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(brawlermaster,marksmanmaster,commandomaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(fed_dub_commander, "fed_dub_commander")
