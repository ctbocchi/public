/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FINDOBJECTCOMMAND_H_
#define FINDOBJECTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/player/sui/callbacks/FindObjectSuiCallback.h"
#include "server/zone/objects/tangible/components/CityDecorationMenuComponent.h"
#include "server/zone/objects/tangible/components/DestructibleCityDecorationMenuComponent.h"

class FindObjectCommand : public QueueCommand {
public:

	FindObjectCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		try {
			StringTokenizer tokenizer(arguments.toString());

			Reference<SceneObject*> targetObject = nullptr;
			Reference<PlayerObject*> ghost = creature->getSlottedObject("ghost").castTo<PlayerObject*>();

			if (!tokenizer.hasMoreTokens()) {
				targetObject = server->getZoneServer()->getObject(creature->getTargetID());

				if (targetObject != nullptr) {
					Locker crossLocker(targetObject, creature);

					Vector3 worldPosition = targetObject->getWorldPosition();

					ManagedReference<WaypointObject*> obj = server->getZoneServer()->createObject(0xc456e788, 1).castTo<WaypointObject*>();

					Locker waypointGuard(obj);

					obj->setPlanetCRC(targetObject->getPlanetCRC());
					obj->setPosition(worldPosition.getX(), 0, worldPosition.getY());
					obj->setActive(true);

					ghost->addWaypoint(obj, false, true);
					return SUCCESS;
				}
			}

			Zone* zone = creature->getZone();
			if(zone == nullptr)
				return GENERALERROR;

			String objectFilter;
			float range = zone->getMaxX() * 2;

			tokenizer.getStringToken(objectFilter);

			if (tokenizer.hasMoreTokens())
				range = tokenizer.getFloatToken();

			ManagedReference<SuiListBox*> findResults = new SuiListBox(creature, SuiWindowType::ADMIN_FIND_OBJECT);
			findResults->setCallback(new FindObjectSuiCallback(server->getZoneServer()));
			findResults->setPromptTitle("Find Object");
			findResults->setPromptText("Here are the objects that match your search:");
			findResults->setCancelButton(true, "");
			findResults->setOkButton(true, "@treasure_map/treasure_map:store_waypoint");
			findResults->setOtherButton(true, "@go");

			StringBuffer results;

			SortedVector<ManagedReference<QuadTreeEntry*> > objects(512, 512);
			zone->getInRangeObjects(creature->getPositionX(), creature->getPositionY(), range, &objects, true);

			for (int i = 0; i < objects.size(); ++i) {
				ManagedReference<SceneObject*> object = cast<SceneObject*>(objects.get(i).get());

				if (object == nullptr)
					continue;

				if (object == creature)
					continue;

                ManagedReference<TangibleObject*> tano = cast<TangibleObject*>(objects.get(i).get());				
				
				results.deleteAll();

				Locker crlocker(object, creature);
				
				if (tano != nullptr)
					Locker crlocker(tano, creature);

				String name = object->getDisplayedName();

				String serial = "";
				
				if (tano != nullptr)
					serial = tano->getSerialNumber();
				

				if (objectFilter == "-p") {
					if (!object->isPlayerCreature()) {
						crlocker.release();
						continue;
					}
				}
				else if (objectFilter == "-d") { // deco 

					CityDecorationMenuComponent* decorationMenu = cast<CityDecorationMenuComponent*>(object->getObjectMenuComponent());
					DestructibleCityDecorationMenuComponent* destructibleDecorationMenu = cast<DestructibleCityDecorationMenuComponent*>(object->getObjectMenuComponent());

					if (decorationMenu == nullptr && destructibleDecorationMenu == nullptr) { // Not city deco
						crlocker.release();
						continue;
					}
					else if (object->getCityRegion() != nullptr || object->isClientObject()) {	//skip anything inside city
							crlocker.release();
							continue;
						}
					else if (object->getRootParent() != nullptr) {  //Skip anything inside a cell
							crlocker.release();
							continue;
					}

				}
				else if (!name.toLowerCase().contains(objectFilter.toLowerCase()) && (!serial.toLowerCase().contains(objectFilter.toLowerCase()))) {
					crlocker.release();
					continue;
				}

				results << name;
				results << " (" << String::valueOf(object->getWorldPositionX());
				results << ", " << String::valueOf(object->getWorldPositionY()) << ")";

				findResults->addMenuItem(results.toString(), object->getObjectID());

				crlocker.release();
			}

			if (findResults->getMenuSize() < 1) {
				creature->sendSystemMessage("No objects were found that matched that filter.");
				return SUCCESS;
			}

			ghost->addSuiBox(findResults);
			creature->sendMessage(findResults->generateMessage());

		} catch (Exception& e) {
			creature->sendSystemMessage("Syntax: /findobject <string filter> <range>");
		}

		return SUCCESS;
	}

};

#endif //FINDOBJECTCOMMAND_H_