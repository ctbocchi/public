PlayerTriggers = { }

function PlayerTriggers:playerLoggedIn(pPlayer)
	if (pPlayer == nil) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	local playerID = CreatureObject(pPlayer):getObjectID()
	local pGhost2 = CreatureObject(pPlayer)
	if (pGhost == nil) then
		return nil
	end
	
	-- if a player fully logs out in the tutorial, they are stuck in space, this sends them to HG
	if (PlayerObject(pGhost):hasGodMode() or PlayerObject(pGhost):isPrivileged()) then
		-- this resets SUI target on screenplay SUI
		removeQuestStatus(SceneObject(pPlayer):getObjectID() .. "gm:sui:targetID")
		if util:isWickedDev() then
			createObserver(CHAT, "util", "locationLogging", pPlayer)
		end
	else
		local planet = SceneObject(pPlayer):getZoneName()
		if planet ~= nil then
			if planet == "tutorial" then
				local pBuilding = SceneObject(pPlayer):getParent()
				if pBuilding == nil then
					-- missing: hud fix
					CreatureObject(pPlayer):sendNewbieTutorialEnableHudElement("all", 1, 0)				
					-- teleport to shuttle in HG near new player term
					SceneObject(pPlayer):switchZone("naboo",-5027,8,2872,0)
					includeFile("../managers/player_creation_manager.lua")
					if pGhost2 ~= nil then
						local startProf = pGhost2:getScreenPlayState("tutorialprofession")
						if startProf ~= nil then
							CreatureObject(pPlayer):sendSystemMessage("your starter prof: " .. startProf)
							if startProf == 1 then
								-- combat_brawler_novice
								awardSkill(pPlayer, "combat_brawler_novice")
								self:giveItem(pPlayer, brawlerOneHander)
								self:giveItem(pPlayer, brawlerTwoHander)
								self:giveItem(pPlayer, brawlerPolearm)
								self:giveItem(pPlayer, brawlerVK)
							elseif startProf == 2 then
								-- combat_marksman_novice
								awardSkill(pPlayer, "combat_marksman_novice")
								self:giveItem(pPlayer, marksmanPistol)
								self:giveItem(pPlayer, marksmanRifle)
								self:giveItem(pPlayer, marksmanCarbine)
							elseif startProf == 4 then
								-- outdoors_scout_novice
								awardSkill(pPlayer, "outdoors_scout_novice")
							elseif startProf == 8 then
								-- science_medic_novice
								awardSkill(pPlayer, "science_medic_novice")
								self:giveItem(pPlayer, foodTool)
							elseif startProf == 16 then
								-- social_entertainer_novice
								awardSkill(pPlayer, "social_entertainer_novice")
								self:giveItem(pPlayer, slitherhorn)
							elseif startProf == 32 then
								-- crafting_artisan_novice
								awardSkill(pPlayer, "crafting_artisan_novice")
								self:giveItem(pPlayer, foodTool)
								self:giveItem(pPlayer, mineralTool)
								self:giveItem(pPlayer, chemicalTool)
							end
							-- backpack
							if backPack ~= nil then
								self:giveItem(pPlayer, backPack)
							end
							-- survival knife
							self:giveItem(pPlayer, survivalKnife)

							-- give everyone generic tool
							self:giveItem(pPlayer, genericTool)

							-- give bike
							self:giveItem(pPlayer, SwoopBike)

							-- give melon
							self:giveItem(pPlayer, marojMelon)

							-- give armor
							self:giveItem(pPlayer, paddedbelt)
							self:giveItem(pPlayer, paddedbicepl)
							self:giveItem(pPlayer, paddedbicepr)
							self:giveItem(pPlayer, paddedboots)
							self:giveItem(pPlayer, paddedbracerl)
							self:giveItem(pPlayer, paddedbracerr)
							self:giveItem(pPlayer, paddedchest)
							self:giveItem(pPlayer, paddedhelmet)
							self:giveItem(pPlayer, paddedgloves)
							self:giveItem(pPlayer, paddedleggings)
						else
							CreatureObject(pPlayer):sendSystemMessage("failed to store starter prof")
						end
					else
						printLuaError("pghost2 was null...hmmm")
					end
				end
			end
		end
	end
	-- big game hunter observer
	if CreatureObject(pPlayer):hasSkill("big_game_hunter_novice") then
		-- start the observer for kills
		big_game_hunter:startKillCounts(pPlayer)
	end
	-- generic method from util that will reset specific quest states
	util:loginCheck(pPlayer)
	-- take away varactyls if they did not do the quest
	if pPlayer ~= nil then
		local state = CreatureObject(pPlayer):hasScreenPlayState(64, "varactylquest")
		if state ~= nil then
			if not state and not PlayerObject(pGhost):hasGodMode() then
				self:checkVaractyls(pPlayer)
			end
		end
	end
	-- check player lots
	if PlayerObject(pGhost):getLotsRemaining() < 0 then
		-- put them in jail unless they are within the 24hour grace period
		if not util:validateCheck(pPlayer, 19) then
			util:l("Player has too many lots and was put in jail", pPlayer, 2)
			infinity_general:LotCountViolation(pPlayer)
		else
			util:l("increased lot count is allowed for player", pPlayer, 0)
		end
	end
	-- remove mandalorian boxes if they did not earn it
	if mq:isEnabled() then
		if CreatureObject(pPlayer):hasSkill("mandalorian_rank_10") then
			-- if this player removes the helmet they are on the BH terms
			util:l("Mandalorian visibility start", pPlayer, 1)
			mq:mandoVisibility(pPlayer)
		end
		if CreatureObject(pPlayer):hasSkill("mandalorian_rank_1") then
			if not CreatureObject(pPlayer):hasScreenPlayState(2, "mandalorian:rank1b") then
				CreatureObject(pPlayer):surrenderSkill("mandalorian_rank_1")
				printLuaLog("PlayerTriggers:  Removed mandalorian_rank_1 for " .. CreatureObject(pPlayer):getFirstName())
			end
		end
		if CreatureObject(pPlayer):hasSkill("mandalorian_novice") then
			if not CreatureObject(pPlayer):hasScreenPlayState(128, "mand_init:") then
				if not CreatureObject(pPlayer):hasScreenPlayState(1, "mand_init:disks") then
					CreatureObject(pPlayer):surrenderSkill("mandalorian_novice")
					printLuaLog("PlayerTriggers:  Removed mandalorian_novice for " .. CreatureObject(pPlayer):getFirstName())
				end
			end
		end
		-- BH attack routine
		if mq:bh(pPlayer) then
			if util:isWickedDev() then
				--util:cw("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@remove BH check 16", 1)
				--util:removeCheck(pPlayer, 16, 1)
			end
			if util:validateCheck(pPlayer, 16) then
				-- player has a timer already set
				util:l("Mandalorian logged in but has existing timer set", pPlayer, 1)
			else
				local nextAttack = mandalorianquest:mandoBhAttackTimer(pPlayer, true)
				util:setCheck(pPlayer, 16, nextAttack)
			end
			
		end
		-- Din exit quest fail check
		if util:hasQuestState(pPlayer, "mando:din:omera", 2) then
			if not util:validateCheck(pPlayer, 16) then
				util:removeQuestState(pPlayer, "mando:din:omera", 2)
			end
		end
		-- Temp fix for players caught in BH loop
		if util:hasQuestState(pPlayer, "mando:force:artifact", 1) then
			util:removeQuestState(pPlayer, "mando:force:artifact", 1)
			util:giveQuestReward(pPlayer, MANDALORIAN_ARTIFACT_TEMPLATE)
			util:cout(pPlayer, "You were caught in a bad Mandalorian bug, your quest state is fixed and your artifact has been returned","pink")
		end
		-- fix for players caught in a strange state with the mask
		if util:hasQuestState(pPlayer, "mando:force:artifact2", 1) then
			util:removeQuestState(pPlayer, "mando:force:artifact2", 1)
			util:giveQuestReward(pPlayer, MANDALORIAN_ARTIFACT_TEMPLATE)
			util:cout(pPlayer, "You were caught in a bad Mandalorian bug, your quest state is fixed and your artifact has been returned","pink")
		end
		-- mandalorian armor quest observer
		if util:hasQuestState(pPlayer, "mandalorian:armorerQ:start", 1) and not util:hasQuestState(pPlayer, "mandalorian:armorerQ", 1024) then
			mand_mn1:startKillCounts(pPlayer)
		end
	end
	-- One-time per player check for legacy FRS skills	
	local skillCheckCompleted = readScreenPlayData(pPlayer,"login_skill_check", "Completed")
	
	if (skillCheckCompleted ~= "true") then

		if PlayerObject(pGhost):hasAbility("cert_onehandlightsaber_gen4") and not CreatureObject(pPlayer):hasSkill("force_discipline_light_saber_master") then
			PlayerObject(pGhost):removeAbility("cert_onehandlightsaber_gen4")
			PlayerObject(pGhost):removeAbility("cert_polearmlightsaber_gen4")
			PlayerObject(pGhost):removeAbility("cert_twohandlightsaber_gen4")
		end

		if PlayerObject(pGhost):hasAbility("healAllSelf2") and not CreatureObject(pPlayer):hasSkill("force_discipline_healing_damage_04") then
			PlayerObject(pGhost):removeAbility("healAllSelf2")
		end

		if PlayerObject(pGhost):hasAbility("avoidIncapacitation") and not CreatureObject(pPlayer):hasSkill("force_discipline_defender_master") then
			PlayerObject(pGhost):removeAbility("avoidIncapacitation")
		end

		if PlayerObject(pGhost):hasAbility("regainConsciousness") and not CreatureObject(pPlayer):hasSkill("force_discipline_enhancements_master") then
			PlayerObject(pGhost):removeAbility("regainConsciousness")
		end

		local skillManager = LuaSkillManager()
		skillManager:awardForceFromSkills(pPlayer)

		writeScreenPlayData(pPlayer, "login_skill_check", "Completed", "true") 

	end

	-- Check for FRS Jedi that have dropped Jedi knight and other weird conditions
	local jediState = PlayerObject(pGhost):getJediState()
	local darkNovice = CreatureObject(pPlayer):hasSkill("force_rank_dark_novice")
	local lightNovice = CreatureObject(pPlayer):hasSkill("force_rank_light_novice")
	local jediKnight = CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03")
	local frsXP = PlayerObject(pGhost):getExperience("force_rank_xp")

	if (frsXP > 0 and (jediState <=2 or not jediKnight or not (darkNovice or lightNovice))) then
		CreatureObject(pPlayer):awardExperience("force_rank_xp", frsXP * -1, false)
		printLuaLog("PlayerTriggers:  Removed all FRS XP for player " .. CreatureObject(pPlayer):getFirstName())
	end

	if (not jediKnight and (darkNovice or lightNovice)) or 
		(jediKnight and not (darkNovice or lightNovice)) or 
		(jediState > 2 and not jediKnight) or 
		(jediState > 2 and not darkNovice and not lightNovice) or
		(jediState == 2 and (darkNovice or lightNovice or jediKnight)) then

		printLuaLog("PlayerTriggers:  Player " .. CreatureObject(pPlayer):getFirstName() .. ", Jedi checks (state/knight/dark/light): " .. jediState .. "/" .. tostring(jediKnight) .. "/" .. tostring(darkNovice) .. "/" .. tostring(lightNovice))

		-- Set FRS Rank to novice to remove all FRS rank boxes
		PlayerObject(pGhost):setFrsRank(0)

		-- Make sure Jedi Knight and Novice Boxes are surrendered
		if CreatureObject(pPlayer):hasSkill("force_rank_dark_novice") then
			self:surrenderFRS(pPlayer, "dark")
		end

		if CreatureObject(pPlayer):hasSkill("force_rank_light_novice") then
			self:surrenderFRS(pPlayer, "light")
		end

		if CreatureObject(pPlayer):hasSkill("force_title_jedi_rank_03") then
			CreatureObject(pPlayer):surrenderSkill("force_title_jedi_master")
			CreatureObject(pPlayer):surrenderSkill("force_title_jedi_rank_04")
			CreatureObject(pPlayer):surrenderSkill("force_title_jedi_rank_03")
		end

		-- Set Player to Padawan
		PlayerObject(pGhost):setFrsRank(-1)
		PlayerObject(pGhost):setFrsCouncil(0)
		PlayerObject(pGhost):setJediState(2)

		-- Recalculate force pool
		local skillManager = LuaSkillManager()
		skillManager:awardForceFromSkills(pPlayer)

		printLuaLog("PlayerTriggers:  Removed all FRS skills for player " .. CreatureObject(pPlayer):getFirstName())

	end

	-- Check for error condition of both light and dark side FRS skills
	if (darkNovice and lightNovice) then

		if (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL) then
			self:surrenderFRS(pPlayer, "light")
			printLuaLog("PlayerTriggers:  Dark FRS Jedi had Light Jedi Skills.   Light skills removed for " .. CreatureObject(pPlayer):getFirstName())
		end

		if (CreatureObject(pPlayer):getFaction() == FACTIONREBEL) then
			self:surrenderFRS(pPlayer, "dark")
			printLuaLog("PlayerTriggers:  Light FRS Jedi had Dark Jedi Skills.   Dark skills removed for " .. CreatureObject(pPlayer):getFirstName())
		end

		-- Recalculate force pool
		local skillManager = LuaSkillManager()
		skillManager:awardForceFromSkills(pPlayer)

	end


	--[[ Quarterly check for FRS reset, reserved for potential future use
	local FRSResetCompleted = readScreenPlayData(pPlayer,"FRSReset20200401", "Completed")

	if (FRSResetCompleted ~= "true") then

		-- Reset FRS xp to zero regardless of Jedi state / skills
		local xpAmount = PlayerObject(pGhost):getExperience("force_rank_xp")
		CreatureObject(pPlayer):awardExperience("force_rank_xp", xpAmount * -1, false)

		if ((CreatureObject(pPlayer):hasSkill("force_rank_light_novice")) or (CreatureObject(pPlayer):hasSkill("force_rank_dark_novice"))) then  

			local rankResult = PlayerObject(pGhost):setFrsRank(pGhost,0)

		end

		writeScreenPlayData(pPlayer, "FRSReset20200401", "Completed", "true") -- Save screenplay state for current quarter

	end
	--]]


	BestineElection:playerLoggedIn(pPlayer)

