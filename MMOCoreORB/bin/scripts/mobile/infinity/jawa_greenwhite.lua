jawa_greenwhite = Creature:new {
    customName = "A Festive Jawa",
	socialGroup = "townsperson",
	faction = "",
	level = 300,
	chanceHit = 2.75,
	damageMin = 790,
	damageMax = 1150,
	baseXp = 3921,
	baseHAM = 80300,
	baseHAMmax = 123012,
	armor = 1,
	-- {kinetic,energy,blast,heat,cold,electricity,acid,stun,ls}
	resists = {25,25,25,25,25,25,25,25,25},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
  scale = 1.8,

	templates = {"object/mobile/jawa_greenwhite.iff"},

	lootGroups = {
		{
			groups = {
				{group = "mtg_paintings", chance = 30 * 100000},
				{group = "power_crystals", chance = 25 * 100000},
				{group = "holocron_dark", chance = 2.5 * 100000},
				{group = "named_crystals", chance = 17.5 * 100000},
				{group = "clothing_attachments", chance = 25 * 100000}
			},
			lootChance = 85 * 100000
		},
    	{
    		groups = {
				{group = "mtg_paintings", chance = 30 * 100000},
				{group = "power_crystals", chance = 25 * 100000},
				{group = "holocron_light", chance = 2.5 * 100000},
				{group = "named_crystals", chance = 17.5 * 100000},
				{group = "clothing_attachments", chance = 25 * 100000}
			},
        	lootChance = 85 * 100000
        },
		{ -- Jedi Specific Loot Group
			groups = {
				{group = "jedi_clothing_attachments", chance = 40 * 100000},
				{group = "named_crystals", chance = 60 * 100000},
			},
			lootChance = 20 * 100000,
		},
    	{ -- Veteran Rewards
      		groups = {
				{group = "veteran_rewards_90_days", chance = 60 * 100000},
				{group = "veteran_rewards_180_days", chance = 30 * 100000},
				{group = "veteran_rewards_360_days", chance = 1 * 100000},
				{group = "veteran_rewards_450_days", chance = 9 * 100000},
			},
			lootChance = 35 * 100000,
		},
		{ -- XJ-2 Airspeeder
			groups = {
				{group = "landspeeder_organa", chance = 100 * 100000},
	  		},
	  		lootChance = 10 * 100000,
		},
		{ -- Xmas Crystals
			groups = {
				{group = "xmas_crystals", chance = 100 * 100000},
			},
			lootChance = 15 * 100000,
		},
	},
	weapons = {"mixed_force_weapons"},
	conversationTemplate = "",
	attacks = merge(fencermaster,swordsmanmaster,tkamid,brawlermaster,pikemanmaster,forcewielder)
}
CreatureTemplates:addCreatureTemplate(jawa_greenwhite, "jawa_greenwhite")
