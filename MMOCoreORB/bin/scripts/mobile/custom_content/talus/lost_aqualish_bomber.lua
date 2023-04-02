lost_aqualish_bomber = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_bomber",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 92,
	chanceHit = 1.5,
	damageMin = 650,	
	damageMax = 821,
	baseXp = 7274,
	baseHAM = 22500,
	baseHAMmax = 27000,
	armor = 2,
	resists = {15,55,35,75,30,40,15,65,-1},
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
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_lost_aqualish_bomber_female_01.iff",
		"object/mobile/dressed_lost_aqualish_bomber_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 2500000},
				{group = "wearables_common", chance = 2000000},
				{group = "heavy_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "color_crystals", chance = 500000}
			}
		},
		{
			groups = {
				{group = "art_newhope1",       chance = 100 * (100000)},
			},
			lootChance = 3 * (100000)
		}
	},
	weapons = {"cas_vankoo_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(brawlermid,marksmanmid,pikemanmid,pistoleermid)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_bomber, "lost_aqualish_bomber")
