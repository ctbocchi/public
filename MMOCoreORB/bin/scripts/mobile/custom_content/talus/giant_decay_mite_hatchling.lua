giant_decay_mite_hatchling = Creature:new {
    objectName = "@mob/creature_names:giant_decay_mite_hatchling",
    socialGroup = "mite",
    faction = "",
    level = 18,
    chanceHit = 0.33,
    damageMin = 190,
    damageMax = 300,
    baseXp = 1257,
    baseHAM = 5460,
    baseHAMmax = 6610,
    armor = 0,
    resists = {110,110,135,150,0,-1,145,145,-1},
    meatType = "meat_insect",
    meatAmount = 123,
    hideType = "hide_scaley",
    hideAmount = 123,
    boneType = "",
    boneAmount = 0,
    milk = 2 * 0,
    tamingChance = 0,
    ferocity = 0,
    pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
    creatureBitmask = PACK,
    optionsBitmask = AIENABLED,
    diet = CARNIVORE,
 
    templates = {"object/mobile/decay_mite.iff"},
    lootGroups = {},
    weapons = {},
    conversationTemplate = "",
    attacks = {
		{"",""},
        {"milddisease",""}
    }
}
 
CreatureTemplates:addCreatureTemplate(giant_decay_mite_hatchling, "giant_decay_mite_hatchling")
