/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef COMPLETEQUESTCOMMAND_H_
#define COMPLETEQUESTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"

class CompleteQuestCommand : public QueueCommand {
public:

	CompleteQuestCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (creature == nullptr)
			return GENERALERROR;

		StringTokenizer args(arguments.toString());

		try {

			StringTokenizer args(arguments.toString());
			ManagedReference<SceneObject*> obj = nullptr;
			CreatureObject* targetCreature = nullptr;

			if (target != 0) {
				obj = server->getZoneServer()->getObject(target);
				if (obj == nullptr || !obj->isPlayerCreature()) {
					return INVALIDTARGET;
				}
				else {
					targetCreature = cast<CreatureObject*>(obj.get());
				}
				if (targetCreature == nullptr) {
					return INVALIDTARGET;
				}
			}
			else {
				String playerName;
				args.getStringToken(playerName);
				targetCreature = server->getZoneServer()->getPlayerManager()->getPlayer(playerName);
				if (targetCreature == nullptr) {
					creature->sendSystemMessage("SYNTAX: /completeQuest [player] screenplaystate <screenPlayStateName> <state>");
					creature->sendSystemMessage("SYNTAX: /completeQuest [player] quest <quest>");
					return INVALIDTARGET;
				}
			}

			String commandType;
			args.getStringToken(commandType);
	
			Locker targetLock(targetCreature, creature);

			if (commandType.beginsWith("screenplaystate")) {
				String screenPlayName;
				args.getStringToken(screenPlayName);
				uint64 state = args.getLongToken();

				targetCreature->setScreenPlayState(screenPlayName, state | targetCreature->getScreenPlayState(screenPlayName));

				creature->sendSystemMessage(targetCreature->getFirstName() + " " + screenPlayName + " set to " + String::valueOf(targetCreature->getScreenPlayState(screenPlayName)));

			} else if (commandType.beginsWith("quest")) {
				PlayerObject* ghost = targetCreature->getPlayerObject();

				if (ghost == nullptr)
					return INVALIDTARGET;

				int quest = args.getIntToken();

				ghost->completeQuest(quest);

			} else {
				creature->sendSystemMessage("SYNTAX: /completeQuest [player] screenplaystate <screenPlayStateName> <state>");
				creature->sendSystemMessage("SYNTAX: /completeQuest [player] quest <quest>");

				return INVALIDPARAMETERS;
			}
		} catch (Exception& e) {
			creature->sendSystemMessage("SYNTAX: /completeQuest [player] screenplaystate <screenPlayStateName> <state>");
			creature->sendSystemMessage("SYNTAX: /completeQuest [player] quest <quest>");

			return INVALIDPARAMETERS;
		}

		return SUCCESS;
	}

};

#endif //COMPLETEQUESTCOMMAND_H_
