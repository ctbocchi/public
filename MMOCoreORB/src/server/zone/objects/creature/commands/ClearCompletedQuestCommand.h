/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef CLEARCOMPLETEDQUESTCOMMAND_H_
#define CLEARCOMPLETEDQUESTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"

class ClearCompletedQuestCommand : public QueueCommand {
public:

	ClearCompletedQuestCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (creature == nullptr)
			return GENERALERROR;

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
					creature->sendSystemMessage("SYNTAX: /clearCompleteQuest [player] screenplaystate <screenPlayStateName> <state>");
					return INVALIDTARGET;
				}
				

			}

			String commandType;
			args.getStringToken(commandType);

			if (commandType.beginsWith("screenplaystate")) {

				String screenPlayName;
				args.getStringToken(screenPlayName);
				uint64 state = args.getLongToken();
				state = ~state; // invert state to only clear the requested state.

				Locker targetLock(targetCreature);

				targetCreature->setScreenPlayState(screenPlayName, state & targetCreature->getScreenPlayState(screenPlayName));

				creature->sendSystemMessage(targetCreature->getFirstName() + " " + screenPlayName + " set to " + String::valueOf(targetCreature->getScreenPlayState(screenPlayName)));
			} else {
				creature->sendSystemMessage("SYNTAX: /clearCompleteQuest [player] screenplaystate <screenPlayStateName> <state>");

				return INVALIDPARAMETERS;
			}
		} catch (Exception& e) {
			creature->sendSystemMessage("SYNTAX: /clearCompleteQuest screenplaystate <screenPlayStateName> <state>");

			return INVALIDPARAMETERS;
		}

		return SUCCESS;
	}

};

#endif //CLEARCOMPLETEDQUESTCOMMAND_H_
