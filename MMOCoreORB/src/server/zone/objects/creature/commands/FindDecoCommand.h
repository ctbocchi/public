/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FINDDECOCOMMAND_H_
#define FINDDECOCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/objects/player/sui/callbacks/FindDecoSuiCallback.h"
#include "server/zone/objects/tangible/components/CityDecorationMenuComponent.h"
#include "server/zone/objects/tangible/components/DestructibleCityDecorationMenuComponent.h"

class FindDecoCommand : public QueueCommand {
public:

	FindDecoCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {
		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();
		if (ghost == nullptr)
			return GENERALERROR;

		Zone* zone = creature->getZone();
		if (zone == nullptr)
			return GENERALERROR;

		if (!creature->hasSkill("social_politician_master")) {
			creature->sendSystemMessage("You must be a master politician to use this command.");
			return GENERALERROR;
		}

		ManagedReference<CityRegion*> city = creature->getCityRegion().get();

		if (city == nullptr || !city->isMayor(creature->getObjectID())) { 
			creature->sendSystemMessage("You must be in a player city and be the mayor to use this command."); 
			return GENERALERROR;
		}

		if (creature->getRootParent() != nullptr) {  // Must be outside
			creature->sendSystemMessage("You must be outside in a player city to use this command."); 
			return GENERALERROR;
		}

		try {

			StringTokenizer tokenizer(arguments.toString());
			String objectFilter = "";

			if (tokenizer.hasMoreTokens()) {
				tokenizer.getStringToken(objectFilter);
			}

			ManagedReference<SuiListBox*> findResults = new SuiListBox(creature, SuiWindowType::FIND_DECO);
			findResults->setCallback(new FindDecoSuiCallback(server->getZoneServer()));
			findResults->setPromptTitle("Find Decoration");
			findResults->setPromptText("Here are the decoration objects found within your city:");
			findResults->setCancelButton(true, "");
			findResults->setOkButton(true, "@ui:teleport_decoration");
			findResults->setOtherButton(true, "@ui:remove_decoration");

			SortedVector<ManagedReference<QuadTreeEntry*> > objects(512, 512);
			zone->getInRangeObjects(city->getPositionX(), city->getPositionY(), city->getRadius(), &objects, true);

			for (int i = 0; i < objects.size(); ++i) {
				ManagedReference<SceneObject*> object = cast<SceneObject*>(objects.get(i).get());

				if (object == nullptr)
					continue;

				if (object == creature)
					continue;

				if (object->getRootParent() != nullptr)  //Skip anything inside a cell
					continue;

				if (object->isClientObject())
					continue;

 				if (!city->isCityDecoration(object))
					continue;

				CityDecorationMenuComponent* decorationMenu = cast<CityDecorationMenuComponent*>(object->getObjectMenuComponent());
				DestructibleCityDecorationMenuComponent* destructibleDecorationMenu = cast<DestructibleCityDecorationMenuComponent*>(object->getObjectMenuComponent());

				if (decorationMenu == nullptr && destructibleDecorationMenu == nullptr)  // Not city deco
					continue;

				String name = object->getDisplayedName();
				if (objectFilter != "" && !name.toLowerCase().contains(objectFilter.toLowerCase()))
					continue;
						
				StringBuffer results;
				results.deleteAll();

				results << name;
				results << "  (" << String::valueOf(object->getWorldPositionX());
				results << ", " << String::valueOf(object->getWorldPositionY()) << ")";
				findResults->addMenuItem(results.toString(), object->getObjectID());

			}

			if (findResults->getMenuSize() < 1) {
				creature->sendSystemMessage("No objects were found that matched that filter.");
				return SUCCESS;
			}

			ghost->addSuiBox(findResults);
			creature->sendMessage(findResults->generateMessage());

		} catch (Exception& e) {
			creature->sendSystemMessage("Syntax: /finddeco <string filter>");
		}

		return SUCCESS;
	}

};

#endif //FINDDECOCOMMAND_H_
