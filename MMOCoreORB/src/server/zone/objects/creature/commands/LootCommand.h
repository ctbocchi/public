/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef LOOTCOMMAND_H_
#define LOOTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/managers/group/GroupLootTask.h"

class LootCommand : public QueueCommand {

public:
	enum {
		NOPICKUPITEMS = 0,
		ITEMFOROTHER = 1,
		PICKEDANDREMAINING = 2,
		PICKEDANDEMPTY = 3
	};

	LootCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (creature == nullptr || creature->isDead())
			return GENERALERROR;

		bool lootArea = arguments.toString().toLowerCase().beginsWith("area");
		bool lootAll = arguments.toString().toLowerCase().beginsWith("all");
		PlayerManager* playerManager = server->getZoneServer()->getPlayerManager();
		float range = 16.0f;

		if (!lootArea) {

			ManagedReference<AiAgent*> ai = server->getZoneServer()->getObject(target).castTo<AiAgent*>();
			if (ai == nullptr)
				return INVALIDTARGET;

			Locker locker(ai, creature);

			if (!ai->isDead())
				return GENERALERROR;

			ManagedReference<SceneObject* > object = server->getZoneServer()->getObject(target);

			if (object == nullptr)
				return GENERALERROR;

			CreatureObject* targetCreo = cast<CreatureObject*>(object.get());

			if (targetCreo == nullptr)
				return GENERALERROR;

			Creature* targetCreature = cast<Creature*>(targetCreo);

			if (targetCreature != nullptr && targetCreo->isCreature()) {
				if (targetCreature->getDnaState() == CreatureManager::DNADEATH) {
					creature->sendSystemMessage("You cannot loot a creature that has been killed by DNA sampling.");
					return GENERALERROR;
				}
			}

			float adjustedRange = range + Math::min(targetCreo->getTemplateRadius() / 4.0f, 8.0f);

			if (!targetCreo->isInRange(creature, adjustedRange)) { //Check range plus adjustment
				creature->sendSystemMessage("@error_message:target_out_of_range"); //"Your target is out of range for this action."
				return GENERALERROR;
			}

			//Get the corpse's inventory.
			SceneObject* lootContainer = ai->getSlottedObject("inventory");
			if (lootContainer == nullptr)
				return GENERALERROR;

			//Determine the loot rights.
			bool looterIsOwner = (lootContainer->getContainerPermissions()->getOwnerID() == creature->getObjectID());
			bool groupIsOwner = (lootContainer->getContainerPermissions()->getOwnerID() == creature->getGroupID());

			//Allow player to loot the corpse if they own it.
			if (looterIsOwner) {
				if (lootAll) {
					playerManager->lootAll(creature, ai);
				} else {
					//Check if the corpse's inventory contains any items.
					if (lootContainer->getContainerObjectsSize() < 1) {
						creature->sendSystemMessage("@error_message:corpse_empty"); //"You find nothing else of value on the selected corpse."
						playerManager->rescheduleCorpseDestruction(creature, ai);
					} else {
						ai->notifyObservers(ObserverEventType::LOOTCREATURE, creature, 0);
						lootContainer->openContainerTo(creature);
					}
				}
				return SUCCESS;
			}

			//If player and their group don't own the corpse, pick up any owned items left on corpse due to full inventory, then fail.
			if (!groupIsOwner) {
				int pickupResult = pickupOwnedItems(creature, lootContainer);
				if (pickupResult < 2) { //Player didn't pickup an item nor is one available for them.
					StringIdChatParameter noPermission("error_message","no_corpse_permission"); //"You do not have permission to access this corpse."
					creature->sendSystemMessage(noPermission);
					return GENERALERROR;
				} else if (pickupResult == PICKEDANDEMPTY) {
					playerManager->rescheduleCorpseDestruction(creature, ai);
					return SUCCESS;
				}

				return SUCCESS;
			}

			//If looter's group is the owner, attempt to pick up any owned items, then process group loot rule.
			int pickupResult = pickupOwnedItems(creature, lootContainer);
			switch (pickupResult) {
			case NOPICKUPITEMS: //No items available for anyone to pickup.
				break;
			case ITEMFOROTHER: //No items available for looter to pickup, but one is available for someone else.
				ai->notifyObservers(ObserverEventType::LOOTCREATURE, creature, 0);
				lootContainer->openContainerTo(creature);
				return SUCCESS;
			case PICKEDANDREMAINING: //An item was available for the looter, there are items remaining.
				return SUCCESS;
			case PICKEDANDEMPTY: //An item was available for the looter, there are NO items remaining.
				creature->getZoneServer()->getPlayerManager()->rescheduleCorpseDestruction(creature, ai);
				return SUCCESS;
			default:
				break;
			}

			ManagedReference<GroupObject*> group = creature->getGroup();
			if (group == nullptr)
				return GENERALERROR;

			GroupLootTask* task = new GroupLootTask(group, creature, ai, lootAll);
			task->execute();
		}
		else {
			
			Zone* zone = creature->getZone();

			if (zone == nullptr)
				return GENERALERROR;

			SortedVector<QuadTreeEntry*> closeObjects;
			CloseObjectsVector* closeObjectsVector = (CloseObjectsVector*) creature->getCloseObjects();
			if (closeObjectsVector == nullptr) {
				zone->getInRangeObjects(creature->getPositionX(), creature->getPositionY(), 32, &closeObjects, true);
			} else {
				closeObjectsVector->safeCopyTo(closeObjects);
			}

			for (int i = 0; i < closeObjects.size(); ++i) {
				SceneObject* sceneObj = cast<SceneObject*>(closeObjects.get(i));

				if (sceneObj == nullptr) 
					continue;

				if (!sceneObj->isAiAgent())
					continue;

				AiAgent* ai = sceneObj->asAiAgent();
				if (ai == nullptr || !ai->isDead())
					continue;

				CreatureObject* targetCreo = sceneObj->asCreatureObject();	
				if  (targetCreo == nullptr)
					continue;
	
				float adjustedRange = range + Math::min(targetCreo->getTemplateRadius() / 4.0f, 8.0f);

				if (!targetCreo->isInRange(creature, adjustedRange))  //Check range plus adjustment
					continue;

				Creature* targetCreature = cast<Creature*>(targetCreo);
					if (targetCreature != nullptr && targetCreo->isCreature()) {
						if (targetCreature->getDnaState() == CreatureManager::DNADEATH)
							continue;
					}
	
				Locker clocker(ai, creature);

				//Get the corpse's inventory.
				SceneObject* lootContainer = ai->getSlottedObject("inventory");
				if (lootContainer == nullptr) {
					clocker.release();
					continue;
				}

				//Determine the loot rights.
				bool looterIsOwner = (lootContainer->getContainerPermissions()->getOwnerID() == creature->getObjectID());
				bool groupIsOwner = (lootContainer->getContainerPermissions()->getOwnerID() == creature->getGroupID());

				//Allow player to loot the corpse if they own it.
				if (looterIsOwner) {
					playerManager->lootAll(creature, ai);
					clocker.release();
					continue;
				}

				//If player and their group don't own the corpse, pick up any owned items left on corpse due to full inventory, then fail.
				if (!groupIsOwner) {
					int pickupResult = pickupOwnedItems(creature, lootContainer);
					if (pickupResult < 2) { //Player didn't pickup an item nor is one available for them.
						clocker.release();
						continue;
					} else if (pickupResult == PICKEDANDEMPTY) {
						playerManager->rescheduleCorpseDestruction(creature, ai);
						clocker.release();
						continue;
					}
					clocker.release();
					continue;
				}

				//If looter's group is the owner, attempt to pick up any owned items, then process group loot rule.
				int pickupResult = pickupOwnedItems(creature, lootContainer);
				switch (pickupResult) {
				case NOPICKUPITEMS: //No items available for anyone to pickup.
					break;
				case ITEMFOROTHER: //No items available for looter to pickup, but one is available for someone else.
					ai->notifyObservers(ObserverEventType::LOOTCREATURE, creature, 0);
					lootContainer->openContainerTo(creature);
					clocker.release();
					continue;
				case PICKEDANDREMAINING: //An item was available for the looter, there are items remaining.
					clocker.release();
					continue;
				case PICKEDANDEMPTY: //An item was available for the looter, there are NO items remaining.
					playerManager->rescheduleCorpseDestruction(creature, ai);
					clocker.release();
					continue;
				default:
					break;
				}

				ManagedReference<GroupObject*> group = creature->getGroup();
				if (group == nullptr) {
					clocker.release();
					continue;
				}

				GroupLootTask* task = new GroupLootTask(group, creature, ai, true);
				task->execute();

				clocker.release();
			}
		}

