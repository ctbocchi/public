/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FORCETHROW2COMMAND_H_
#define FORCETHROW2COMMAND_H_

#include "ForcePowersQueueCommand.h"

class ForceThrow2Command : public ForcePowersQueueCommand {
public:

	ForceThrow2Command(const String& name, ZoneProcessServer* server)
		: ForcePowersQueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (isWearingArmor(creature)) {
			return NOJEDIARMOR;
		}

		ManagedReference<SceneObject* > object = server->getZoneServer()->getObject(target);

		ManagedReference<CreatureObject* > targetCreature = nullptr;
		targetCreature = cast<CreatureObject*>( object.get());

		if (targetCreature != nullptr)
			targetCreature->playEffect("clienteffect/mustafar/dark_jedi_rock_attack_1.cef", "");

		UnicodeString args = "healthDamageMultiplier=0.33f;actionDamageMultiplier=0.33f;mindDamageMultiplier=0.33f;";

		return doCombatAction(creature, target, args);
	}
	float getCommandDuration(CreatureObject* object, const UnicodeString& arguments) const {
		return speed;
	}

};

#endif //FORCETHROW2COMMAND_H_
