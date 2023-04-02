/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef GRANTSKILLCOMMAND_H_
#define GRANTSKILLCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/skill/SkillManager.h"

class GrantSkillCommand : public QueueCommand {
public:

	GrantSkillCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {
		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object == nullptr || !object->isCreatureObject() || !object->isPlayerCreature())
			return INVALIDTARGET;

		CreatureObject* targetCreature = cast<CreatureObject*>( object.get());

		if (targetCreature == nullptr)
			return INVALIDTARGET;

		Locker clocker(targetCreature, creature);

		String skillName = arguments.toString();
		String firstName = targetCreature->getFirstName();

		if (!targetCreature->hasSkill(skillName)) {

			SkillManager* skillManager = SkillManager::instance();
			bool skillGranted = skillManager->awardSkill(skillName, targetCreature, true, true, true, false, true);

			if (skillGranted) {
				StringIdChatParameter params;
				params.setTO(skillName);
				params.setStringId("skill_teacher", "skill_terminal_grant");
				targetCreature->sendSystemMessage(params);
				creature->sendSystemMessage("Granted skill " + skillName + "to player " + firstName);
			}
			else {
				StringIdChatParameter params;
				params.setTO(skillName);
				params.setStringId("skill_teacher", "prose_train_failed");
				targetCreature->sendSystemMessage(params);
				creature->sendSystemMessage("Failed to grant skill " + skillName + "to player " + firstName);
			}
		}
		else {
			creature->sendSystemMessage("Player " + firstName + " already has skill " + skillName);
		}

		clocker.release();

		return SUCCESS;
	}

};

#endif //GRANTSKILLCOMMAND_H_
