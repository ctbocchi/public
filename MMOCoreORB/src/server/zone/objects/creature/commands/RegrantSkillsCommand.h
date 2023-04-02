/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef REGRANTSKILLSCOMMAND_H_
#define REGRANTSKILLSCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/skill/SkillManager.h"
#include "server/zone/managers/player/PlayerManager.h"

class RegrantSkillsCommand : public QueueCommand {
public:

	RegrantSkillsCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (creature == nullptr)
			return GENERALERROR;

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		// This command only works on the player executing the command

		Locker locker(creature);

		SkillManager* skillManager = SkillManager::instance();
		SkillList* skillList = creature->getSkillList();

		if (skillManager == nullptr || skillList == nullptr)
			return GENERALERROR;

		if (!creature->checkCooldownRecovery("regrantSkills")) {
                    creature->sendSystemMessage("You cannot have your skill regranted more than once per 12 hours.");
                    return GENERALERROR;
                }

		creature->updateCooldownTimer("regrantSkills", 43200000);

		String skillName = "";
		Vector<String> listOfNames;
		skillList->getStringList(listOfNames);
		SkillList copyOfList;
		copyOfList.loadFromNames(listOfNames);

		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();
		if (ghost != nullptr) {
			int preFrsXP = ghost->getExperience("force_rank_xp");

			for (int i = 0; i < copyOfList.size(); i++) {
				Skill* skill = copyOfList.get(i);
				String skillName = skill->getSkillName();

				if (!(skillName.beginsWith("admin") || skillName.beginsWith("infinity_"))) {
					skillManager->surrenderSkill(skillName, creature, true, true, false);
					bool skillGranted = skillManager->awardSkill(skillName, creature, true, true, true, true);
					creature->sendSystemMessage("Regranting SKill: " + skillName);
				}
			}

			int postFrsXP = ghost->getExperience("force_rank_xp");
			if (preFrsXP > postFrsXP) {
				ManagedReference<PlayerManager*> playerManager = creature->getZoneServer()->getPlayerManager();
					if (playerManager != nullptr)
						playerManager->awardExperience(creature, "force_rank_xp", (preFrsXP - postFrsXP), false);
			}

			return SUCCESS;
		}
		else {
			return GENERALERROR;
		}
	}

};

#endif //REGRANTSKILLSCOMMAND_H_
