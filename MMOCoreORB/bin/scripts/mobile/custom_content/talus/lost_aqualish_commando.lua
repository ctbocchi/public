lost_aqualish_commando = Creature:new {
	objectName = "@mob/creature_names:lost_aqualish_commando",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "lost_aqualish",
	faction = "lost_aqualish",
	level = 120,
	chanceHit = 7.5,
	damageMin = 725,	
	damageMax = 950,
	baseXp = 9487,
	baseHAM = 42500,
	baseHAMmax = 51000,
	armor = 2,
	resists = {70,70,190,190,190,75,85,35,-1},
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
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_lost_aqualish_commando_female_01.iff",
		"object/mobile/dressed_lost_aqualish_commando_male_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 3000000},
				{group = "wearables_common", chance = 2000000},
				{group = "heavy_weapons", chance = 2000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		},
		{
			groups = {
				{group = "art_newhope1",       chance = 100 * (100000)},
			},
			lootChance = 3 * (100000)
		}
	},
	weapons = {"st_bombardier_weapons"},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/military",
	attacks = merge(commandonovice,marksmanmaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(lost_aqualish_commando, "lost_aqualish_commando")