end

function PlayerTriggers:surrenderFRS(pPlayer, council)
	if (pPlayer == nil or (council ~= "light" and council ~= "dark")) then
		return
	end

	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .."_master")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_10")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_09")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_08")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_07")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_06")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_05")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_04")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_03")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_02")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_rank_01")
	CreatureObject(pPlayer):surrenderSkill("force_rank_" .. council .. "_novice")

end

function PlayerTriggers:checkVaractyls(pPlayer)
	-- remove any varactyls they have
	local playerID = SceneObject(pPlayer):getObjectID()
	local objects = {
		{ name = "Azure",	template = "object/intangible/pet/azure_belsavis_varactyl_hue.iff"},
		{ name = "Gilded",	template = "object/intangible/pet/gilded_belsavis_varactyl_hue.iff"},
		{ name = "Ruby",	template = "object/intangible/pet/ruby_belsavis_varactyl_hue.iff"},
	}
	for i=1,#objects do
		local run = 1
		local runaway = 1
		while run == 1 do
			local pInventory = SceneObject(pPlayer):getSlottedObject("datapad")
			if pInventory ~= nil then
				local pItem = getContainerObjectByTemplate(pInventory, objects[i].template, false)
				if pItem ~= nil then
					printLuaLog("PlayerTriggers:remove illegal Varactyl: " .. objects[i].name .. ", player ID: " .. playerID .. " name: " ..  CreatureObject(pPlayer):getFirstName())
					SceneObject(pItem):destroyObjectFromWorld()
					SceneObject(pItem):destroyObjectFromDatabase()
				else
					run = 0
				end
			end
			runaway = runaway + 1
			if runaway > 50 then
				run = 0
			end
		end
	end
end

-- give item
function PlayerTriggers:giveItem(pPlayer, itemTemplate)
	local playerID = SceneObject(pPlayer):getObjectID()
	local pInventory = SceneObject(pPlayer):getSlottedObject("inventory")
	local pCheck = getContainerObjectByTemplate(pInventory, itemTemplate, true)
	if (pCheck == nil) then
		local pItem = giveItem(pInventory, itemTemplate, -1)
		if (pItem ~= nil) then
			SceneObject(pItem):sendTo(pPlayer)
		end
	end
end
function PlayerTriggers:playerLoggedOut(pPlayer)
	if (pPlayer == nil) then
		return
	end
end