/*
 * LuaTangibleObject.cpp
 *
 *  Created on: 24/01/2012
 *      Author: xyborn
 */

#include "LuaTangibleObject.h"
#include "server/zone/objects/tangible/TangibleObject.h"
#include "templates/params/PaletteColorCustomizationVariable.h"
#include "templates/customization/AssetCustomizationManagerTemplate.h"
#include "templates/appearance/PaletteTemplate.h"
#include "server/zone/objects/player/FactionStatus.h"
#include "server/zone/objects/scene/SceneObjectType.h"
#include "server/zone/objects/tangible/fishing/FishObject.h"
#include "server/zone/objects/tangible/weapon/WeaponObject.h"
#include "server/zone/objects/tangible/wearables/ArmorObject.h"
#include "server/zone/objects/tangible/powerup/PowerupObject.h"
#include "server/zone/managers/loot/LootManager.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/objects/tangible/Container.h"

const char LuaTangibleObject::className[] = "LuaTangibleObject";

Luna<LuaTangibleObject>::RegType LuaTangibleObject::Register[] = {
		{ "_setObject", &LuaTangibleObject::_setObject },
		{ "_getObject", &LuaSceneObject::_getObject },
		{ "setOptionsBitmask", &LuaTangibleObject::setOptionsBitmask },
		{ "setPvpStatusBitmask", &LuaTangibleObject::setPvpStatusBitmask },
		{ "setPvpStatusBit", &LuaTangibleObject::setPvpStatusBit },
		{ "getPvpStatusBitmask", &LuaTangibleObject::getPvpStatusBitmask },
		{ "isChangingFactionStatus", &LuaTangibleObject::isChangingFactionStatus },
		{ "setFutureFactionStatus", &LuaTangibleObject::setFutureFactionStatus },
		{ "isOnLeave", &LuaTangibleObject::isOnLeave },
		{ "isOvert", &LuaTangibleObject::isOvert },
		{ "isCovert", &LuaTangibleObject::isCovert },
		{ "setCustomizationVariable", &LuaTangibleObject::setCustomizationVariable },
		{ "getPaletteColorCount", &LuaTangibleObject::getPaletteColorCount },
		{ "setConditionDamage", &LuaTangibleObject::setConditionDamage },
		{ "setMaxCondition", &LuaTangibleObject::setMaxCondition },
		{ "setFaction", &LuaTangibleObject::setFaction },
		{ "getFaction", &LuaTangibleObject::getFaction },
		{ "setFactionStatus", &LuaTangibleObject::setFactionStatus },
		{ "isImperial", &LuaTangibleObject::isImperial },
		{ "isRebel", &LuaTangibleObject::isRebel },
		{ "isNeutral", &LuaTangibleObject::isNeutral },
		{ "hasActiveArea", &LuaTangibleObject::hasActiveArea},
		{ "isInvisible", &LuaTangibleObject::isInvisible },
		{ "getLuaStringData", &LuaTangibleObject::getLuaStringData },
		{ "setLuaStringData", &LuaTangibleObject::setLuaStringData },
		{ "deleteLuaStringData", &LuaTangibleObject::deleteLuaStringData },
		{ "setOptionBit", &LuaTangibleObject::setOptionBit},
		{ "clearOptionBit", &LuaTangibleObject::clearOptionBit},
		{ "hasOptionBit", &LuaTangibleObject::hasOptionBit},
		{ "getCraftersName", &LuaTangibleObject::getCraftersName},
		{ "getJunkDealerNeeded", &LuaTangibleObject::getJunkDealerNeeded},
		{ "getJunkValue", &LuaTangibleObject::getJunkValue},
		{ "isBroken", &LuaTangibleObject::isBroken},
		{ "isDestroyed", &LuaTangibleObject::isDestroyed},
		{ "isSliced", &LuaTangibleObject::isSliced},
		{ "isNoTrade", &LuaTangibleObject::isNoTrade},
		{ "broadcastPvpStatusBitmask", &LuaTangibleObject::broadcastPvpStatusBitmask},
		{ "getFishLength", &LuaTangibleObject::getFishLength},
		{ "getUseCount", &LuaTangibleObject::getUseCount},
		{ "setUseCount", &LuaTangibleObject::setUseCount},
		{ "getMinDamage", &LuaTangibleObject::getMinDamage},
		{ "getMaxDamage", &LuaTangibleObject::getMaxDamage},
		{ "getAttackSpeed", &LuaTangibleObject::getAttackSpeed},
		{ "getConditionDamage", &LuaTangibleObject::getConditionDamage },
		{ "inflictDamage", &LuaTangibleObject::inflictDamage },
		{ "setDamageSlice", &LuaTangibleObject::setDamageSlice },
		{ "setSpeedSlice", &LuaTangibleObject::setSpeedSlice },
		{ "setEffectivenessSlice", &LuaTangibleObject::setEffectivenessSlice },
		{ "setEncumbranceSlice", &LuaTangibleObject::setEncumbranceSlice },
		{ "isSliceable", &LuaTangibleObject::isSliceable },
		{ "getSerialNumber", &LuaTangibleObject::getSerialNumber },
		{ 0, 0 }
};

