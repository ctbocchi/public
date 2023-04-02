sleemo_punk = Creature:new {
	objectName = "@mob/creature_names:sleemo_punk",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "sleemo_gang",
	faction = "",
	level = 22,
	chanceHit = 0.68,
	damageMin = 200,
	damageMax = 340,
	baseXp = 2168,
	baseHAM = 4900,
	baseHAMmax = 6100,
	armor = 0,
	resists = {5,-1,20,-1,-1,5,-1,5,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = STALKER + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_hooligan_rodian_male_01.iff"},
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
	attacks = merge(fencermaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(sleemo_punk, "sleemo_punk")
