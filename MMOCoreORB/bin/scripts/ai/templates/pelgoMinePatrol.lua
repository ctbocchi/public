pelgoMinePatrol = {
	--[[{"root", "Composite", "none", SELECTORBEHAVIOR},
	{"attack", "Composite", "root", SEQUENCEBEHAVIOR},
	--{"wander", "CompositeDefault", "root", SEQUENCEBEHAVIOR},
	--{"patrol", "GeneratePatrolDefault", "root", BEHAVIOR},
	{"attack0", "GetTarget", "attack", BEHAVIOR},
	{"attack1", "SelectWeapon", "attack", BEHAVIOR},
	{"attack2", "SelectAttack", "attack", BEHAVIOR},
	{"attack3", "CombatMove", "attack", BEHAVIOR},
	{"move0", "WalkDefault", "wander", BEHAVIOR},
	{"move1", "Wait10Default", "wander", BEHAVIOR},]]


	
	{"root", "CompositeVillageRaider", "none", SELECTORBEHAVIOR},
	{"attack", "CompositeVillageRaider", "root", SEQUENCEBEHAVIOR},
	{"move", "WalkDefault", "root", SEQUENCEBEHAVIOR},
	{"attack0", "GetTargetVillageRaider", "attack", BEHAVIOR},
	{"attack1", "SelectWeaponVillageRaider", "attack", BEHAVIOR},
	{"attack2", "SelectAttackVillageRaider", "attack", BEHAVIOR},
	{"attack3", "CombatMoveVillageRaider", "attack", BEHAVIOR},
	{"move0", "WalkDefault", "move", BEHAVIOR},
	--{"move1", "Wait10Default", "move", BEHAVIOR},
	{"move1", "WalkDefault", "move", BEHAVIOR},
	{"idle0", "MoveDefault", "root", BEHAVIOR},
	{"idle1", "WaitDefault", "root", BEHAVIOR},


}

addAiTemplate("pelgoMinePatrol", pelgoMinePatrol)
--[[
	{"root", "CompositeVillageRaider", "none", SELECTORBEHAVIOR},
	{"attack", "CompositeVillageRaider", "root", SEQUENCEBEHAVIOR},
	{"move", "CompositeVillageRaider", "root", SEQUENCEBEHAVIOR},
	{"patrol", "GeneratePatrolVillageRaider", "root", BEHAVIOR},
	{"attack0", "GetTargetVillageRaider", "attack", BEHAVIOR},
	{"attack1", "SelectWeaponVillageRaider", "attack", BEHAVIOR},
	{"attack2", "SelectAttackVillageRaider", "attack", BEHAVIOR},
	{"attack3", "CombatMoveVillageRaider", "attack", BEHAVIOR},
	{"move0", "MoveVillageRaider", "move", BEHAVIOR},
	{"move1", "Wait10VillageRaider", "move", BEHAVIOR},
]]