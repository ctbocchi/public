/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FINDMYTRAINERCOMMAND_H_
#define FINDMYTRAINERCOMMAND_H_

class FindMyTrainerCommand : public QueueCommand {
public:

	FindMyTrainerCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		PlayerObject* ghost = creature->getPlayerObject();

		if (ghost == nullptr)
			return GENERALERROR;

		if (ghost->getJediState() < 2 || !creature->hasSkill("force_title_jedi_rank_02"))
			return GENERALERROR;

		String resetArg = "";

		if (!arguments.isEmpty()) {
			resetArg = arguments.toString().toLowerCase();
		}

		bool resetTrainer = false;
		if (resetArg == "reset") {

			if (!creature->checkCooldownRecovery("findmytrainer"))  {
				Time* cooldownTime = creature->getCooldownTime("findmytrainer");
				if (cooldownTime != nullptr) {
					float timeLeft = round(fabs(cooldownTime->miliDifference() / 1000.f / 60.f / 60.f * 10.0f)) / 10.0f;
					creature->sendSystemMessage("You can use the findMyTrainer reset option again in " + String::valueOf(timeLeft) + " hour" + ((timeLeft == 1.0f) ? "." : "s."));
					return GENERALERROR;
				} 
				else {
					creature->sendSystemMessage("You can only use the findMyTrainer reset option once every 24 hours.");
					return GENERALERROR;
				}
			}
			resetTrainer = true;
			creature->updateCooldownTimer("findmytrainer", (1000 * 60 * 60 * 24 ));   //1 Day
		}

		String planet = ghost->getTrainerZoneName();

		if (resetTrainer || planet == "" || !isValidZone(planet)) {
			setJediTrainer(ghost);
			planet = ghost->getTrainerZoneName();
		}

		uint32 planetCRC = planet.hashCode();

		Vector3 coords = ghost->getTrainerCoordinates();

		String name = "@jedi_spam:trainer_waypoint_name";

		ManagedReference<WaypointObject*> obj = ( server->getZoneServer()->createObject(0xc456e788, 1)).castTo<WaypointObject*>();

		Locker locker(obj);

		obj->setPlanetCRC(planetCRC);
		obj->setPosition(coords.getX(), 0, coords.getY());
		obj->setCustomObjectName(name, false);

		ghost->addWaypoint(obj, true, true);

		creature->sendSystemMessage("@jedi_spam:waypoint_created_to_trainer");

		return SUCCESS;
	}

	static void setJediTrainer(PlayerObject* ghost) {
		ZoneServer* zServ = ghost->getZoneServer();

		if (zServ == nullptr)
			return;

		Vector<ManagedReference<SceneObject*> > trainers;
		Vector<String> trainerTypes;

		// Map categories defined here.
		trainerTypes.add("trainer_brawler");
		trainerTypes.add("trainer_artisan");
		trainerTypes.add("trainer_scout");
		trainerTypes.add("trainer_marksman");
		trainerTypes.add("trainer_entertainer");
		trainerTypes.add("trainer_medic");

		// Trainer number. Pick a random trainer, there are at least 600 in the galaxy.
		for (int i=0; i < zServ->getZoneCount(); ++i) {
			Zone* zone = zServ->getZone(i);
			for (int j=0; j < trainerTypes.size(); ++j) {
				SortedVector<ManagedReference<SceneObject*> > objectList = zone->getPlanetaryObjectList(trainerTypes.get(j));
				trainers.addAll(objectList);
			}
		}

		bool found = false;
		Vector3 coords;
		String zoneName = "";
		int size = trainers.size();

		if (size <= 0)
			return;

		while (!found) {
			SceneObject* trainer = trainers.get(System::random(size - 1));

			if (trainer == nullptr)
				continue;

			CreatureObject* trainerCreo = trainer->asCreatureObject();

			if (trainerCreo == nullptr)
				continue;

			if (!(trainerCreo->getOptionsBitmask() & OptionBitmask::CONVERSE))
				continue;

			ManagedReference<CityRegion*> city = trainerCreo->getCityRegion().get();

			// Make sure it's not a player-city trainer.
			if (city != nullptr && !city->isClientRegion())
				continue;

			zoneName = trainerCreo->getZone()->getZoneName();

            if (!isValidZone(zoneName))
                continue;

			coords = trainerCreo->getWorldPosition();
			found = true;

		}

		ghost->setTrainerCoordinates(coords);
		ghost->setTrainerZoneName(zoneName); // For the waypoint.
	}

    static bool isValidZone(String zoneName)
    {
        if (zoneName == "corellia")
            return true;
        if (zoneName == "dantooine")
            return true;
        if (zoneName == "dathomir")
            return true;
        if (zoneName == "endor")
            return true;
        if (zoneName == "lok")
            return true;
        if (zoneName == "naboo")
            return true;
        if (zoneName == "rori")
            return true;
        if (zoneName == "talus")
            return true;
        if (zoneName == "tatooine")
            return true;
        if (zoneName == "yavin4")
            return true;

        return false;
    }
};

#endif //FINDMYTRAINERCOMMAND_H_
