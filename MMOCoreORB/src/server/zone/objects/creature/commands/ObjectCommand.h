/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef OBJECTCOMMAND_H_
#define OBJECTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/loot/LootManager.h"
#include "server/zone/managers/crafting/CraftingManager.h"
#include "server/zone/managers/crafting/ComponentMap.h"
#include "server/zone/objects/region/CityRegion.h"


class ObjectCommand : public QueueCommand {
public:

	ObjectCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		StringTokenizer args(arguments.toString());

		try {
			String commandType;
			args.getStringToken(commandType);

			if (commandType.beginsWith("createitem")) {
				String objectTemplate;
				args.getStringToken(objectTemplate);

				ManagedReference<CraftingManager*> craftingManager = creature->getZoneServer()->getCraftingManager();
				if(craftingManager == nullptr) {
					return GENERALERROR;
				}

				Reference<SharedObjectTemplate*> shot = TemplateManager::instance()->getTemplate(objectTemplate.hashCode());

				if (shot == nullptr || !shot->isSharedTangibleObjectTemplate()) {
					creature->sendSystemMessage("Templates must be tangible objects, or descendants of tangible objects, only.");
					return INVALIDPARAMETERS;
				}

				ManagedReference<SceneObject*> inventory = creature->getSlottedObject("inventory");

				if (inventory == nullptr || inventory->isContainerFullRecursive()) {
					creature->sendSystemMessage("Your inventory is full, so the item could not be created.");
					return INVALIDPARAMETERS;
				}

				ManagedReference<TangibleObject*> object = (server->getZoneServer()->createObject(shot->getServerObjectCRC(), 1)).castTo<TangibleObject*>();

				if (object == nullptr) {
					creature->sendSystemMessage("The object '" + commandType + "' could not be created because the template could not be found.");
					return INVALIDPARAMETERS;
				}

				Locker locker(object);

				object->createChildObjects();

				// Set Crafter name and generate serial number
				String name = "Generated with Object Command";
				object->setCraftersName(name);

				StringBuffer customName;
				customName << object->getDisplayedName() <<  " (System Generated)";

				object->setCustomObjectName(customName.toString(), false);

				String serial = craftingManager->generateSerial();
				object->setSerialNumber(serial);

				int quantity = 1;

				if (args.hasMoreTokens())
					quantity = args.getIntToken();

				if(quantity > 1 && quantity <= 100)
					object->setUseCount(quantity);

				// load visible components
				while (args.hasMoreTokens()) {
					String visName;
					args.getStringToken(visName);

					uint32 visId = visName.hashCode();
					if (ComponentMap::instance()->getFromID(visId).getId() == 0)
						continue;

					object->addVisibleComponent(visId, false);
				}

				if (inventory->transferObject(object, -1, true)) {
					inventory->broadcastObject(object, true);
				} else {
					object->destroyObjectFromDatabase(true);
					creature->sendSystemMessage("Error transferring object to inventory.");
				}
			} else if (commandType.beginsWith("createloot")) {
				String lootGroup;
				args.getStringToken(lootGroup);

				int level = 1;

				if (args.hasMoreTokens())
					level = args.getIntToken();

				ManagedReference<SceneObject*> inventory = creature->getSlottedObject("inventory");

				if (inventory == nullptr || inventory->isContainerFullRecursive()) {
					creature->sendSystemMessage("Your inventory is full, so the item could not be created.");
					return INVALIDPARAMETERS;
				}

				ManagedReference<LootManager*> lootManager = creature->getZoneServer()->getLootManager();

				if (lootManager == nullptr)
					return INVALIDPARAMETERS;

				lootManager->createLoot(inventory, lootGroup, level);
			}else if (commandType.beginsWith("createattachment")) {
				//Syntax exmaple /object createattachment clothing mindblast_accuracy 25
				String attachmentType;
				String skillMod;
				args.getStringToken(attachmentType);
		
				if (attachmentType != "armor" && attachmentType != "clothing"){
					creature->sendSystemMessage("You must specify armor or clothing.");
					return INVALIDPARAMETERS;
				}

				if (args.hasMoreTokens())
					args.getStringToken(skillMod);
				
				int skillBonus = 1;
				if (args.hasMoreTokens())
					skillBonus = args.getIntToken();

				ManagedReference<SceneObject*> inventory = creature->getSlottedObject("inventory");

				if (inventory == nullptr || inventory->isContainerFullRecursive()) {
					creature->sendSystemMessage("Your inventory is full, so the item could not be created.");
					return INVALIDPARAMETERS;
				}

				ManagedReference<LootManager*> lootManager = creature->getZoneServer()->getLootManager();

				

				if (lootManager == nullptr)
					return INVALIDPARAMETERS;
					
				Reference<LootItemTemplate*> itemTemplate = nullptr;
				LootGroupMap* lootGroupMap = LootGroupMap::instance();
				if (attachmentType == "armor")
					itemTemplate = lootGroupMap->getLootItemTemplate("attachment_armor");
				else
					itemTemplate = lootGroupMap->getLootItemTemplate("attachment_clothing");
							
				ManagedReference<SceneObject*> ca = lootManager->createLootAttachment(itemTemplate,skillMod, skillBonus); 

				if (ca != nullptr){
					Attachment* attachment = cast<Attachment*>(ca.get());
								
					if (attachment != nullptr){
						Locker objLocker(attachment);
						if (inventory->transferObject(ca, -1, true, true)) { //Transfer tape to player inventory
							inventory->broadcastObject(ca, true);
						} else {
							ca->destroyObjectFromDatabase(true);
							creature->sendSystemMessage("Unable to place Skill Attachment in player's inventory!");
							return INVALIDPARAMETERS;
						}
						
					}
							
				}


			}
			 else if (commandType.beginsWith("createresource")) {
				String resourceName;
				args.getStringToken(resourceName);

				int quantity = 100000;

				if (args.hasMoreTokens())
					quantity = args.getIntToken();

				ManagedReference<ResourceManager*> resourceManager = server->getZoneServer()->getResourceManager();
				resourceManager->givePlayerResource(creature, resourceName, quantity);
			} else if (commandType.beginsWith("createarealoot")) {
				String lootGroup;
				args.getStringToken(lootGroup);

				int range = 32;
				if (args.hasMoreTokens())
					range = args.getIntToken();

				if( range < 0 )
					range = 32;

				if( range > 128 )
					range = 128;

				int level = 1;
				if (args.hasMoreTokens())
					level = args.getIntToken();

				ManagedReference<LootManager*> lootManager = creature->getZoneServer()->getLootManager();
				if (lootManager == nullptr)
					return INVALIDPARAMETERS;

				Zone* zone = creature->getZone();
				if (zone == nullptr)
					return GENERALERROR;

				// Find all objects in range
				SortedVector<QuadTreeEntry*> closeObjects;
				CloseObjectsVector* closeObjectsVector = (CloseObjectsVector*) creature->getCloseObjects();
				if (closeObjectsVector == nullptr) {
					zone->getInRangeObjects(creature->getPositionX(), creature->getPositionY(), range, &closeObjects, true);
				} else {
					closeObjectsVector->safeCopyTo(closeObjects);
				}

				// Award loot group to all players in range
				for (int i = 0; i < closeObjects.size(); i++) {
					SceneObject* targetObject = static_cast<SceneObject*>(closeObjects.get(i));

					if (targetObject->isPlayerCreature() && creature->isInRange(targetObject, range)) {

						CreatureObject* targetPlayer = cast<CreatureObject*>(targetObject);
						Locker tlock( targetPlayer, creature );

						ManagedReference<SceneObject*> inventory = targetPlayer->getSlottedObject("inventory");
						if (inventory != nullptr) {
							if( lootManager->createLoot(inventory, lootGroup, level) )
								targetPlayer->sendSystemMessage( "You have received a loot item!");
						}

						tlock.release();
					}
				}
			} else if (commandType.beginsWith("checklooted")) {
				ManagedReference<LootManager*> lootManager = creature->getZoneServer()->getLootManager();
				if (lootManager == nullptr)
					return INVALIDPARAMETERS;

				creature->sendSystemMessage("Number of Legendaries Looted: " + String::valueOf(lootManager->getLegendaryLooted()));
				creature->sendSystemMessage("Number of Exceptionals Looted: " + String::valueOf(lootManager->getExceptionalLooted()));
				creature->sendSystemMessage("Number of Magical Looted: " + String::valueOf(lootManager->getYellowLooted()));
			}

			else if (commandType.beginsWith("setconditiondamage")) {

				uint64 oid = 0;

				if (target == 0) {
					oid = args.getLongToken();
					if (oid == 0) {
						creature->sendSystemMessage("INVALID OBJECT.  Please specify a valid object id");
					}
				}
				else {
					oid = target;
				}

				ManagedReference<SceneObject*>object = server->getZoneServer()->getObject(oid, false);
				
				if (object == nullptr) {
					creature->sendSystemMessage("Error getting object - nullptr " + String::valueOf(oid));
					return GENERALERROR; 
				} 

				if (object->isCreatureObject() || object->isPlayerCreature()) {
					creature->sendSystemMessage("Do not use the /object setcondition command on creatures or players.");
					return INVALIDPARAMETERS;
				}

				int conditionDamage = 0;
				if (args.hasMoreTokens())
					conditionDamage = args.getIntToken();

				if (conditionDamage < 0)
					conditionDamage = 0;

				TangibleObject* tano = nullptr;
				if (object->isTangibleObject())
					tano = object->asTangibleObject();
				if (tano == nullptr) {
					creature->sendSystemMessage("Invalid object.  Please specify a tangible object");
					return INVALIDPARAMETERS;
				}
				else {
					int oldDamage = tano->getConditionDamage();
					int maxCondition = tano->getMaxCondition();
					if (conditionDamage > maxCondition)
						conditionDamage = maxCondition;
					Locker clocker(tano, creature);
					tano->setConditionDamage(conditionDamage,true);
					clocker.release();
					creature->sendSystemMessage("Condition damage of " + tano->getDisplayedName() + " changed from " + String::valueOf(oldDamage) + " to " + String::valueOf(conditionDamage));
				}
				
			}

			else if (commandType.beginsWith("setmaxcondition")) {

				uint64 oid = 0;
				
				if (target == 0) {
					oid = args.getLongToken();
					if (oid == 0) {
						creature->sendSystemMessage("INVALID OBJECT.  Please specify a valid object id");
					}
				}
				else {
					oid = target;
				}

				ManagedReference<SceneObject*>object = server->getZoneServer()->getObject(oid, false);
				
				if (object == nullptr) {
					creature->sendSystemMessage("Error getting object - nullptr " + String::valueOf(oid));
					return GENERALERROR; 
				} 

				if (object->isCreatureObject() || object->isPlayerCreature()) {
					creature->sendSystemMessage("Do not use the /object setmaxcondition command on creatures or players.");
					return INVALIDPARAMETERS;
				}

				int maxCondition = 1000;
				if (args.hasMoreTokens())
					maxCondition = args.getIntToken();

				if (maxCondition < 0)
					maxCondition = 1000;

				TangibleObject* tano = nullptr;
				if (object->isTangibleObject())
					tano = object->asTangibleObject();
				if (tano == nullptr) {
					creature->sendSystemMessage("Invalid object.  Please specify a tangible object.");
					return INVALIDPARAMETERS;
				}
				else {
					int oldMaxCondition = tano->getMaxCondition();
					int oldConditionDamage = tano->getConditionDamage();
					Locker clocker(tano, creature);
					tano->setMaxCondition(maxCondition,true);
					creature->sendSystemMessage("Max condition of " + tano->getDisplayedName() + " changed from " + String::valueOf(oldMaxCondition) + " to " + String::valueOf(maxCondition));
					if (oldConditionDamage > maxCondition) {
						tano->setConditionDamage(maxCondition,true);
					}
					clocker.release();
				}
			}

			else if (commandType.beginsWith("destroyobject")) {

				uint64 oid = args.getLongToken();

				if (oid == 0 ) {
					creature->sendSystemMessage("Invalid Object.  Please specify a valid object id");
				}

				ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(oid, false);

				if (object == nullptr) {
					creature->sendSystemMessage("Error getting object - nullptr " + String::valueOf(oid));
				} else {

					if (object->isStructureObject() || object->isCreatureObject() || object->isPlayerCreature() || object->isMissionTerminal()) {
						creature->sendSystemMessage("Do not use the /object destroyobject command on creatures, players, mission terminals, or structures.");
						return INVALIDPARAMETERS;
					}

					ManagedReference<CityRegion*>city = object->getCityRegion().get();

					Locker olocker(object, creature);

					if (city != nullptr && city->isCityDecoration(object)) {

						Locker clocker(city, creature);
						city->removeDecoration(object);
						clocker.release();
						creature->sendSystemMessage("@city/city:mt_removed"); // The object has been removed from the city.
					}

					String objectName = object->getDisplayedName();
					object->destroyObjectFromWorld(true);
					object->destroyObjectFromDatabase();
					creature->sendSystemMessage("The object, " + objectName + ", has been successfully destroyed from the database.");
					olocker.release();
				}
			}

			else if (commandType.beginsWith("setarmorpiercing")) {

				uint64 oid = 0;

				if (target == 0) {
					oid = args.getLongToken();
					if (oid == 0) {
						creature->sendSystemMessage("INVALID OBJECT.  Please specify a valid object id");
					}
				}
				else {
					oid = target;
				}

				ManagedReference<SceneObject*>object = server->getZoneServer()->getObject(oid, false);
				
				if (object == nullptr) {
					creature->sendSystemMessage("Error getting object - nullptr " + String::valueOf(oid));
					return GENERALERROR; 
				} 

				if (!object->isWeaponObject()) {
					creature->sendSystemMessage("/object setarmorpiercing can only be used on weapon objects.");
					return INVALIDPARAMETERS;
				}

				WeaponObject* weapon = cast<WeaponObject*>(object.get());

				if (weapon == nullptr) {
					creature->sendSystemMessage("/object setarmorpiercing can only be used on weapon objects.");
					return INVALIDPARAMETERS;
				}

				int oldAP = weapon->getArmorPiercing();
				int newAP = 0;

				if (args.hasMoreTokens())
					newAP = args.getIntToken();

				if (newAP < 0 || newAP > 3) {
					creature->sendSystemMessage("Valid values for armorpiercing are 0-3 (None, Light, Medium, Heavy).");
					return INVALIDPARAMETERS;
				}

				if (newAP == oldAP) {
					creature->sendSystemMessage("No change made to armor piercing of weapon.");
					return GENERALERROR;
				}
				else {
					Locker clocker(weapon, creature);
					weapon->setArmorPiercing(newAP);
					creature->sendSystemMessage("Armor piercing of " + weapon->getDisplayedName() + " changed from " + String::valueOf(oldAP) + " to " + String::valueOf(newAP));
					clocker.release();
				}				
			}

			else {  // Didn't match any known commands, give them the options

				creature->sendSystemMessage("SYNTAX: /object createitem <objectTemplatePath> [<quantity>]");
				creature->sendSystemMessage("SYNTAX: /object createresource <resourceName> [<quantity>]");
				creature->sendSystemMessage("SYNTAX: /object createloot <loottemplate> [<level>]");
				creature->sendSystemMessage("SYNTAX: /object createarealoot <loottemplate> [<range>] [<level>]");
				creature->sendSystemMessage("SYNTAX: /object createattachment <armor/clothing> <skillModName> [<bonus>]");
				creature->sendSystemMessage("SYNTAX: /object checklooted");
				creature->sendSystemMessage("SYNTAX: /object destroyobject <objectID>");
				creature->sendSystemMessage("SYNTAX: /object setarmorpiercing [<objectID>] [<level>]");
				creature->sendSystemMessage("SYNTAX: /object setconditiondamage <objectID> <conditionDamage>");
				creature->sendSystemMessage("SYNTAX: /object setmaxcondition <objectID> <maxCondition>");
			}

	
		} catch (Exception& e) {
			creature->sendSystemMessage("SYNTAX: /object createitem <objectTemplatePath> [<quantity>]");
			creature->sendSystemMessage("SYNTAX: /object createresource <resourceName> [<quantity>]");
			creature->sendSystemMessage("SYNTAX: /object createloot <loottemplate> [<level>]");
			creature->sendSystemMessage("SYNTAX: /object createarealoot <loottemplate> [<range>] [<level>]");
			creature->sendSystemMessage("SYNTAX: /object createattachment <armor/clothing> <skillModName> [<bonus>]");
			creature->sendSystemMessage("SYNTAX: /object checklooted");
			creature->sendSystemMessage("SYNTAX: /object destroyobject <objectID>");
			creature->sendSystemMessage("SYNTAX: /object setarmorpiercing [<objectID>] [<level>]");
			creature->sendSystemMessage("SYNTAX: /object setconditiondamage [<objectID>] <conditionDamage>");
			creature->sendSystemMessage("SYNTAX: /object setmaxcondition [<objectID>] <maxCondition>");

			return INVALIDPARAMETERS;
		}



		return SUCCESS;
	}

};

#endif //OBJECTCOMMAND_H_
