/*
 * AiAwarenessEvent.h
 *
 *  Created on: Nov 20, 2010
 *      Author: da
 */

#ifndef AIAWARENESSEVENT_H_
#define AIAWARENESSEVENT_H_

#include "server/zone/objects/creature/ai/AiAgent.h"
#include "server/zone/managers/creature/AiMap.h"

namespace server {
namespace zone {
namespace objects {
namespace creature {
namespace ai {
namespace events {

class AiAwarenessEvent : public Task {
	ManagedWeakReference<AiAgent*> creature;
	uint64 mtime;
	float avgSpeed;

public:
	AiAwarenessEvent(AiAgent* pl) : Task(1000) {
		creature = pl;
		mtime = 0;
		avgSpeed = 0.f;
		AiMap::instance()->activeAwarenessEvents.increment();
	}

	virtual ~AiAwarenessEvent() {
		AiMap::instance()->activeAwarenessEvents.decrement();
	}

	void run() {
		AiMap::instance()->scheduledAwarenessEvents.decrement();

		ManagedReference<AiAgent*> strongRef = creature.get();

		if (strongRef == nullptr || strongRef->isDead() || strongRef->isIncapacitated())
			return;

		Locker locker(strongRef);

		strongRef->doAwarenessCheck();
	}

	void schedule(uint64 delay = 0) {
		AiMap::instance()->scheduledAwarenessEvents.increment();

		mtime = delay;

		ManagedReference<AiAgent*> strongRef = creature.get();

		auto zone = strongRef->getZone();

		if (zone != nullptr) {
			setCustomTaskQueue(zone->getZoneName());
		}

		try {
			Task::schedule(delay);
		} catch (...) {
			AiMap::instance()->scheduledAwarenessEvents.decrement();
		}
	}

	bool cancel() {
		bool ret = false;

		if ((ret = Task::cancel())) {
			AiMap::instance()->scheduledAwarenessEvents.decrement();
		}

		return ret;
	}
};

}
}
}
}
}
}

using namespace server::zone::objects::creature::events;

#endif /* AIAWARENESSEVENT_H_ */
