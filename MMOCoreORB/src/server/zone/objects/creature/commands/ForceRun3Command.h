
/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions. */

#ifndef FORCERUN3COMMAND_H_
#define FORCERUN3COMMAND_H_

#include "server/zone/objects/creature/buffs/PrivateSkillMultiplierBuff.h"
#include "JediQueueCommand.h"

class ForceRun3Command : public JediQueueCommand {
public:

	ForceRun3Command(const String& name, ZoneProcessServer* server)
	: JediQueueCommand(name, server) {

		// BuffCRC's, first one is used.
		buffCRC = BuffCRC::JEDI_FORCE_RUN_3;
        // If these are active they will block buff use
		blockingCRCs.add(BuffCRC::JEDI_FORCE_RUN_1);
		blockingCRCs.add(BuffCRC::JEDI_FORCE_RUN_2);
        
		skillMods.put("force_run", 3);
		skillMods.put("slope_move", 99);
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (creature->hasBuff(BuffCRC::JEDI_FORCE_RUN_3)) {		//If ForceRun3 is up, toggle it off and set cooldown to 10 seconds
			creature->removeBuff(BuffCRC::JEDI_FORCE_RUN_3);
            creature->updateCooldownTimer("forcerun3", 10000/creature->getFrsMod("manipulation"));
			return SUCCESS;
		}

		if (creature->isInCombat()){
			creature->sendSystemMessage("You can't focus enough to use Force Run 3 in combat.");
                    return GENERALERROR;
		}
		
		ManagedReference<PlayerObject*> player = creature->getPlayerObject();
		
		if (player != nullptr)
		if (player->hasPvpTef() || player->hasBhTef()){
			creature->sendSystemMessage("You cannot use Force Run 3 so soon after being in PVP combat.");
            return GENERALERROR;
		}
			

		if (!creature->checkCooldownRecovery("forcerun3")) {
			creature->sendSystemMessage("You cannot use Force Run 3 yet.");
			return GENERALERROR;
		}

		int res = doJediSelfBuffCommand(creature);

		if (res != SUCCESS) {
			return res;
		}

		// need to apply the damage reduction in a separate buff so that the multiplication and division applies right
		Buff* buff = creature->getBuff(BuffCRC::JEDI_FORCE_RUN_3);
		if (buff == NULL)
			return GENERALERROR;

		ManagedReference<PrivateSkillMultiplierBuff*> multBuff = new PrivateSkillMultiplierBuff(creature, name.hashCode(), duration, BuffType::JEDI);

		Locker locker(multBuff);

		multBuff->setSkillModifier("private_damage_divisor", 20);

		creature->addBuff(multBuff);

		locker.release();

		Locker blocker(buff);

		buff->addSecondaryBuffCRC(multBuff->getBuffCRC());

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

#endif //FORCERUN3COMMAND_H_
