/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions. */

#ifndef FORCERUN1COMMAND_H_
#define FORCERUN1COMMAND_H_

#include "JediQueueCommand.h"
#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/objects/group/GroupObject.h"

class ForceRun1Command : public JediQueueCommand {
public:

	ForceRun1Command(const String& name, ZoneProcessServer* server)
	: JediQueueCommand(name, server) {
		// BuffCRC's, first one is used.
		buffCRC = BuffCRC::JEDI_FORCE_RUN_1;
    
        // If these are active they will block buff use
		blockingCRCs.add(BuffCRC::JEDI_FORCE_RUN_2);
		blockingCRCs.add(BuffCRC::JEDI_FORCE_RUN_3);
    
    		// Skill mods.
		skillMods.put("force_run", 1);
		skillMods.put("slope_move", 33);
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {
		ManagedReference<GroupObject*> group = creature->getGroup();

		if (creature->hasBuff(BuffCRC::JEDI_FORCE_RUN_1)) {		//Toggle force run off if active
			creature->removeBuff(BuffCRC::JEDI_FORCE_RUN_1);
			return SUCCESS;
		}

        int res = doJediSelfBuffCommand(creature);

		// Return if something is in error.
		if (res != SUCCESS) {
			return res;
		}

		// Cancel all other speed buffs
		if (creature->hasBuff(STRING_HASHCODE("burstrun"))) {
			creature->removeBuff(STRING_HASHCODE("burstrun"));
		}
		
		if (creature->hasBuff(STRING_HASHCODE("retreat"))) {
			creature->removeBuff(STRING_HASHCODE("retreat"));
		}

		if (creature->hasBuff(STRING_HASHCODE("dash"))) {
			creature->removeBuff(STRING_HASHCODE("dash"));
		}

		if (creature->hasBuff(STRING_HASHCODE("rocketboots"))) {
			creature->removeBuff(STRING_HASHCODE("rocketboots"));
		}

		return SUCCESS;
	}
};

#endif //FORCERUN1COMMAND_H_
