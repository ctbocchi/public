#include "server/zone/managers/frs/FrsManager.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/managers/frs/RankMaintenanceTask.h"
#include "server/zone/managers/frs/FrsRankingData.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/objects/player/variables/FrsData.h"
#include "server/zone/objects/building/BuildingObject.h"
#include "server/chat/ChatManager.h"
#include "server/zone/managers/stringid/StringIdManager.h"
#include "server/zone/managers/skill/SkillManager.h"
#include "server/zone/managers/object/ObjectManager.h"
#include "server/zone/managers/director/DirectorManager.h"

void FrsManagerImplementation::initialize() {
	loadLuaConfig();

	if (!frsEnabled)
		return;

	setupEnclaves();

	String serverName = "";
	if (zoneServer != nullptr)
		serverName = zoneServer->getGalaxyName();

	if (decayEnabled && serverName != "SWG Infinity TC") {  // Don't run FRS Maintenance on TC

		rebuildCouncilLists();

		uint64 miliDiff = maintenanceInterval + 1;  //Will run at server start if there is no value in QuestStatus

		//DirectorManager::instance()->setQuestStatus("FRSMaintenance", "");

		String lastMaintenanceString = DirectorManager::instance()->getQuestStatus("FRSMaintenance");
		//error("FRS:  lastMaintenanceString = " + lastMaintenanceString);

		if (lastMaintenanceString != "") {
			Time currentTime;
			uint64 currentTimeMili = currentTime.getMiliTime();
			miliDiff = currentTimeMili - Long::unsignedvalueOf(lastMaintenanceString);
		}
		
		uint64 remaining = maintenanceInterval > miliDiff ?  maintenanceInterval - miliDiff : 0;
		//error("FRS:  miliDiff = " + String::valueOf(miliDiff));
		//error("FRS:  maintenanceInterval = " + String::valueOf(maintenanceInterval));
		//error("FRS:  Remaining = " + String::valueOf(remaining));

		if(rankMaintenanceTask == nullptr) {
			rankMaintenanceTask = new RankMaintenanceTask(_this.getReferenceUnsafeStaticCast());
			if (remaining == 0) {
				//error("FRS:  Running maintenance task now.");
				rankMaintenanceTask->execute();
			}
			else {
				//error("FRS:  Scheduling maintenance task in " + String::valueOf(remaining) + " milliseconds.");
				rankMaintenanceTask->schedule(maintenanceInterval - miliDiff);
			}
		}
		else {
			if (remaining == 0) {
				//error("FRS:  Running maintenance task now.");
				rankMaintenanceTask->execute();
			}
			else {
				//error("FRS:  Rescheduling maintenance task in " + String::valueOf(maintenanceInterval - miliDiff) + " milliseconds.");
				rankMaintenanceTask->reschedule(maintenanceInterval - miliDiff);
			}
		}
	}
}