LuaTangibleObject::LuaTangibleObject(lua_State *L) : LuaSceneObject(L) {
#ifdef DYNAMIC_CAST_LUAOBJECTS
	realObject = dynamic_cast<TangibleObject*>(_getRealSceneObject());

	assert(!_getRealSceneObject() || realObject != NULL);
#else
	realObject = static_cast<TangibleObject*>(lua_touserdata(L, 1));
#endif
}

LuaTangibleObject::~LuaTangibleObject(){
}

int LuaTangibleObject::_setObject(lua_State* L) {
	LuaSceneObject::_setObject(L);

#ifdef DYNAMIC_CAST_LUAOBJECTS
	auto obj = dynamic_cast<TangibleObject*>(_getRealSceneObject());

	if (realObject != obj)
		realObject = obj;

	assert(!_getRealSceneObject() || realObject != NULL);
#else
	auto obj = static_cast<TangibleObject*>(lua_touserdata(L, -1));

	if (realObject != obj)
		realObject = obj;
#endif

	return 0;
}

int LuaTangibleObject::setCustomizationVariable(lua_State* L) {
	String type = lua_tostring(L, -2);
	int value = lua_tonumber(L, -1);

	Locker locker(realObject);

	realObject->setCustomizationVariable(type, value, true);

	return 0;
}

int LuaTangibleObject::getPaletteColorCount(lua_State* L) {
	String variableName = lua_tostring(L, -1);

	String appearanceFilename = realObject->getObjectTemplate()->getAppearanceFilename();
	VectorMap<String, Reference<CustomizationVariable*> > variables;
	AssetCustomizationManagerTemplate::instance()->getCustomizationVariables(appearanceFilename.hashCode(), variables, false);

	int colors = 0;

	for (int i = 0; i< variables.size(); ++i) {
		String varkey = variables.elementAt(i).getKey();

		if (varkey.contains(variableName)) {
			CustomizationVariable* customizationVariable = variables.get(varkey).get();

			if (customizationVariable == NULL)
				continue;

			PaletteColorCustomizationVariable* palette = dynamic_cast<PaletteColorCustomizationVariable*>(customizationVariable);

			if (palette != NULL) {
				String paletteFileName = palette->getPaletteFileName();
				PaletteTemplate* paletteTemplate = TemplateManager::instance()->getPaletteTemplate(paletteFileName);

				if (paletteTemplate == NULL)
					continue;

				colors = paletteTemplate->getColorCount();
				break;
			}
		}
	}

	lua_pushinteger(L, colors);

	return 1;
}

int LuaTangibleObject::setOptionsBitmask(lua_State* L) {
	uint32 bitmask = lua_tointeger(L, -1);

	realObject->setOptionsBitmask(bitmask, true);

	return 0;
}

int LuaTangibleObject::setPvpStatusBitmask(lua_State* L) {
	uint32 bitmask = lua_tointeger(L, -1);

	realObject->setPvpStatusBitmask(bitmask, true);

	return 0;
}

