/*
 * SelectCharacterCallback.h
 *
 *  Created on: Sep 5, 2009
 *      Author: theanswer
 */

#ifndef SELECTCHARACTERCALLBACK_H_
#define SELECTCHARACTERCALLBACK_H_

#include "server/zone/packets/MessageCallback.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/managers/reaction/ReactionManager.h"
#include "server/zone/packets/creature/CreatureObjectDeltaMessage6.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/chat/ChatManager.h"
#include "server/zone/objects/player/events/DisconnectClientEvent.h"

class SelectCharacterCallback : public MessageCallback {
	uint64 characterID;
public:
	SelectCharacterCallback(ZoneClientSession* client, ZoneProcessServer* server) :
		MessageCallback(client, server), characterID(0) {

		setCustomTaskQueue("slowQueue");
	}

	void parse(Message* message) {
		characterID = message->parseLong(6);
	}

	static void connectPlayer(SceneObject* obj, uint64_t characterID, CreatureObject* player, ZoneClientSession* client, ZoneServer* zoneServer) {

		bool verbose = player->getFirstName().toLowerCase() == "mrobvious";

		PlayerObject* ghost = player->getPlayerObject();

		if (ghost == nullptr) {
			Logger::console.error("SelectCharacterCallback - ghost is nullptr");
			return;
		}

		if (ghost->getAdminLevel() == 0 && (zoneServer->getConnectionCount() >= zoneServer->getServerCap())) {
			client->sendMessage(new ErrorMessage("Login Error", "Server cap reached, please try again later", 0));
			Logger::console.error("SelectCharacterCallback - Server cap reached");
			return;
		}

		if (zoneServer->isServerLocked() && (ghost->getAdminLevel() == 0)) {
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "Server is currently locked", 0);
			Logger::console.error("SelectCharacterCallback - Server is locked");
			client->sendMessage(errMsg);

			return;
		}

		player->setClient(client);

		if (verbose)
			Logger::console.error("SelectCharacterCallback - setClient");

		client->setPlayer(player);

		if (verbose)
			Logger::console.error("SelectCharacterCallback - setPlayer");

		String zoneName = ghost->getSavedTerrainName();
		Zone* zone = zoneServer->getZone(zoneName);

		if (zone == nullptr) {
			Logger::console.error("SelectCharacterCallback - zone is nullptr");
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "The planet where your character was stored is disabled!", 0x0);
			client->sendMessage(errMsg);