void FrsManagerImplementation::loadLuaConfig() {
	Lua* lua = new Lua();
	lua->init();

	if (!lua->runFile("scripts/managers/jedi/frs_manager.lua")) {
		info("Unable to load FrsManager data.",true);
		delete lua;
		return;
	}

	frsEnabled = lua->getGlobalInt("frsEnabled");
	decayEnabled = lua->getGlobalInt("decayEnabled");
	petitionInterval = lua->getGlobalInt("petitionInterval");
	votingInterval = lua->getGlobalInt("votingInterval");
	acceptanceInterval = lua->getGlobalInt("acceptanceInterval");
	maintenanceInterval = lua->getGlobalInt("maintenanceInterval");
	requestDemotionDuration = lua->getGlobalInt("requestDemotionDuration");
	voteChallengeDuration = lua->getGlobalInt("voteChallengeDuration");
	baseMaintCost = lua->getGlobalInt("baseMaintCost");
	requestDemotionCost = lua->getGlobalInt("requestDemotionCost");
	voteChallengeCost = lua->getGlobalInt("voteChallengeCost");
	maxPetitioners = lua->getGlobalInt("maxPetitioners");
	missedVotePenalty = lua->getGlobalInt("missedVotePenalty");

	uint32 enclaveID = lua->getGlobalInt("lightEnclaveID");

	lightEnclave = zoneServer->getObject(enclaveID).castTo<BuildingObject*>();

	enclaveID = lua->getGlobalInt("darkEnclaveID");

	darkEnclave = zoneServer->getObject(enclaveID).castTo<BuildingObject*>();

	LuaObject luaObject = lua->getGlobalObject("enclaveRoomRequirements");

	if (luaObject.isValidTable()) {
		for(int i = 1; i <= luaObject.getTableSize(); ++i) {
			LuaObject entry = luaObject.getObjectAt(i);

			uint32 cellID = entry.getIntAt(1);
			int rank = entry.getIntAt(2);

			roomRequirements.put(cellID, rank);

			entry.pop();
		}
	}

	luaObject.pop();

	luaObject = lua->getGlobalObject("lightRankingData");

	if (luaObject.isValidTable()) {
		for(int i = 1; i <= luaObject.getTableSize(); ++i) {
			LuaObject entry = luaObject.getObjectAt(i);

			int rank = entry.getIntAt(1);
			String skillName = entry.getStringAt(2);
			int reqExp = entry.getIntAt(3);
			int playerCap = entry.getIntAt(4);

			Reference<FrsRankingData*> data = new FrsRankingData(rank, skillName, reqExp, playerCap);

			lightRankingData.put(rank, data);

			entry.pop();
		}
	}

	luaObject.pop();

	luaObject = lua->getGlobalObject("darkRankingData");

	if (luaObject.isValidTable()) {
		for(int i = 1; i <= luaObject.getTableSize(); ++i) {
			LuaObject entry = luaObject.getObjectAt(i);

			int rank = entry.getIntAt(1);
			String skillName = entry.getStringAt(2);
			int reqExp = entry.getIntAt(3);
			int playerCap = entry.getIntAt(4);

			Reference<FrsRankingData*> data = new FrsRankingData(rank, skillName, reqExp, playerCap);

			darkRankingData.put(rank, data);

			entry.pop();
		}
	}

	luaObject.pop();

	luaObject = lua->getGlobalObject("frsExperienceValues");

	if (luaObject.isValidTable()) {
		for(int i = 1; i <= luaObject.getTableSize(); ++i) {
			LuaObject entry = luaObject.getObjectAt(i);
			uint64 keyHash = entry.getStringAt(1).hashCode();

			Vector<int> expValues;

			for (int j = 0; j <= 11; j++) {
				int value = entry.getIntAt(j + 2);
				expValues.add(value);
			}

			experienceValues.put(keyHash, expValues);

			entry.pop();
		}
	}

	luaObject.pop();

	delete lua;
	lua = nullptr;
}

void FrsManagerImplementation::setupEnclaves() {
	ManagedReference<BuildingObject*> enclaveBuilding = lightEnclave.get();

	if (enclaveBuilding != nullptr)
		setupEnclaveRooms(enclaveBuilding, "LightEnclaveRank");

	enclaveBuilding = darkEnclave.get();

	if (enclaveBuilding != nullptr)
		setupEnclaveRooms(enclaveBuilding, "DarkEnclaveRank");
}

void FrsManagerImplementation::setupEnclaveRooms(BuildingObject* enclaveBuilding, const String& groupName) {
	for (int j = 1; j <= enclaveBuilding->getTotalCellNumber(); ++j) {
		ManagedReference<CellObject*> cell = enclaveBuilding->getCell(j);

		if (cell != nullptr) {
			cell->setContainerComponent("EnclaveContainerComponent");

			int roomReq = getRoomRequirement(cell->getObjectID());

			if (roomReq == -1)
				continue;

			ContainerPermissions* permissions = cell->getContainerPermissions();

			permissions->setInheritPermissionsFromParent(false);
			permissions->clearDefaultAllowPermission(ContainerPermissions::WALKIN);
			permissions->setDefaultDenyPermission(ContainerPermissions::WALKIN);

			for (int i = 11; i >= roomReq; i--) {
				permissions->setAllowPermission(groupName + String::valueOf(i), ContainerPermissions::WALKIN);
			}
		}
	}
}