int LuaTangibleObject::setPvpStatusBit(lua_State* L) {
	uint32 bit = lua_tointeger(L, -1);

	realObject->setPvpStatusBit(bit, true);

	return 0;
}

int LuaTangibleObject::getPvpStatusBitmask(lua_State* L) {
	uint32 bitmask = realObject->getPvpStatusBitmask();

	lua_pushinteger(L, bitmask);

	return 1;
}

int LuaTangibleObject::isChangingFactionStatus(lua_State* L) {
	lua_pushboolean(L, realObject->getFutureFactionStatus() >= 0);

	return 1;
}

int LuaTangibleObject::setFutureFactionStatus(lua_State* L) {
	float status = lua_tonumber(L, -1);

	realObject->setFutureFactionStatus(status);

	return 0;
}

int LuaTangibleObject::isOnLeave(lua_State* L) {
	lua_pushboolean(L, realObject->getFactionStatus() == FactionStatus::ONLEAVE);

	return 1;
}

int LuaTangibleObject::isOvert(lua_State* L) {
	lua_pushboolean(L, realObject->getFactionStatus() == FactionStatus::OVERT);

	return 1;
}

int LuaTangibleObject::isCovert(lua_State* L) {
	lua_pushboolean(L, realObject->getFactionStatus() == FactionStatus::COVERT);

	return 1;
}

int LuaTangibleObject::setConditionDamage(lua_State* L) {
	float damage = lua_tonumber(L, -1);

	Locker locker(realObject);

	realObject->setConditionDamage(damage, true);

	return 0;
}

int LuaTangibleObject::setMaxCondition(lua_State* L) {
	float damage = lua_tonumber(L, -1);

	realObject->setMaxCondition(damage, true);

	return 0;
}

int LuaTangibleObject::setFaction(lua_State* L){
	uint32 faction = lua_tointeger(L, -1);

	realObject->setFaction(faction);

	return 0;
}

int LuaTangibleObject::getFaction(lua_State* L){
	uint32 faction = realObject->getFaction();

	lua_pushinteger(L, faction);

	return 1;
}

int LuaTangibleObject::isImperial(lua_State* L){
	lua_pushboolean(L, realObject->isImperial());

	return 1;
}

int LuaTangibleObject::isRebel(lua_State* L){
	lua_pushboolean(L, realObject->isRebel());

	return 1;
}

int LuaTangibleObject::isNeutral(lua_State* L){
	lua_pushboolean(L, realObject->isNeutral());

	return 1;
}

int LuaTangibleObject::hasActiveArea(lua_State* L) {
	uint64 objectid = lua_tointeger(L, -1);

	bool res = realObject->hasActiveArea(objectid);

	lua_pushboolean(L, res);

	return 1;
}

int LuaTangibleObject::isInvisible(lua_State* L) {
	bool retVal = realObject->isInvisible();
	lua_pushboolean(L, retVal);

	return 1;
}

int LuaTangibleObject::setLuaStringData(lua_State *L) {
	Locker locker(realObject);

	String key = lua_tostring(L, -2);
	String data = lua_tostring(L, -1);

	realObject->setLuaStringData(key, data);
	return 0;
}

int LuaTangibleObject::deleteLuaStringData(lua_State* L) {
	Locker locker(realObject);

	String key = lua_tostring(L, -1);

	realObject->deleteLuaStringData(key);

	return 0;
}

int LuaTangibleObject::getLuaStringData(lua_State *L) {
	String key = lua_tostring(L, -1);
	String data = realObject->getLuaStringData(key);

	lua_pushstring(L, data.toCharArray());

	return 1;
}

int LuaTangibleObject::setOptionBit(lua_State* L) {
	uint32 bit = lua_tointeger(L, -1);

	Locker locker(realObject);

	realObject->setOptionBit(bit, true);

	return 0;
}

int LuaTangibleObject::clearOptionBit(lua_State* L) {
	uint32 bit = lua_tointeger(L, -1);

	Locker locker(realObject);

	realObject->clearOptionBit(bit, true);

	return 0;
}

