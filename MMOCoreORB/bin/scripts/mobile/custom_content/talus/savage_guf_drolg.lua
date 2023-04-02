savage_guf_drolg = Creature:new {
	objectName = "@mob/creature_names:savage_guf_drolg",
	socialGroup = "guf_drolg",
	faction = "",
	level = 80,
	chanceHit = 0.75,
	damageMin = 570,
	damageMax = 850,
	baseXp = 7040,
	baseHAM = 18000,
	baseHAMmax = 21000,
	armor = 1,
	-- {kinetic,energy,blast,heat,cold,electricity,acid,stun,ls}
	resists = {165,160,30,190,190,190,30,30,-1},
	meatType = "meat_reptilian",
	meatAmount = 550,
	hideType = "hide_leathery",
	hideAmount = 460,
	boneType = "bone_mammal",
	boneAmount = 320,
	milk = 2 * 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/guf_drolg_hue.iff"},
	scale = 1.2,
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareacombo",""},
		{"intimidationattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(savage_guf_drolg, "savage_guf_drolg")
