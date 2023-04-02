local ObjectManager = require("managers.object.object_manager")

EncodedDiskMenuComponent = { }

function EncodedDiskMenuComponent:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	menuResponse:addRadialMenuItem(120, 3, "@treasure_map/treasure_map:decode") -- Decode
end

function EncodedDiskMenuComponent:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pPlayer == nil or pSceneObject == nil) then
		return 0
	end

	if (SceneObject(pSceneObject):isASubChildOf(pPlayer) == false) then
		return 0
	end

	if (selectedID == 120) then
		SceneObject(pSceneObject):destroyObjectFromWorld()
		SceneObject(pSceneObject):destroyObjectFromDatabase()

		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")

		if (pInventory == nil) then
			return 0
		end
		-- some maps are duped to make other more rare
		local mapList = {
			"object/tangible/treasure_map/treasure_map_pirate1.iff",
			"object/tangible/treasure_map/treasure_map_pirate1.iff",
			"object/tangible/treasure_map/treasure_map_pirate2.iff",
			"object/tangible/treasure_map/treasure_map_pirate2.iff",
			"object/tangible/treasure_map/treasure_map_pirate2.iff",
			"object/tangible/treasure_map/treasure_map_pirate3.iff",
			"object/tangible/treasure_map/treasure_map_pirate3.iff",
			"object/tangible/treasure_map/treasure_map_pirate3.iff",
			"object/tangible/treasure_map/treasure_map_pirate3.iff",
			"object/tangible/treasure_map/treasure_map_pirate4.iff",
			"object/tangible/treasure_map/treasure_map_pirate4.iff",
			"object/tangible/treasure_map/treasure_map_pirate4.iff",
			"object/tangible/treasure_map/treasure_map_pirate4.iff",
			"object/tangible/treasure_map/treasure_map_pirate5.iff",
			"object/tangible/treasure_map/treasure_map_pirate5.iff",
			"object/tangible/treasure_map/treasure_map_pirate5.iff",
			"object/tangible/treasure_map/treasure_map_pirate5.iff",
			"object/tangible/treasure_map/treasure_map_pirate6.iff",
			"object/tangible/treasure_map/treasure_map_pirate6.iff",
			"object/tangible/treasure_map/treasure_map_pirate6.iff",
			"object/tangible/treasure_map/treasure_map_pirate6.iff",
			"object/tangible/treasure_map/treasure_map_pirate7.iff",
			"object/tangible/treasure_map/treasure_map_pirate7.iff",
			"object/tangible/treasure_map/treasure_map_pirate7.iff",
			"object/tangible/treasure_map/treasure_map_pirate7.iff",
			"object/tangible/treasure_map/treasure_map_pirate8.iff",
			"object/tangible/treasure_map/treasure_map_pirate8.iff",
			"object/tangible/treasure_map/treasure_map_pirate8.iff",
			"object/tangible/treasure_map/treasure_map_pirate8.iff",
			"object/tangible/treasure_map/treasure_map_pirate9.iff",
			"object/tangible/treasure_map/treasure_map_pirate9.iff",
			"object/tangible/treasure_map/treasure_map_pirate9.iff",
			"object/tangible/treasure_map/treasure_map_pirate9.iff",
			"object/tangible/treasure_map/treasure_map_pirate10.iff",
			"object/tangible/treasure_map/treasure_map_pirate10.iff",
			"object/tangible/treasure_map/treasure_map_pirate11.iff",
			"object/tangible/treasure_map/treasure_map_pirate11.iff",
			"object/tangible/treasure_map/treasure_map_pirate12.iff",
			"object/tangible/treasure_map/treasure_map_pirate13.iff",
			"object/tangible/treasure_map/treasure_map_pirate14.iff",
			"object/tangible/treasure_map/treasure_map_pirate14.iff",
			"object/tangible/treasure_map/treasure_map_pirate15.iff",
			"object/tangible/treasure_map/treasure_map_pirate15.iff",
			"object/tangible/treasure_map/treasure_map_pirate16.iff",
			"object/tangible/treasure_map/treasure_map_pirate17.iff",
			"object/tangible/treasure_map/treasure_map_pirate17.iff",
			"object/tangible/treasure_map/treasure_map_pirate18.iff",
			"object/tangible/treasure_map/treasure_map_pirate18.iff",
			"object/tangible/treasure_map/treasure_map_pirate19.iff",
			"object/tangible/treasure_map/treasure_map_pirate19.iff",
			"object/tangible/treasure_map/treasure_map_bh.iff",
		}

		local randType = getRandomNumber(#mapList)

		local pItem = giveItem(pInventory, mapList[randType], -1)
		
		if (pItem ~= nil) then
			SceneObject(pItem):sendTo(pPlayer)
		end
		CreatureObject(pPlayer):sendSystemMessage("@treasure_map/treasure_map:sys_decode_success") -- You have broken the data encryption and can now read the disk!
	end

	return 0
end