void FrsManagerImplementation::setPlayerRank(CreatureObject* player, int rank) {
	if (player == nullptr)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	FrsData* frsData = ghost->getFrsData();

	int councilType = frsData->getCouncilType();
	String groupName = "";

	if (councilType == COUNCIL_LIGHT)
		groupName = "LightEnclaveRank";
	else if (councilType == COUNCIL_DARK)
		groupName = "DarkEnclaveRank";
	else
		return;

	int curRank = frsData->getRank();

	if (curRank > 0)
		ghost->removePermissionGroup(groupName + String::valueOf(curRank), true);

	frsData->setRank(rank);

	ghost->addPermissionGroup(groupName + String::valueOf(rank), true);

	uint64 creoID = player->getObjectID();

	if (councilType == COUNCIL_LIGHT) {
		if (lightRankedMembers.contains(creoID)) {
			lightRankedMembers.drop(creoID);
		}
		if (rank > 0) {
			lightRankedMembers.put(creoID, rank);
		}
	} else if (councilType == COUNCIL_DARK) {
		if (darkRankedMembers.contains(creoID)) {
			darkRankedMembers.drop(creoID);
		}
		if (rank > 0) {
			darkRankedMembers.put(creoID, rank);
		}

	}

	updatePlayerSkills(player);
}

void FrsManagerImplementation::updatePlayerSkills(CreatureObject* player) {
	PlayerObject* ghost = player->getPlayerObject();

	if (player->getZoneServer() == nullptr)
		return;

	SkillManager* skillManager = player->getZoneServer()->getSkillManager();

	if (ghost == nullptr)
		return;

	FrsData* frsData = ghost->getFrsData();
	int playerRank = frsData->getRank();
	int councilType = frsData->getCouncilType();
	VectorMap<uint, Reference<FrsRankingData*> > rankingData;

	if (councilType == COUNCIL_LIGHT)
		rankingData = lightRankingData;
	else if (councilType == COUNCIL_DARK)
		rankingData = darkRankingData;
	else
		return;

	for (int i = 0; i <= 11; i++) {
		Reference<FrsRankingData*> rankData = rankingData.get(i);
		String rankSkill = rankData->getSkillName();
		int rank = rankData->getRank();

		if (playerRank >= rank) {
			if (!player->hasSkill(rankSkill)){
				info("Player qualifies for new skill adding skill: "  + rankSkill.toLowerCase(),true);
				//player->addSkill(rankSkill, true);
				SkillManager::instance()->awardSkill(rankSkill, player, true, true, true, true, false);
				//bool notifyClient, bool awardRequiredSkills, bool noXpRequired, bool ignoreRequirements, bool setRank)
			}
		} else {
			if (player->hasSkill(rankSkill))
				SkillManager::instance()->surrenderSkill(rankSkill, player, true, true, false);   // Don't setRank
				//player->removeSkill(rankSkill, true);
		}
	}

	//Award Guardian/Master at Rank 8 and 11
	if (playerRank >= 8 && !player->hasSkill("force_title_jedi_rank_04")){
		 SkillManager::instance()->awardSkill("force_title_jedi_rank_04", player, true, true, true, false);
	}

	if (playerRank >= 11 && !player->hasSkill("force_title_jedi_master")){
		SkillManager::instance()->awardSkill("force_title_jedi_master", player, true, true, true, false);
	}

}

void FrsManagerImplementation::promotePlayer(CreatureObject* player) {
	if (player == nullptr)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	FrsData* frsData = ghost->getFrsData();
	int rank = frsData->getRank();

	if (rank > 10)
		return;

	int newRank = rank + 1;
	setPlayerRank(player, newRank);

	error("FRS: Player: " + player->getFirstName() + " has enough xp to rank, promoting to rank: [" + String::valueOf(newRank) + "]");

	String stfRank = "@force_rank:rank" + String::valueOf(newRank);
	String rankString = StringIdManager::instance()->getStringId(stfRank.hashCode()).toString();

	StringIdChatParameter param("@force_rank:rank_gained"); // You have achieved the Enclave rank of %TO.
	param.setTO(rankString);
	player->sendSystemMessage(param);
}