		return SUCCESS;

	}

	int pickupOwnedItems(CreatureObject* creature, SceneObject* lootContainer) const {
		/* Return codes:
		 * NOPICKUPITEMS: No items available for anyone to pickup.
		 * ITEMFOROTHER: No items available for looter to pickup, but one is available for someone else.
		 * PICKEDANDREMAINING: An item was available for the looter, there are items remaining.
		 * PICKEDANDEMPTY: An item was available for the looter, there are NO items remaining.
		 */

		bool attemptedPickup = false;
		bool pickupAvailableOther = false;

		int totalItems = lootContainer->getContainerObjectsSize();
		if (totalItems < 1) return NOPICKUPITEMS;

		ContainerPermissions* contPerms = lootContainer->getContainerPermissions();
		if (contPerms == nullptr) return NOPICKUPITEMS;

		SceneObject* playerInventory = creature->getSlottedObject("inventory");
		if (playerInventory == nullptr) return NOPICKUPITEMS;

		//Check each loot item to see if the player owns it.
		for (int i = totalItems - 1; i >= 0; --i) {
			SceneObject* object = lootContainer->getContainerObject(i);
			if (object == nullptr)
				continue;

			ContainerPermissions* itemPerms = object->getContainerPermissions();
			if (itemPerms == nullptr)
				continue;

			//Check if player owns the loot item.
			uint64 itemOwnerID = itemPerms->getOwnerID();
			if (itemOwnerID == creature->getObjectID()) {

				//Attempt to transfer the item to the player.
				attemptedPickup = true;
				if (playerInventory->isContainerFullRecursive()) {
					StringIdChatParameter full("group", "you_are_full"); //"Your Inventory is full."
					creature->sendSystemMessage(full);
					return PICKEDANDREMAINING;
				}

				uint64 originalOwner = contPerms->getOwnerID();
				contPerms->setOwner(creature->getObjectID());

				if (creature->getZoneServer()->getObjectController()->transferObject(object, playerInventory, -1, true)) {
					itemPerms->clearDenyPermission("player", ContainerPermissions::OPEN);
					itemPerms->clearDenyPermission("player", ContainerPermissions::MOVECONTAINER);
				}

				contPerms->setOwner(originalOwner);

			} else if (itemOwnerID != 0)
				pickupAvailableOther = true;
		}

		//Determine which result code to return.
		if (attemptedPickup) {
			if (lootContainer->getContainerObjectsSize() > 0)
				return PICKEDANDREMAINING;
			else
				return PICKEDANDEMPTY;
		}

		if (pickupAvailableOther)
			return ITEMFOROTHER;

		return NOPICKUPITEMS;
	}

};

#endif //LOOTCOMMAND_H_