			return;
		}

		if (!zoneServer->getPlayerManager()->increaseOnlineCharCountIfPossible(client)) {
			Logger::console.error("SelectCharacterCallback - Player hit max online character count");
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "You reached the max online character count.", 0x0);
			client->sendMessage(errMsg);

			return;
		}

		ghost->setTeleporting(true);
		if (verbose)
			Logger::console.error("SelectCharacterCallback - setTeleporting");
		player->setMovementCounter(0);
		if (verbose)
			Logger::console.error("SelectCharacterCallback - setMovementCounter");
		ghost->setClientLastMovementStamp(0);
		if (verbose)
			Logger::console.error("SelectCharacterCallback - setLastMovementStamp");

		if (player->getZone() == nullptr) {
			ghost->setOnLoadScreen(true);
			if (verbose)
				Logger::console.error("SelectCharacterCallback - setOnLoadScreen");
		}

		uint64 savedParentID = ghost->getSavedParentID();
		ManagedReference<SceneObject*> playerParent = zoneServer->getObject(savedParentID, true);
		ManagedReference<SceneObject*> currentParent = player->getParent().get();

		if ((playerParent != nullptr && currentParent == nullptr) || (currentParent != nullptr && currentParent->isCellObject())) {
			playerParent = playerParent == nullptr ? currentParent : playerParent;

			ManagedReference<SceneObject*> root = playerParent->getRootParent();

			root = root == nullptr ? playerParent : root;

			if (verbose)
				Logger::console.error("SelectCharacterCallback - determined root");

			//ghost->updateLastValidatedPosition();

			if (root->getZone() == nullptr && root->isStructureObject()) {
				player->initializePosition(root->getPositionX(), root->getPositionZ(), root->getPositionY());

				zone->transferObject(player, -1, true);

				playerParent = nullptr;

				if (verbose)
					Logger::console.error("SelectCharacterCallback - playerParent is nullptr");
			} else {
				if (!(playerParent->isCellObject() && playerParent == root)) {
					playerParent->transferObject(player, -1, false);
					if (verbose)
						Logger::console.error("SelectCharacterCallback - transferred to parent");
				}

				if (player->getParent() == nullptr) {
					zone->transferObject(player, -1, false);
					if (verbose)
						Logger::console.error("SelectCharacterCallback - player parent is nullptr");
				} else if (root->getZone() == nullptr) {
					Locker clocker(root, player);
					zone->transferObject(root, -1, false);
					if (verbose)
						Logger::console.error("SelectCharacterCallback - transferred to root");
				}

				player->sendToOwner(true);
				if (verbose)
					Logger::console.error("SelectCharacterCallback - sendToOwner 1");
			}

		} else if (currentParent == nullptr) {
			player->removeAllSkillModsOfType(SkillModManager::STRUCTURE);
			zone->transferObject(player, -1, true);
			if (verbose)
				Logger::console.error("SelectCharacterCallback - currentParent is nullptr");
		} else {
			if (player->getZone() == nullptr) {
				ManagedReference<SceneObject*> objectToInsert = currentParent != nullptr ? player->getRootParent() : player;

				if (objectToInsert == nullptr)
					objectToInsert = player;

				Locker clocker(objectToInsert, player);
				zone->transferObject(objectToInsert, -1, false);
				if (verbose)
					Logger::console.error("SelectCharacterCallback - player->getZone is nullptr");
			}

			player->sendToOwner(true);
			if (verbose)
				Logger::console.error("SelectCharacterCallback - sendToOwner 2");
		}

		if (playerParent == nullptr)
			ghost->setSavedParentID(0);

		ghost->setOnline();
		if (verbose)
			Logger::console.error("SelectCharacterCallback - setOnline");

		ChatManager* chatManager = zoneServer->getChatManager();
		chatManager->addPlayer(player);
		chatManager->loadMail(player);

		ghost->notifyOnline();
		if (verbose)
			Logger::console.error("SelectCharacterCallback - notifyOnline");

		PlayerManager* playerManager = zoneServer->getPlayerManager();
		playerManager->sendLoginMessage(player);

		ReactionManager* reactionManager = zoneServer->getReactionManager();
		reactionManager->doReactionFineMailCheck(player);

		//player->info("sending login Message:" + zoneServer->getLoginMessage(), true);

		// Disable music notes if player had been playing music
		if (!player->isPlayingMusic() && !player->isDancing()) {
			player->setPerformanceCounter(0, false);
			player->setInstrumentID(0, false);

			CreatureObjectDeltaMessage6* dcreo6 = new CreatureObjectDeltaMessage6(player);
			dcreo6->updatePerformanceAnimation(player->getPerformanceAnimation());
			dcreo6->updatePerformanceCounter(0);
			dcreo6->updateInstrumentID(0);
			dcreo6->close();
			player->broadcastMessage(dcreo6, true);

			player->setListenToID(0);

			// Stop playing music/dancing animation
			if (player->getPosture() == CreaturePosture::SKILLANIMATING)
				player->setPosture(CreaturePosture::UPRIGHT);

		}

		SkillModManager::instance()->verifyWearableSkillMods(player);
		if (verbose)
			Logger::console.error("SelectCharacterCallback - verifyWearableSkillMods");
	}

	void run() {
		ZoneServer* zoneServer = server->getZoneServer();

		if (zoneServer->isServerLoading()) {
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "Server is currently loading", 0);
			client->sendMessage(errMsg);

			return;
		}

		if (zoneServer->isServerShuttingDown()) {
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "Server is shutting down", 0);
			client->sendMessage(errMsg);

			return;
		}

		if (!client->hasCharacter(characterID, zoneServer->getGalaxyID())) {
			ErrorMessage* errMsg = new ErrorMessage("Login Error", "You are unable to login with this character\n\nIf you feel this is an error please close your client, and try again.", 0x0);
			client->sendMessage(errMsg);

			//client->error("invalid character id " + String::valueOf(characterID) + " in account: " + String::valueOf(client->getAccountID()));
			return;
		}

		//Logger::console.info("selected char id: 0x" + String::hexvalueOf((int64)characterID), true);

		ManagedReference<SceneObject*> obj = zoneServer->getObject(characterID, true);

		bool verbose = true;

		if (obj != nullptr && obj->isPlayerCreature()) {
			CreatureObject* player = obj->asCreatureObject();

			bool verbose = false;
			
			if (player != nullptr) 
				verbose = player->getFirstName().toLowerCase() == "mrobvious";

			if (verbose)
				Logger::console.error("SelectCharacterCallback - obj is not nullptr and is player creature");

			Locker _locker(player);

			ManagedReference<ZoneClientSession*> oldClient = player->getClient();

			if (oldClient != nullptr && client != oldClient) {
				_locker.release();

				if (verbose)
					Logger::console.error("SelectCharacterCallback - oldClient != nullptr && client != oldClient");

				oldClient->disconnect();

				if (verbose)
					Logger::console.error("SelectCharacterCallback - oldClient->disconnect");

				Reference<DisconnectClientEvent*> task = new DisconnectClientEvent(player, oldClient, DisconnectClientEvent::DISCONNECT);
				player->executeOrderedTask(task);

				if (verbose)
					Logger::console.error("SelectCharacterCallback - executed DisconnectClientEvent task");

				static const String lambdaName = "ConnectPlayerLambda";

				auto characterID = this->characterID;
				auto client = this->client;

				player->executeOrderedTask([obj, characterID, player, client, zoneServer] () {
					Locker locker(obj);

					connectPlayer(obj, characterID, player, client, zoneServer);
				}, lambdaName);

				if (verbose)
					Logger::console.error("SelectCharacterCallback - executed connectPlayer lambda task");
				return;
			}

			connectPlayer(obj, characterID, player, client, zoneServer);

			if (verbose)
				Logger::console.error("SelectCharacterCallback - called connectPlayer function");
		} else {
			if (obj != nullptr) {
				client->error("could get from zone server character id " + String::valueOf(characterID) + " but is not a player creature");
				if (verbose)
					Logger::console.error("SelectCharacterCallback - not a player creature");
			}
			else {
				client->error("could not get from zone server character id " + String::valueOf(characterID));
				if (verbose)
					Logger::console.error("SelectCharacterCallback - obj is nullptr");
			}
		}
	}
};


#endif /* SELECTCHARACTERCALLBACK_H_ */