void FrsManagerImplementation::demotePlayer(CreatureObject* player) {
	if (player == nullptr)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	FrsData* frsData = ghost->getFrsData();
	int rank = frsData->getRank();

	if (rank == 0)
		return;

	int newRank = rank - 1;
	setPlayerRank(player, newRank);

	error("FRS: Player: " + player->getFirstName() + " does not have the proper skill to maintain rank, demoted to rank: [" + String::valueOf(newRank) + "]");

	String stfRank = "@force_rank:rank" + String::valueOf(newRank);
	String rankString = StringIdManager::instance()->getStringId(stfRank.hashCode()).toString();

	StringIdChatParameter param("@force_rank:rank_lost"); // You have been demoted to %TO.
	param.setTO(rankString);
	player->sendSystemMessage(param);
}

int FrsManagerImplementation::getRankForSkill(const String& stringName){

    VectorMap<uint, Reference<FrsRankingData*> > rankingData;
	rankingData = lightRankingData;

        for (int i = 0; i <= 11; i++) {
                Reference<FrsRankingData*> rankDataL = rankingData.get(i);
                String rankSkill = rankDataL->getSkillName();
                int rank = rankDataL->getRank();
				if (rankSkill.indexOf(stringName) != -1)
					return rank; //found it!

        }
	//Skill was not in lightside FRS, checking darkside

	rankingData = darkRankingData;
        for (int i = 0; i <= 11; i++) {
                Reference<FrsRankingData*> rankDataD = rankingData.get(i);
                String rankSkill = rankDataD->getSkillName();
                int rank = rankDataD->getRank();

                if (rankSkill.indexOf(stringName) != -1)
                        return rank; //found it!

        }

//We didnt find that skill as part of light or darkside FRS
return -1;

}

int FrsManagerImplementation::getXpForRank(int councilType, int rank){
PlayerManager* playerManager = zoneServer->getPlayerManager();

                Reference<FrsRankingData*> rankingData = nullptr;

                if (councilType == COUNCIL_LIGHT)
                        rankingData = lightRankingData.get(rank);
                else if (councilType == COUNCIL_DARK)
                        rankingData = darkRankingData.get(rank);

                if (rankingData == nullptr){
                        return 0;
                }

 return rankingData->getRequiredExperience();

}