int LuaTangibleObject::hasOptionBit(lua_State* L) {
	uint32 bit = lua_tointeger(L, -1);

	bool retVal = realObject->getOptionsBitmask() & bit;
	lua_pushboolean(L, retVal);

	return 1;
}

int LuaTangibleObject::getCraftersName(lua_State* L) {
	lua_pushstring(L, realObject->getCraftersName().toCharArray());

	return 1;
}

int LuaTangibleObject::setFactionStatus(lua_State* L) {
	int status = lua_tointeger(L, -1);

	realObject->setFactionStatus(status);

	return 0;
}

int LuaTangibleObject::getJunkDealerNeeded(lua_State* L){
	int dealer = realObject->getJunkDealerNeeded();

	lua_pushinteger(L, dealer);

	return 1;
}

int LuaTangibleObject::getJunkValue(lua_State* L){
	int value = realObject->getJunkValue();

	lua_pushinteger(L, value);

	return 1;
}

int LuaTangibleObject::isBroken(lua_State* L) {
	bool broken = realObject->isBroken();

	lua_pushboolean(L, broken);

	return 1;
}

int LuaTangibleObject::isDestroyed(lua_State* L) {
	bool destroyed = realObject->isDestroyed();

	lua_pushboolean(L, destroyed);

	return 1;
}

int LuaTangibleObject::isSliced(lua_State* L){
	bool sliced = realObject->isSliced();

	lua_pushboolean(L, sliced);

	return 1;
}

int LuaTangibleObject::isNoTrade(lua_State* L){
	bool noTrade = realObject->isNoTrade();

	lua_pushboolean(L, noTrade);

	return 1;
}

int LuaTangibleObject::broadcastPvpStatusBitmask(lua_State* L) {
	
	realObject->broadcastPvpStatusBitmask();

	return 0;
}

int LuaTangibleObject::getFishLength(lua_State* L) {

	float length = -1.0f;
	FishObject* fish = cast<FishObject*>(realObject);

	if (fish != nullptr) {
		length = fish->getLength();
	}

	lua_pushnumber(L, length);

	return 1;
}

int LuaTangibleObject::getUseCount(lua_State* L){
	int useCount = realObject->getUseCount();

	lua_pushinteger(L, useCount);

	return 1;
}

int LuaTangibleObject::setUseCount(lua_State* L){
	float useCount = lua_tonumber(L, -1);

	Locker locker(realObject);

	realObject->setUseCount(useCount, true);

	return 0;
}

int LuaTangibleObject::getMinDamage(lua_State* L) {

	int numberOfArguments = lua_gettop(L) - 1;
	float value = -1.0f;
	bool withPowerup = true;

	if (numberOfArguments == 1) {
		withPowerup = lua_toboolean(L, -1);
	}

	WeaponObject* weapon = cast<WeaponObject*>(realObject);
	if (weapon != nullptr) {
		value = weapon->getMinDamage(withPowerup);
	}
	
	lua_pushnumber(L, value);

	return 1;
}

int LuaTangibleObject::getMaxDamage(lua_State* L) {

	int numberOfArguments = lua_gettop(L) - 1;
	float value = -1.0f;
	bool withPowerup = true;

	if (numberOfArguments == 1) {
		withPowerup = lua_toboolean(L, -1);
	}

	WeaponObject* weapon = cast<WeaponObject*>(realObject);
	if (weapon != nullptr) {
		value = weapon->getMaxDamage(withPowerup);
	}
	
	lua_pushnumber(L, value);

	return 1;
}

int LuaTangibleObject::getAttackSpeed(lua_State* L) {

	int numberOfArguments = lua_gettop(L) - 1;
	float value = -1.0f;
	bool withPowerup = true;

	if (numberOfArguments == 1) {
		withPowerup = lua_toboolean(L, -1);
	}

	WeaponObject* weapon = cast<WeaponObject*>(realObject);
	if (weapon != nullptr) {
		value = weapon->getAttackSpeed(withPowerup);
	}
	
	lua_pushnumber(L, value);

	return 1;
}

