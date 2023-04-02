fed_dub_supporter = Creature:new {
	objectName = "@mob/creature_names:fed_dub_supporter",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "fed_dub",
	faction = "fed_dub",
	level = 60,
	chanceHit = 0.9,
	damageMin = 325,
	damageMax = 580,
	baseXp = 6780,
	baseHAM = 8500,
	baseHAMmax = 10500,
	armor = 0,
	resists = {20,25,15,-1,-1,35,5,20,-1},
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
		"object/mobile/dressed_fed_dub_supporter_human_female_01.iff",
		"object/mobile/dressed_fed_dub_supporter_human_male_01.iff"},
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
	weapons = {"rebel_weapons_medium"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/townperson",
	attacks = merge(marksmanmid,brawlermid)
}

CreatureTemplates:addCreatureTemplate(fed_dub_supporter, "fed_dub_supporter")