void FrsManagerImplementation::adjustFrsExperience(CreatureObject* player, int amount) {
	if (player == nullptr || amount == 0)
		return;

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	Locker locker(player);
      PlayerManager* playerManager = zoneServer->getPlayerManager();

  	FrsData* frsData = ghost->getFrsData();
  	int rank = frsData->getRank();
  	int councilType = frsData->getCouncilType();
  	int curExperience = ghost->getExperience("force_rank_xp");

	/*  info("Rank = " + String::valueOf(rank), true);
	info("Council type = " + String::valueOf(councilType), true);
	info("Current FRS Experience = " + String::valueOf(curExperience), true); 
	info("Amount = " + String::valueOf(amount), true); */

	if (amount > 0) {
		error("FRS: Awarding XP to [" + player->getFirstName()  + "]");
    		playerManager->awardExperience(player, "force_rank_xp", amount);
		curExperience += amount;
		//StringIdChatParameter param("@force_rank:experience_granted"); // You have gained %DI Force Rank experience.
		//param.setDI(amount);

		Reference<FrsRankingData*> rankingData = nullptr;

		if (rank < 11) {
			if (councilType == COUNCIL_LIGHT)
				rankingData = lightRankingData.get(rank+1);
			else if (councilType == COUNCIL_DARK)
				rankingData = darkRankingData.get(rank+1);
			if (rankingData == nullptr){
				info("FRS: NO ranking data found, aborting",true);
				return;
			}

			int reqXp = rankingData->getRequiredExperience();
			if (reqXp <= curExperience){  //They have gained enough experience to autopromote
				promotePlayer(player);
		}
		//error("FRS: XP added for player " + player->getFirstName() + ".  Player now recognized as rank [" + String::valueOf(frsData->getRank()) + "]");
		//player->sendSystemMessage(param);
	}

	} else {
		// Ensure we dont go into the negatives
		if ((amount * -1) > curExperience)
			amount = (curExperience) * -1;

		//error("FRS: Removing XP for player " + player->getFirstName() + ".  Player recognized as rank [" + String::valueOf(rank) + "]");

		error("FRS: Removing " + String::valueOf(amount * -1)  + " FRS XP from [" + player->getFirstName() + "]");
		playerManager->awardExperience(player, "force_rank_xp", amount);

		StringIdChatParameter param("@force_rank:experience_lost"); // You have lost %DI Force Rank experience.
		param.setDI(amount * -1);
		player->sendSystemMessage(param);

		curExperience += amount;

		Reference<FrsRankingData*> rankingData = nullptr;

		if (councilType == COUNCIL_LIGHT) {
			for( ; ; ) {
				rank = frsData->getRank();
				rankingData = lightRankingData.get(rank);
				int reqXp = rankingData->getRequiredExperience();
				if (reqXp > curExperience)
					demotePlayer(player);
				else
					break;
			}
		}

		else if (councilType == COUNCIL_DARK) 
			for( ; ; ) {
				rank = frsData->getRank();
				rankingData = darkRankingData.get(rank);
				int reqXp = rankingData->getRequiredExperience();
				if (reqXp > curExperience)
					demotePlayer(player);
				else
					break;
			}

		if (rankingData == nullptr){
			info("FRS: NO ranking data found, aborting",true);
			return;
		}

		//error("FRS: XP removed for player " + player->getFirstName() + ".  Player now recognized as rank [" + String::valueOf(rank) + "]");

	}
}

Vector<uint64> FrsManagerImplementation::getFullPlayerList() {
	Vector<uint64> playerList;

	for (int i = 0; i < lightRankedMembers.size(); ++i) {
		uint64 playerID = lightRankedMembers.elementAt(i).getKey();

		playerList.add(playerID);
	}

	for (int i = 0; i < darkRankedMembers.size(); ++i) {
		uint64 playerID = darkRankedMembers.elementAt(i).getKey();

		playerList.add(playerID);
	}

	return playerList;
}

void FrsManagerImplementation::deductMaintenanceXp(CreatureObject* player) {
	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	FrsData* frsData = ghost->getFrsData();
	int rank = frsData->getRank();

	if (rank == 0)
		return;
		
	Time currentTime;

	String lastLoginTimestring = ghost->getScreenPlayData("frs", "login_timestamp");
	uint64 lastLoginTimeMili = 0;
	if (lastLoginTimestring != "") {
		lastLoginTimeMili = Long::unsignedvalueOf(lastLoginTimestring);
	}
	uint64 loginDelta = currentTime.getMiliTime() - lastLoginTimeMili;

	String lastBountyDeathString = ghost->getScreenPlayData("frs", "bh_death_timestamp");
	uint64 lastBountyDeathMili = 0;
	if (lastBountyDeathString != "") {
		lastBountyDeathMili = Long::unsignedvalueOf(lastBountyDeathString);
	}
	uint64 bountyDelta = currentTime.getMiliTime() - lastBountyDeathMili;

	float visibility = ghost->getVisibility();

	bool penalty = false;

	if (!ghost->isOnline() && loginDelta > maintenanceInterval)  //Extra penalty if you haven't logged in during the past maintenance cycle
		penalty = true;

	if (!penalty && visibility < 1500 && bountyDelta > maintenanceInterval)   //Extra penalty if visibility under 1500 (terminal threshold) and no BH death during maintenance interval
		penalty = true;

	/* error("FRSManager::deductMaintenanceXP:  Player = " + player->getFirstName() + ", maintenanceInterval = " + String::valueOf(maintenanceInterval) +
										 ", loginDelta = " + String::valueOf(loginDelta) + ", bountyDelta = " + String::valueOf(bountyDelta) + ", visibility = " + String::valueOf(visibility) +
										 ", penalty = " + String::valueOf(penalty));
	*/

	int maintXp = penalty ? rank * baseMaintCost * 5  : rank * baseMaintCost;

	ChatManager* chatManager = zoneServer->getChatManager();

	StringIdChatParameter mailBody("@force_rank:xp_maintenance_body"); // You have lost %DI Force Rank experience. All members of Rank 1 or higher must pay experience each week to remain in their current positions. (Note: This loss may not take effect until your next login.)
	mailBody.setDI(maintXp);

	chatManager->sendMail("Enclave Records", "@force_rank:xp_maintenance_sub", mailBody, player->getFirstName(), nullptr);

	addExperienceDebt(player, maintXp);
}

