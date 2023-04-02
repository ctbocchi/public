walkPatrol = {	
	{"root", "CompositeVillageRaider", "none", SELECTORBEHAVIOR},
	{"attack", "CompositeVillageRaider", "root", SEQUENCEBEHAVIOR},
	{"move", "WalkDefault", "root", SEQUENCEBEHAVIOR},
	{"attack0", "GetTargetVillageRaider", "attack", BEHAVIOR},
	{"attack1", "SelectWeaponVillageRaider", "attack", BEHAVIOR},
	{"attack2", "SelectAttackVillageRaider", "attack", BEHAVIOR},
	{"attack3", "CombatMoveVillageRaider", "attack", BEHAVIOR},
	{"move0", "WalkDefault", "move", BEHAVIOR},
	{"move1", "WalkDefault", "move", BEHAVIOR},
	{"idle0", "MoveDefault", "root", BEHAVIOR},
	{"idle1", "WaitDefault", "root", BEHAVIOR},
}
addAiTemplate("walkPatrol", walkPatrol)