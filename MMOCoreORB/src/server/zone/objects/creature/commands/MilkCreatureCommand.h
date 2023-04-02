/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef MILKCREATURECOMMAND_H_
#define MILKCREATURECOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/creature/ai/Creature.h"
#include "server/zone/managers/creature/CreatureManager.h"
#include "server/zone/Zone.h"

class MilkCreatureCommand : public QueueCommand {
public:

	MilkCreatureCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return INVALIDTARGET;

		ManagedReference<SceneObject* > object = server->getZoneServer()->getObject(target);

		ManagedReference<CreatureObject*> player = cast<CreatureObject*>(creature);

		if (player == nullptr)
			return GENERALERROR;

		if (object == nullptr || !object->isCreatureObject())
			return INVALIDTARGET;

		CreatureObject* targetCreo = cast<CreatureObject*>( object.get());

		if (!targetCreo->isCreature())
			return INVALIDTARGET;

		Creature* targetCreature = cast<Creature*>( targetCreo);

		if (targetCreature->canMilkMe(player)) {

			if (targetCreature->getZone() == nullptr)
				return GENERALERROR;

			ManagedReference<CreatureManager*> creatureManager = targetCreature->getZone()->getCreatureManager();
			creatureManager->milk(targetCreature, player);
		}
		else {
			if (!player->isInRange(targetCreature, 5.0f)) {
				player->sendSystemMessage("@skl_use:milk_out_of_range"); // You must be within 5 meters of the creature to begin milking it.
			}
			return INVALIDTARGET;
		}

		return SUCCESS;
	}

};

#endif //MILKCREATURECOMMAND_H_