void FrsManagerImplementation::addExperienceDebt(CreatureObject* player, int amount) {

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	String storedDebt = ghost->getScreenPlayData("FRS", "frsXPDebt");
	int xpDebt = Integer::valueOf(storedDebt);
	xpDebt += amount;
	ghost->setScreenPlayData("FRS", "frsXPDebt", String::valueOf(xpDebt));

}

void FrsManagerImplementation::deductDebtExperience(CreatureObject* player) {

	PlayerObject* ghost = player->getPlayerObject();

	if (ghost == nullptr)
		return;

	String storedDebt = ghost->getScreenPlayData("FRS", "frsXPDebt");

	int xpDebt = Integer::valueOf(storedDebt);

	if (xpDebt <= 0)
		return;

	adjustFrsExperience(player, xpDebt * -1);				// Remove the XP
	ghost->setScreenPlayData("FRS", "frsXPDebt", "0");   	// Zero out the debt

}

bool FrsManagerImplementation::isValidFrsBattle(CreatureObject* attacker, CreatureObject* victim) {
	PlayerObject* attackerGhost = attacker->getPlayerObject();
	PlayerObject* victimGhost = victim->getPlayerObject();

	// No credit if they were killed by the attacker recently
	if (attackerGhost == nullptr || victimGhost == nullptr)
		return false;

	FrsData* attackerData = attackerGhost->getFrsData();
	int attackerRank = attackerData->getRank();
	int attackerCouncil = attackerData->getCouncilType();

	FrsData* victimData = victimGhost->getFrsData();
	int victimRank = victimData->getRank();
	int victimCouncil = victimData->getCouncilType();

	// Neither player is in the FRS
	if (victimCouncil == 0 && attackerCouncil == 0)
		return false;

	// No credit if they are in the same council
	if ((attackerCouncil == COUNCIL_LIGHT && victimCouncil == COUNCIL_LIGHT) || (attackerCouncil == COUNCIL_DARK && victimCouncil == COUNCIL_DARK))
		return false;

	return true;
}

