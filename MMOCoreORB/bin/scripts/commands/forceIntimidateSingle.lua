ForceIntimidateSingleCommand = {
	name = "forceintimidatesingle",

	damageMultiplier = 0,
	speed = 0,
	forceCost = 20,
	accuracySkillMod = "intimidate",
	forceAttack = true,
	visMod = 25,

	stateEffects = {
	  StateEffect(
		INTIMIDATE_EFFECT, 
		{}, 
		{ "intimidate_defense" }, 
		{}, 
		100,
		0,
		25
	  )
	},

	animation = "force_intimidate",

	combatSpam = "forceintimidatesingle",

	poolsToDamage = NO_ATTRIBUTE,

	range = 32
}

AddCommand(ForceIntimidateSingleCommand)

