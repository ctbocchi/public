hirsch_sif = Creature:new {
	objectName = "@mob/creature_names:hirsch_sif",
	socialGroup = "sif",
	faction = "sif",
	level = 120,
	chanceHit = 3.25,
	damageMin = 450,
	damageMax = 770,
	baseXp = 8640,
	baseHAM = 110000,
	baseHAMmax = 125000,
	armor = 1,
	resists = {45,75,75,25,25,35,15,65,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 2 * 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_hirsch_sif.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 5000000},
				{group = "rifles", chance = 1000000},
				{group = "pistols", chance = 1000000},
				{group = "melee_weapons", chance = 1000000},
				{group = "carbines", chance = 1000000},
				{group = "wearables_common", chance = 1000000}
			}
		}
	},
	weapons = {"sif_weapons"},
	reactionStf = "@npc_reaction/military",
	attacks = merge(brawlermaster,fencermaster,swordsmanmaster)
}

CreatureTemplates:addCreatureTemplate(hirsch_sif, "hirsch_sif")