int FrsManagerImplementation::calculatePvpExperienceChange(CreatureObject* attacker, CreatureObject* victim, float contribution, bool isVictim) {
	PlayerObject* attackerGhost = attacker->getPlayerObject();
	PlayerObject* victimGhost = victim->getPlayerObject();

	error("Entered FRS XP calculations for attacker: " + attacker->getFirstName() + " Defender: " +  victim->getFirstName() + "Contribution value is:" + String::valueOf(contribution));

	if (attackerGhost == nullptr || victimGhost == nullptr)
		return 0;

	int targetRating = 0;
	int opponentRating = 0;

	PlayerObject* playerGhost = nullptr;
	PlayerObject* opponentGhost = nullptr;

	if (isVictim) {
		targetRating = victimGhost->getPvpRating();
		opponentRating = attackerGhost->getPvpRating();

		playerGhost = victimGhost;
		opponentGhost = attackerGhost;
	} else {
		targetRating = attackerGhost->getPvpRating();
		opponentRating = victimGhost->getPvpRating();

		playerGhost = attackerGhost;
		opponentGhost = victimGhost;
	}

	int ratingDiff = abs(targetRating - opponentRating);

	if (ratingDiff > 2000)
		ratingDiff = 500;

	//float xpAdjustment = ((float)ratingDiff / 2000.f) * 0.5f;
	int xpChange = getBaseExperienceGain(playerGhost, opponentGhost, !isVictim);

	info("ratingDiff calulated to:" + String::valueOf(ratingDiff) + " XpChange Calulated to:" + String::valueOf(xpChange));

	if (xpChange != 0) {
		xpChange = (int)((float)xpChange / contribution);

		/* Adjust xp value depending on pvp rating
		 A lower rated victim will lose less experience, a higher rated victim will lose more experience
		 A lower rated victor will gain more experience, a higher rated victor will gain less experience
		if ((targetRating < opponentRating && isVictim) || (targetRating > opponentRating && !isVictim)) {
			xpChange -= (int)((float)xpChange * xpAdjustment);
		} else {
			xpChange += (int)((float)xpChange * xpAdjustment);
		}*/
	}

	return xpChange;
}

int FrsManagerImplementation::getBaseExperienceGain(PlayerObject* playerGhost, PlayerObject* opponentGhost, bool playerWon) {
	ManagedReference<CreatureObject*> opponent = opponentGhost->getParentRecursively(SceneObjectType::PLAYERCREATURE).castTo<CreatureObject*>();
	ManagedReference<CreatureObject*> creo  = playerGhost->getParentRecursively(SceneObjectType::PLAYERCREATURE).castTo<CreatureObject*>();

	if (opponent == nullptr)
		return 0;

	FrsData* playerData = playerGhost->getFrsData();
	int playerRank = playerData->getRank();
	int playerCouncil = playerData->getCouncilType();
	FrsData* opponentData = opponentGhost->getFrsData();
	int opponentRank = opponentData->getRank();

	error("FRS: PlayerCouncil = [" +  String::valueOf(playerCouncil) + "] PlayerRank[" + String::valueOf(playerRank) +"]   Opponent Rank[" + String::valueOf(opponentRank) + "]");

	// Make sure player is part of a council before we grab any value to award
	if (!creo->hasSkill("force_title_jedi_rank_03")){
		return 0;
	}
	String key = "";

	if (opponent->hasSkill("combat_bountyhunter_investigation_03") || opponent->hasSkill("mandalorian_master")) { // Opponent is able to hunt jedis
		key = "bh_";
	} else if (opponentRank >= 0 && opponent->hasSkill("force_title_jedi_rank_03")) { // Opponent is at least a knight
		key = "rank" + String::valueOf(opponentRank) + "_";
	} else if (opponent->hasSkill("force_title_jedi_rank_02")) { // Opponent is padawan
		key = "padawan_";
	} else { // Opponent is non jedi
		key = "nonjedi_";
	}

	if (playerWon) {
		key = key + "win";
	} else {
		key = key + "lose";
	}
	info("FRS XP Key = " + key,true);
	uint64 keyHash = key.hashCode();

	if (!experienceValues.contains(keyHash))
		return 0;

	Vector<int> expValues = experienceValues.get(keyHash);

	int returnValue = expValues.get(playerRank);

	if (!playerWon)
		returnValue *= -1;

	return returnValue;
}

