#ifndef RANKMAINTENANCETASK_H_
#define RANKMAINTENANCETASK_H_

#include "server/zone/managers/frs/FrsManager.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/managers/director/DirectorManager.h"

namespace server {
namespace zone {
namespace managers {
namespace frs {

class RankMaintenanceTask: public Task {
	ManagedWeakReference<FrsManager*> frsManager;

public:
	RankMaintenanceTask(FrsManager* frs) {
		frsManager = frs;
	}

	void run() {
		ManagedReference<FrsManager*> strongRef = frsManager.get();

		if (strongRef == nullptr)
			return;

		//Logger::console.error("FRS:  Starting Rank Maintenance Task.");

		Locker locker(strongRef);

		strongRef->updateLastMaintenance();

		Time currentTime;
		uint64 currentTimeMili = currentTime.getMiliTime();
		//Logger::console.error("FRS Rank MaintenanceTask:  currentTimeMili = " + String::valueOf(currentTimeMili) + " " + currentTime.getFormattedTime());

		DirectorManager::instance()->setQuestStatus("FRSMaintenance", String::valueOf(currentTimeMili));

		Vector<uint64> playerList = strongRef->getFullPlayerList();

		locker.release();

		//Logger::console.error("RankMaintenanceTask:  Playerlist size = " + String::valueOf(playerList.size()));

		if (playerList.size() == 0) {
			reschedule(strongRef->getMaintenanceInterval());
			Logger::console.error("FRSManager-RankMaintenanceTask:No players found for Rank Maintenance Task.");
			return;
		}

		Logger::console.error("FRSManager-RankMaintenanceTask:  Running Rank Maintenance Task.");

		int playersPerTask = 10;
		int numTasks = ceil((float)playerList.size() / (float)playersPerTask);

		for (int i = 0; i < numTasks; i++) {
			// Logger::console.error("RankMaintenanceTask:  Building task list.");
			Vector<uint64> taskList;

			for (int j = 0; j < playersPerTask; j++) {
				int curIndex = i * playersPerTask + j;

				if (curIndex >= playerList.size())
					break;

				taskList.add(playerList.get(curIndex));
			}

			Core::getTaskManager()->scheduleTask([taskList, strongRef]{
				for (int i = 0; i < taskList.size(); i++) {
					ManagedReference<CreatureObject*> player = strongRef->getZoneServer()->getObject(taskList.get(i)).castTo<CreatureObject*>();
					if (player != nullptr) {
						//Logger::console.error("RankMaintenanceTask:  Running deduct maintenance task.");
						Locker lock(player);
						strongRef->deductMaintenanceXp(player);
					}
				}
			}, "frsMaintenanceTask", (i + 1) * 500);
		}

		reschedule(strongRef->getMaintenanceInterval());
	}
};

}
}
}
}

#endif /* RANKMAINTENANCETASK_H_ */
