wasteland_marauder = Creature:new {
	objectName = "@mob/creature_names:wasteland_marauder",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "endor_marauder",
	faction = "endor_marauder",
	level = 55,
	chanceHit = 0.55,
	damageMin = 420,
	damageMax = 550,
	baseXp = 5373,
	baseHAM = 11000,
	baseHAMmax = 13000,
	armor = 0,
	resists = {40,40,0,-1,0,0,-1,0,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.35,

	templates = {"object/mobile/dressed_wandering_desert_marauder.iff"},
	lootGroups = {
		{
			groups = {
				{group = "pistols", chance = 750000},
				{group = "carbines", chance = 750000},
				{group = "rifles", chance = 750000},
				{group = "melee_baton", chance = 1000000},
				{group = "loot_kit_parts", chance = 1000000},
				{group = "armor_attachments", chance = 500000},
				{group = "clothing_attachments", chance = 500000},
				{group = "bone_armor", chance = 800000},
				{group = "chitin_armor", chance = 800000},
				{group = "mabari_armor", chance = 800000},
				{group = "tantel_armor", chance = 800000},
				{group = "ubese_armor", chance = 800000},
				{group = "color_crystals", chance = 750000},
			}
		}
	},
	weapons = {"pirate_weapons_medium"},
	conversationTemplate = "",
	attacks = merge(riflemanmaster,pistoleermaster,carbineermaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(wasteland_marauder, "wasteland_marauder")