void FrsManagerImplementation::rebuildCouncilLists() {

	error("FRSManager:  Rebuilding Jedi Council Lists");

	CharacterNameMap* nameMap = new CharacterNameMap();

	try {
		String query = "SELECT * FROM characters where character_oid > 16777216 and galaxy_id = " + String::valueOf(zoneServer->getGalaxyID()) + " order by character_oid asc";

		Reference<ResultSet*> res = ServerDatabase::instance()->executeQuery(query);

		while (res->next()) {
			uint64 oid = res->getUnsignedLong(0);
			String firstName = res->getString(3);

			if (!nameMap->put(firstName.toLowerCase(), oid)) {
				error("error colliding name:" + firstName.toLowerCase());
			}
		}

	} catch (Exception& e) {
		error(e.getMessage());
	}

	StringBuffer msg;
	msg << "FRSManager:  loaded " << nameMap->size() << " character names in memory";
	error(msg.toString());

	error("FRSManager:  Building FRS Jedi list");

	PlayerManager* playerManager = zoneServer->getPlayerManager();
	Reference<ObjectManager*> objectManager = zoneServer->getObjectManager();

	HashTable<String, uint64> names = nameMap->getNames();
	HashTableIterator<String, uint64> iter = names.iterator();

	VectorMap<UnicodeString, int> jediPlayers;
	uint32 a = STRING_HASHCODE("SceneObject.slottedObjects");
	uint32 b = STRING_HASHCODE("SceneObject.customName");
	uint32 c = STRING_HASHCODE("PlayerObject.jediState");

	int j = 0;
	while (iter.hasNext()) {
		uint64 creoId = iter.next();
		VectorMap<String, uint64> slottedObjects;
		UnicodeString playerName;
		int state = -1;

		j++;
		if (j == ceil(nameMap->size()  * 0.75f))
			error("FRSManager:  FRS Jedi List 75% complete");
		else if (j == ceil(nameMap->size()  * 0.50f))
			error("FRSManager:  FRS Jedi List 50% complete");
		else if (j == ceil(nameMap->size()  * 0.25f))
			error("FRSManager:  FRS Jedi List 25% complete");

		objectManager->getPersistentObjectsSerializedVariable<VectorMap<String, uint64> >(a, &slottedObjects, creoId);
		objectManager->getPersistentObjectsSerializedVariable<UnicodeString>(b, &playerName, creoId);

		uint64 ghostId = slottedObjects.get("ghost");

		if (ghostId == 0) {
			continue;
		}

		objectManager->getPersistentObjectsSerializedVariable<int>(c, &state, ghostId);

		if (state > 2) {
			jediPlayers.put(playerName, state);
		}
	}

	error("FRSManager:  Completed Building FRS Jedi list with " + String::valueOf(jediPlayers.size()) + " players.   Starting build of light/dark council lists.");

	for (int i = 0; i < jediPlayers.size(); i++) {


		if (i == ceil(jediPlayers.size() * 0.75f))
			error("FRSManager:  Council lists 75% complete");
		else if (i == ceil(jediPlayers.size() * 0.50f))
			error("FRSManager:  Council lists 50% complete");
		else if (i == ceil(jediPlayers.size() * 0.25f))
			error("FRSManager:  Council lists 25% complete");

		int rank = 0;
		int state = 0;
		String lastOnTime = "";
		String playerName = jediPlayers.elementAt(i).getKey().toString();
		int idx = playerName.indexOf(' ');
		String firstName = (idx != -1) ? playerName.subString(0, idx) : playerName;

		ManagedReference<CreatureObject*> jediCreature = playerManager->getPlayer(firstName);
		ManagedReference<PlayerObject*> jediPlayer = nullptr;
		if (jediCreature != nullptr) {
			jediPlayer = jediCreature->getPlayerObject();
			if (jediPlayer != nullptr) {
				rank = jediPlayer->getFrsData()->getRank();
				//state = jediPlayer->getJediState();
				if (rank > 0) {
					setPlayerRank(jediCreature,rank);
					// error("Player: " + firstName + ", State = " + String::valueOf(state) + ", Rank = " + String::valueOf(rank));
				}
			}
			else
				error("FRSManager: playerObject is nullptr");
		}
		else
			error("FRSManager: creatureObject is nullptr");
			
	}

	error("FRSManager:  Light ranked council size  = " + String::valueOf(lightRankedMembers.size()));
	error("FRSManager:  Dark ranked council size   = " + String::valueOf(darkRankedMembers.size()));

	nameMap = nullptr;

	return;
}
