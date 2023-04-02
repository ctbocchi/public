/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FORCEINTIMIDATESINGLECOMMAND_H_
#define FORCEINTIMIDATESINGLECOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "ForcePowersQueueCommand.h"
#include "server/zone/objects/creature/events/ForceIntimidateTask.h"

class ForceIntimidateSingleCommand : public ForcePowersQueueCommand {
public:

	ForceIntimidateSingleCommand(const String& name, ZoneProcessServer* server)
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
		
		ManagedReference<SceneObject*> targetObject = server->getZoneServer()->getObject(target);

		if (targetObject == nullptr || !targetObject->isCreatureObject()) {
			return INVALIDTARGET;
		}
		CreatureObject *tarCreo = targetObject->asCreatureObject();

		if (!tarCreo->checkCooldownRecovery("forceintimidatesingle")) {
				creature->sendSystemMessage("You cannot use force intimidate single against this target again yet.");
				return GENERALERROR;
		}

		if (!tarCreo->checkCooldownRecovery("fortifyintimidate")) {
			Time* cooldownTime = tarCreo->getCooldownTime("fortifyintimidate");
			if (cooldownTime != nullptr) {
				float timeLeft = fabs(cooldownTime->miliDifference());
				//creature->sendSystemMessage("Cooldown in milliseconds = " + String::valueOf(timeLeft));	
				if (timeLeft > 2000) {
					creature->sendSystemMessage("Your target has been intimidated by Fortify and you cannot use force intimidate single against this target yet.");
					return GENERALERROR;
				}
			}
		}

		int res = doCombatAction(creature, target);

		if (res != TOOFAR && res != INVALIDTARGET) {
        	tarCreo->updateCooldownTimer("forceintimidatesingle", 6000);
		}
		
		return res;
	}
};

#endif //FORCEINTIMIDATESINGLECOMMAND_H_