int LuaTangibleObject::getConditionDamage(lua_State* L) {
	int value = -1;

	if (realObject != nullptr) {
		value = realObject->getConditionDamage();
	}

	lua_pushinteger(L, value);

	return 1;
}

int LuaTangibleObject::inflictDamage(lua_State* L) {
	//int inflictDamage(TangibleObject attacker, int damageType, int damage, boolean destroy, boolean notifyClient = true);
	int destroy = lua_tonumber(L, -1);
	int damage = lua_tonumber(L, -2);
	int damageType = lua_tonumber(L, -3);

	SceneObject* scene = (SceneObject*)lua_touserdata(L, -4);

	TangibleObject* attacker = cast<TangibleObject*>(scene);

	assert(attacker);

	Locker locker(realObject);

	Locker crossLocker(attacker, realObject);

	realObject->inflictDamage(attacker, damageType, damage, destroy);

	return 0;
}

int LuaTangibleObject::setDamageSlice(lua_State* L) {

	uint8 slice = lua_tointeger(L, -1);
	bool sliced = false;

	if (slice > 35 || slice < 20) {
		Logger::console.error("LuaTangibleObject::setDamageSlice - value out of range");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject == nullptr) {
		Logger::console.error("LuaTangibleObject::setDamageSlice - realObject is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject->isWeaponObject() && realObject->isSliceable() && !realObject->isSliced()) {

		WeaponObject* weapon = cast<WeaponObject*>(realObject);

		if (weapon != nullptr && !weapon->isJediWeapon()) {

			Locker locker(weapon);
			if (weapon->hasPowerup()) {

				ManagedReference<PowerupObject*> pup = weapon->removePowerup();
				if (pup != nullptr) {
					Locker plocker(pup);	//Crosslock required here?
					pup->destroyObjectFromWorld(true);
					pup->destroyObjectFromDatabase(true);
					plocker.release();
				}
			}

			weapon->setDamageSlice(slice/100.f);
			weapon->setSliced(true);
			locker.release();
			sliced = true;
		}
	}

	lua_pushboolean(L, sliced);
	return 1;
}

int LuaTangibleObject::setSpeedSlice(lua_State* L) {

	uint8 slice = lua_tointeger(L, -1);
	bool sliced = false;

	if (slice > 35 || slice < 20) {
		Logger::console.error("LuaTangibleObject::setSpeedSlice - value out of range");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject == nullptr) {
		Logger::console.error("LuaTangibleObject::setSpeedSlice - realObject is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject->isWeaponObject() && realObject->isSliceable() && !realObject->isSliced()) {

		WeaponObject* weapon = cast<WeaponObject*>(realObject);

		if (weapon != nullptr && !weapon->isJediWeapon()) {

			Locker locker(weapon);
			if (weapon->hasPowerup()) {

				ManagedReference<PowerupObject*> pup = weapon->removePowerup();
				if (pup != nullptr) {
					Locker plocker(pup);   //Crosslock required here?
					pup->destroyObjectFromWorld(true);
					pup->destroyObjectFromDatabase(true);
					plocker.release();
				}
			}
			weapon->setSpeedSlice(slice/100.f);
			weapon->setSliced(true);
			locker.release();
			sliced = true;
		}
	}

	lua_pushboolean(L, sliced);
	return 1;
}

int LuaTangibleObject::setEffectivenessSlice(lua_State* L) {

	uint8 slice = lua_tointeger(L, -1);
	bool sliced = false;

	if (slice > 35 || slice < 11) {
		Logger::console.error("LuaTangibleObject::setEffectivenessSlice - value out of range");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject == nullptr) {
		Logger::console.error("LuaTangibleObject::setEffectivenessSlice - realObject is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject->isArmorObject() && realObject->isSliceable() && !realObject->isSliced()) {

		ArmorObject* armor = cast<ArmorObject*>(realObject);

		if (armor != nullptr) {
			Locker locker(armor);	
			armor->setEffectivenessSlice(slice/100.f);
			armor->setSliced(true);
			locker.release();
			sliced = true;
		}
	}

	lua_pushboolean(L, sliced);
	return 1;
}

int LuaTangibleObject::setEncumbranceSlice(lua_State* L) {

	uint8 slice = lua_tointeger(L, -1);
	bool sliced = false;

	if (slice > 45 || slice < 20) {
		Logger::console.error("LuaTangibleObject::setEncumbranceSlice - value out of range");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject == nullptr) {
		Logger::console.error("LuaTangibleObject::setEncumbranceSlice - realObject is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject->isArmorObject() && realObject->isSliceable() && !realObject->isSliced()) {

		ArmorObject* armor = cast<ArmorObject*>(realObject);

		if (armor != nullptr) {

			Locker locker(armor);	
			armor->setEncumbranceSlice(slice/100.f);
			armor->setSliced(true);
			locker.release();
			sliced = true;
		}
	}

	lua_pushboolean(L, sliced);
	return 1;
}

int LuaTangibleObject::isSliceable(lua_State* L) {

	bool value = false;

	if (realObject != nullptr) {
		value = realObject->isSliceable();
	}

	lua_pushboolean(L, value);

	return 1;
}

int LuaTangibleObject::sliceContainer(lua_State* L) {


	int numberOfArguments = lua_gettop(L) - 1;
	bool sliced = false;

	if (numberOfArguments != 1) {
		Logger::console.error("LuaTangibleObject::sliceContainer - wrong number of arguments provided (1)");
		lua_pushboolean(L, sliced);
		return 1;
	}

	CreatureObject* player = (CreatureObject*) lua_touserdata(L, -1);

	if (player == nullptr) {
		Logger::console.error("LuaTangibleObject::sliceContainer - player is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject == nullptr) {
		Logger::console.error("LuaTangibleObject::sliceContainer - realObject is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	ManagedReference<SceneObject*> inventory = player->getSlottedObject("inventory");

	if (inventory == nullptr) {
		Logger::console.error("LuaTangibleObject::sliceContainer - inventory is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	LootManager* lootManager = player->getZoneServer()->getLootManager();

	if (lootManager == nullptr) {
		Logger::console.error("LuaTangibleObject::sliceContainer - lootManager is nullptr");
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (realObject->getGameObjectType() != SceneObjectType::PLAYERLOOTCRATE) {
		Logger::console.error("LuaTangibleObject::sliceContainer - realObject is not a locked container");
		lua_pushboolean(L, sliced);
		return 1;
	}

	Locker locker(player);						//Lock the player
	Locker clocker(realObject, player);  		//Crosslock the locked container to the player

	Locker inventoryLocker(inventory);			//Lock the player's inventory

	Reference<SceneObject*> containerSceno = player->getZoneServer()->createObject(STRING_HASHCODE("object/tangible/container/loot/loot_crate.iff"), 1);

	if (containerSceno == nullptr) {
		lua_pushboolean(L, sliced);
		return 1;
	}

	Locker slocker(containerSceno, player);		//Crosslock the unlocked container to the player

	Container* container = dynamic_cast<Container*>(containerSceno.get());

	if (container == nullptr) {
		containerSceno->destroyObjectFromDatabase(true);
		lua_pushboolean(L, sliced);
		return 1;
	}

	if (System::random(10) != 4)
		lootManager->createLoot(container, "looted_container");

	inventory->transferObject(container, -1);
	container->sendTo(player, true);

	if (inventory->hasObjectInContainer(realObject->getObjectID())) {
		realObject->destroyObjectFromWorld(true);
	}
	realObject->destroyObjectFromDatabase(true);

	sliced = true;

	lua_pushboolean(L, sliced);
	return 1;
}

int LuaTangibleObject::getSerialNumber(lua_State* L){
	String value = "";

	if (realObject != nullptr) {
		value = realObject->getSerialNumber();
		lua_pushstring(L, value.toCharArray());
	}
	else {
		lua_pushnil(L);
	}

	return 1;
}