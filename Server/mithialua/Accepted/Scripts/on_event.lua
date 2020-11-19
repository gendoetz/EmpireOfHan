onKill = function(block, player)

--if (player.gmLevel == 99) then
	--player:sendMinitext("Bonus: "..block.experience.." experience!")
	--player:giveXP(block.experience)
	--nCalcTNL(player)
	local range = 10
	for i = 1, #player.group do
		if (Player(player.group[i]).m == player.m and distance(player, Player(player.group[i])) <= range) then
			if(Player(player.group[i]).level < 99 and Player(player.group[i]).state ~= 1) then
				Player(player.group[i]):sendMinitext("Bonus: ")
				Player(player.group[i]):giveXP(block.experience)
			end
		end
	end


--end

--[[if (block.blType == BL_MOB) then
if (player.level <= 98) then
	local calc1 = (player.level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
	if (player.registry["fulltnl"] == 0) then
	player.registry["fulltnl"] = nextlevel
	end
		--if (player.exp >= 200) then
		--	if (player.level == 1) then
		--		onLevelincrease(player)
		--		player:sendMinitext("You reach level "..player.level..", your max exp is currently: "..player.exp)
		--	end
		--end
	
		if (player.exp >= nextlevel) then
				onLevelincrease(player)
				local calc1 = (player.level + 1)
				local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
				local tnlcalc = (nextlevel - player.exp)
				player.registry["fulltnl"] = tnlcalc
				player:sendStatus()
				player:sendMinitext("Congratulations!  You reach level "..player.level..", you need: "..tnlcalc.." experience to reach the next level.")
		end
	local calc1 = (player.level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
	local tnlcalc = (nextlevel - player.exp)
	player.helper = player.registry["fulltnl"]
	player.tnl = tnlcalc
	player:sendStatus()
	end
end--]]
	if (block.blType == BL_MOB) then

		--Code to check for Minor Quest Kills
			--if (player.registry["minorQuestTarget"] > 10) then --Looks like they are on a quest!
			--	if (player.registry["minorQuestTarget_MobID"] == block.mobID) then
			--		player:msg(4, "(Quest Update): You have slain the required quest target "..Mob(player.registry["minorQuestTarget"]).name..".", player.ID)
			--		player.registry["minorQuestTarget"] = 2
			--	end
			--end
		--onCalcTNL(player)

			for i = 1, #player.group do
				if(Player(player.group[i]).level < 99) then
					onCalcTNLgroup(player.group[i])
					--player:talk(0,"Test:"..player.group[i])
				end

				local questplayer = Player(player.group[i])

				if (questplayer.registry["minorQuestTarget"] > 10) then --Looks like they are on a quest!
					if (questplayer.registry["minorQuestTarget_MobID"] == block.mobID) then
						questplayer:msg(4, "(Quest Update): You have slain the required quest target "..Mob(questplayer.registry["minorQuestTarget"]).name..".", questplayer.ID)
						questplayer.registry["minorQuestTarget"] = 2
					end
				end
			end


		--[[local killTotal
		local total

		--This is where I edited to cal TNL display

		if (block.mobID == 111 or block.mobID == 112 or block.mobID == 113 or block.mobID == 114) then
		--r2_s_shepherd3 50 bandits repeatable
			total = 50
			for i = 1, #player.group do
				local killCount111 = Player(player.group[i]):killCount(111)
				local killCount112 = Player(player.group[i]):killCount(112)
				local killCount113 = Player(player.group[i]):killCount(113)
				local killCount114 = Player(player.group[i]):killCount(114)
				killTotal = killCount111 + killCount112 + killCount113 + killCount114
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).quest["banditQuest"] > 0 and Player(player.group[i]).quest["banditQuest"] < 100
				and (killTotal % 5) == 0) then
					onKillMsg(player, killTotal, total)
				end
			end
		elseif (block.mobID == 117 or block.mobID == 118 or block.mobID == 119 or block.mobID == 120 or block.mobID == 121) then
		--r2_s_chief zombie kills
			total = 1000
			for i = 1, #player.group do
				local killCount117 =  Player(player.group[i]):killCount(117)
				local killCount118 =  Player(player.group[i]):killCount(118)
				local killCount119 =  Player(player.group[i]):killCount(119)
				local killCount120 =  Player(player.group[i]):killCount(120)
				local killCount121 =  Player(player.group[i]):killCount(121)
				killTotal = killCount117 + killCount118 + killCount119 + killCount120 + killCount121
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).level >= 43
				and (killTotal % 5) == 0) then
					onKillMsg(Player(player.group[i]), killTotal, total)
				end
			end
		elseif (block.mobID == 66 or block.mobID == 67) then
		--r2_lj_hunter bear Quest
			for i = 1, #player.group do
				total = Player(player.group[i]).registry["bearQuestKillAmount"]
				local killCount66 = Player(player.group[i]):killCount(66)
				local killCount67 = Player(player.group[i]):killCount(67)
				killTotal = killCount66 + killCount67
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).quest["bearQuest"] > 0
				and (killTotal % 5) == 0) then
					onKillMsg(Player(player.group[i]), killTotal, total)
				end
			end
		elseif (block.mobID == 81 or block.mobID == 82 or block.mobID == 83 or block.mobID == 84) then
		--r2_lj_mercenary wolf Quest
			for i = 1, #player.group do
				total = Player(player.group[i]).registry["wolfQuestKillAmount"]
				local killCount81 = Player(player.group[i]):killCount(81)
				local killCount82 = Player(player.group[i]):killCount(82)
				local killCount83 = Player(player.group[i]):killCount(83)
				local killCount84 = Player(player.group[i]):killCount(84)
				killTotal = killCount81 + killCount82 + killCount83 + killCount84
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).quest["wolfQuest"] > 0
				and (killTotal % 5) == 0) then
					onKillMsg(Player(player.group[i]), killTotal, total)
				end
			end
		elseif (block.mobID == 2) then
		--tut_quest_girl squirrel quest
			for i = 1, #player.group do
				total = 10
				local killCount2 = Player(player.group[i]):killCount(2)
				killTotal = killCount2
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).quest["tut_quest_girl"] == 4) then
					onKillMsg(Player(player.group[i]), killTotal, total)
				end
			end
		elseif (block.mobID == 7) then
			for i = 1, #player.group do
				total = 6
				local killCount7 = Player(player.group[i]):killCount(7)
				killTotal = killCount7
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m
				and Player(player.group[i]).afk == false
				and Player(player.group[i]).quest["tut_quest_bird_worshipper"] == 3) then
					onKillMsg(Player(player.group[i]), killTotal, total)
				end
			end
		end
	elseif (block.blType == BL_PC) then]]--
	end
end

--[[onKillMsg = function(player, killTotal, total)
	if (player.registry["questCount"] == 0) then
		player:msg(4, player.f1Name..'(Spirit of Genesis)" '.."You have killed "..killTotal.."/"..total..". ((Toggle on F1))", player.ID)
	end
end]]--

onLevel = function(player)


end


onCalcTNLgroup = function(groupmember)
	if (Player(groupmember).class == 0) then
		if (Player(groupmember).level == 5) then
			Player(groupmember):sendMinitext("You cannot increase your level or gain experience without choosing a path.")
			Player(groupmember).exp = Player(groupmember).registry["freeze_player_exp"]

				local calc1 = (Player(groupmember).level + 1)
				local nextlevel = math.floor(((calc1 * calc1 * calc1) * 10 + 40))
				local tnlcalc = (nextlevel - Player(groupmember).exp)
				--Player(groupmember).registry["fulltnl"] = nextlevel
				--Player(groupmember).helper = Player(groupmember).registry["fulltnl"]
				Player(groupmember).helper = Player(groupmember).registry["fulltnl"]
				--Player(groupmember).tnl = tnlcalc
				Player(groupmember).tnl = 0
				Player(groupmember):sendStatus()
				--Player(groupmember):msg(8, "You have reached level 5, you must now choose a path to continue.", Player(groupmember).ID)
			return
		end
	end
	if (Player(groupmember).level <= 98) then
	local calc1 = (Player(groupmember).level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
			if (Player(groupmember).registry["fulltnl"] == 0) then
				Player(groupmember).registry["fulltnl"] = nextlevel
			end
		--if (Player(groupmember).exp >= 200) then
		--	if (Player(groupmember).level == 1) then
		--		onLevelincrease(Player(groupmember))
		--		Player(groupmember):sendMinitext("You reach level "..Player(groupmember).level..", your max exp is currently: "..Player(groupmember).exp)
		--	end
		--end
	
		if (Player(groupmember).exp >= nextlevel) then
				repeat
				onLevelincrease(Player(groupmember))
				local calc1 = (Player(groupmember).level + 1)
				local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
				local tnlcalc = (nextlevel - Player(groupmember).exp)
				local calc2 = (Player(groupmember).level)
				local prevlevel = math.floor(((calc2 * calc2 * calc2 * calc2) * 10 + 40))
				local fullcalc = (nextlevel - prevlevel)
				Player(groupmember).registry["fulltnl"] = fullcalc
				Player(groupmember):sendStatus()
				if (Player(groupmember).level ~= 99) then
					Player(groupmember):sendMinitext("Congratulations!  You reach level "..Player(groupmember).level..", you need: "..tnlcalc.." experience to reach the next level.")
				end
				Player(groupmember).tnl = tnlcalc
				until (Player(groupmember).exp <= nextlevel or Player(groupmember).level == 5 or Player(groupmember).level == 99)
		end
	local calc1 = (Player(groupmember).level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
	local tnlcalc = (nextlevel - Player(groupmember).exp)
	Player(groupmember).tnl = tnlcalc
	Player(groupmember).helper = Player(groupmember).registry["fulltnl"]
	--Player(groupmember):sendMinitext("Look"..Player(groupmember).registry["fulltnl"].." and"..Player(groupmember).exp.."")
	--Player(groupmember):calcStat()
	if (Player(groupmember).level == 5 and Player(groupmember).class == 0) then
		Player(groupmember).tnl = 0
		Player(groupmember).helper = 0
	end
	if (Player(groupmember).level == 99) then
		Player(groupmember).tnl = 0
		Player(groupmember).helper = 0
	end
	Player(groupmember):sendStatus()
	end
end

onCalcTNL = function(player)
	if (player.class == 0) then
		if (player.level == 5) then
			player:sendMinitext("You cannot increase your level or gain experience without choosing a path.")
			player.exp = player.registry["freeze_player_exp"]

				local calc1 = (player.level + 1)
				local nextlevel = math.floor(((calc1 * calc1 * calc1) * 10 + 40))
				local tnlcalc = (nextlevel - player.exp)
				--player.registry["fulltnl"] = nextlevel
				--player.helper = player.registry["fulltnl"]
				player.helper = player.registry["fulltnl"]
				--player.tnl = tnlcalc
				player.tnl = 0
				player:sendStatus()
				--player:msg(8, "You have reached level 5, you must now choose a path to continue.", player.ID)
			return
		end
	end
	if (player.level <= 98) then
	local calc1 = (player.level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
			if (player.registry["fulltnl"] == 0) then
				player.registry["fulltnl"] = nextlevel
			end
		--if (player.exp >= 200) then
		--	if (player.level == 1) then
		--		onLevelincrease(player)
		--		player:sendMinitext("You reach level "..player.level..", your max exp is currently: "..player.exp)
		--	end
		--end
	
		if (player.exp >= nextlevel) then
				repeat
				onLevelincrease(player)
				local calc1 = (player.level + 1)
				local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
				local tnlcalc = (nextlevel - player.exp)
				local calc2 = (player.level)
				local prevlevel = math.floor(((calc2 * calc2 * calc2 * calc2) * 10 + 40))
				local fullcalc = (nextlevel - prevlevel)
				player.registry["fulltnl"] = fullcalc
				player:sendStatus()
				if (player.level ~= 99) then
					player:sendMinitext("Congratulations!  You reach level "..player.level..", you need: "..tnlcalc.." experience to reach the next level.")
				end
				player.tnl = tnlcalc
				until (player.exp <= nextlevel or player.level == 5 or player.level == 99)
		end
	local calc1 = (player.level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
	local tnlcalc = (nextlevel - player.exp)
	player.tnl = tnlcalc
	player.helper = player.registry["fulltnl"]
	--player:sendMinitext("Look"..player.registry["fulltnl"].." and"..player.exp.."")
	--player:calcStat()
	if (player.level == 5 and player.class == 0) then
		player.tnl = 0
		player.helper = 0
	end
	if (player.level == 99) then
		player.tnl = 0
		player.helper = 0
	end
	player:sendStatus()
	end
end

UpdateTNLHelper = function(player)
	local calc1 = (player.level + 1)
	local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
	local tnlcalc = (nextlevel - player.exp)
	player.tnl = tnlcalc
	player.helper = player.registry["fulltnl"]
	--player:sendMinitext("Look"..player.registry["fulltnl"].." and"..player.exp.."")
	player:calcStat()
	player:sendStatus()
end

onLevelincrease = function(player)
local primary = math.ceil(((player.level + 1) * 1.025))
local secondary = math.floor((primary * .465))
local tertiary = math.ceil((secondary * .28))

if (player.class == 0) then
	if (player.level == 4) then
		player.registry["freeze_player_exp"] = player.exp

	elseif (player.level >= 5) then
		player:sendMinitext("You cannot increase your level without choosing a path first. Exp gain is capped.")
		player.exp = player.registry["freeze_player_exp"]
		return
	end
end


		if (player.registry["playerRefID"] ~= 0) then
			if (player.level == 49) then
				player:sendParcel(player.ID, player.registry["playerRefID"], 346, 1, 0, "", 0)
				player:sendParcel(player.registry["playerRefID"], player.ID, 346, 1, 0, "", 0)
			end
			if (player.level == 98) then
				player:sendParcel(player.ID, player.registry["playerRefID"], 350, 1, 0, "", 0)
				player:sendParcel(player.registry["playerRefID"], player.ID, 350, 1, 0, "", 0)
				player:sendParcel(player.registry["playerRefID"], player.ID, 348, 1, 0, "", 0)
			end
		end

		if (player.baseClass == 1) then
			player.baseHealth = player.baseHealth + (65 + math.random(15))
			player.baseMagic = player.baseMagic + (45 + math.random(15))
			player.basemight = primary
			player.basegrace = secondary
			player.basewill = tertiary
		elseif (player.baseClass == 2) then
			player.baseHealth = player.baseHealth + (60 + math.random(15))
			player.baseMagic = player.baseMagic + (50 + math.random(15))
			player.basemight = secondary
			player.basegrace = primary
			player.basewill = tertiary
		elseif (player.baseClass == 3) then
			player.baseHealth = player.baseHealth + (45 + math.random(15))
			player.baseMagic = player.baseMagic + (65 + math.random(15))
			player.basemight = tertiary
			player.basegrace = secondary
			player.basewill = primary
		elseif (player.baseClass == 4) then
			player.baseHealth = player.baseHealth + (50 + math.random(15))
			player.baseMagic = player.baseMagic + (60 + math.random(15))
			player.basemight = secondary
			player.basegrace = tertiary
			player.basewill = primary
		elseif (player.baseClass == 0) then
			player.baseMagic = player.baseMagic + (30 + math.random(15))
			player.baseHealth = player.baseHealth + (30 + math.random(15))
			player.basemight = math.ceil(player.level / 2)
			player.basegrace = math.ceil(player.level / 2)
			player.basewill = math.ceil(player.level / 2)
		end

		player.level = player.level + 1
		player.baseAC = 0
		player:calcStat()
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:sendStatus()
		player:sendAnimation(253, 0)
		return
end

onPickUp = function(player, item)
	if (player.pickUpType == 1) then--< Big pick up all.
		--player:talk(0,"Picked up "..item.amount.." "..Item(item.id).name.."("..item.id..")")
	else
		--player:talk(0,"Picked up 1 "..Item(item.id).name.."("..item.id..")")
	end

	if (Item(item.id).type ~= 20) then
		if (item.id ~= 36) then
			player:pickUp(item.ID)
		end
		--player:pickUp(item.ID)--Back to Core
	end

	if (player.m == 7100) and (item.id == 71 or item.id == 70) then
	--player:talk(0,""..player.name.." picked up the "..Item(item.id).name..".")
	broadcast(7100,""..player.name.." picked up the "..Item(item.id).name..".")
	if (item.id == 70) then
		player.registry["towertokenholderblue"] = player.id
	--	arena_keeper.tokenWatchblue(player, item)
	else
		player.registry["towertokenholderred"] = player.id
	end
	end
end

onDrop = function(player,item)
	--player:talk(0,"Dropped: "..Item(item.id).name.." ID: "..item.id.." Item amount: "..item.amount - item.lastAmount)
	if (player.m == 7100) and (item.id == 71 or item.id == 70) then
	--player:talk(0,""..player.name.." picked up the "..Item(item.id).name..".")
	if (item.id == 70) then
		player.registry["towertokenholderblue"] = 0
	--	arena_keeper.tokenWatchblue(player, item)
	else
		player.registry["towertokenholderred"] = 0
	end
	end
end

onEquip = function(player,item)
	--player:talk(0,"Equipped "..player.equipID)
	player:equip()

end

onUnequip = function(player,item)
	--player:talk(0,"Unequipped "..player:getEquippedItem(takeOffID).id)
	player:takeOff()
end

onDeathPlayer = function(player)
	if(player.state == 1) then
		return
	end
	if(player.state ~= 1 and player.pvp == 0) then
		for i = 0, player.maxInv do
			local nItem = player:getInventoryItem(i)
			
			--player:talk(0,"item"..Item(nItem.id).type)
			if (nItem ~= nil and nItem.id > 0) then
				if ((Item(nItem.id).type >= 3 and Item(nItem.id).type <= 17) and Item(nItem.id).breakondeath == 1) then
					if (nItem.protectnum <= 0) then
						--player:deductDuraInv(i, 9999999)
						player:removeItemSlot(i, 1, 13)
					end
					if (nItem.protectnum >= 1) then
						nItem.protectnum = nItem.protectnum - 1
					end
				end
			end
		end
		player:updateInv()
		for i = 0, 13 do

			local nItem = player:getEquippedItem(i)
			--player:talk(0,"item"..Item(nItem.id).type)
			if (nItem ~= nil and nItem.id > 0) then
				if(Item(nItem.id).breakondeath == 1) then
					if (nItem.protectnum <= 0) then
						--player:deductDuraInv(i, 9999999)
						player:deductDura(i, 999999999)
					end
					if (nItem.protectnum >= 1) then
						nItem.protectnum = nItem.protectnum - 1
					end
				end
			end
		end
	end
	--player:talk(0,"wew died!")
	if (player.registry["immortal"] == 1) then
		return
	elseif (player.registry["immortal"] == 2) then--from decoy
		player.registry["immortal"]	= 0
		return
	end

	if (player.registry["towertokenholderblue"] == player.id) then
		player.registry["towertokenholderblue"] = 0
		player:removeItem("bt_token", 1)
		player:dropItem(70, 1, 0)
	end

	if (player.registry["towertokenholderred"] == player.id) then
		player.registry["towertokenholderred"] = 0
		player:removeItem("rt_token", 1)
		player:dropItem(71, 1, 0)
	end

	player.deathFlag = 1
end

onCast = function(player)
	if (player.confused) then
		local randtargetpc = player:getObjectsInArea(player.m, player.x, player.y, BL_PC)
		local randtargetmob = player:getObjectsInArea(player.m, player.x, player.y, BL_MOB)
		local rand = math.random(100)
		
		if (rand <= 50) then
			player.target = randtargetpc[math.random(#randtargetpc)].ID
		elseif (rand > 50) then
			player.target = randtargetmob[math.random(#randtargetmob)].ID
		end
		
		player:sendMinitext("Your target has changed due to confusion!")
	end
	--player:talk(0,"Casted")
end

onBreak = function(player)
	--player:talk(0,"Broken "..player.breakID)
end

onThrow = function(player,item)
	--local y = player:getInventoryItem(player.invSlot) --returns inventory slot
	--player:talk(0,"Slot: "..player.invSlot.." Item returned "..y.name)
	player:throwItem()
end

onAction = function(player)
	--player:talk(0,"Action: "..player.action)

	if (player.registry["has_shadow_self"] == 1 and (player.action >= 9 and player.action <= 24)) then
		local cloneBlocks = player:getObjectsInArea(BL_MOB)
		if (#cloneBlocks > 0) then
			for i = 1, #cloneBlocks do
				if (cloneBlocks[i].yname == "shadow_decoy_mob" and cloneBlocks[i].owner == player.id) then
					cloneBlocks[i]:sendAction(player.action, 80)
				end
			end
		end
		--
	end

	if (player.m == 6001 and player.action ==4) then
		guard_house.paint(player)
	end
	
	if (player.m == 6002 and player.action ==4) then
		guard_house.lightsOut(player)
	elseif (player.m == 6005 and player.action ==4) then
		guard_house.toggleTiles(player)
		if (player.quest["masterOfDeception"] == 6) then
			local iX, iY
			local tileA = 0
			local tileB = 0
			for iX = 3, 7 do
				for iY = 5, 9 do
					if (getTile(6005, iX, iY)  == 1251) then
						tileA = tileA + 1
					elseif (getTile(6005, iX, iY) == 1233) then
						tileB = tileB + 1
					end
				end
			end
			if (tileA == 0 or tileB == 0) then
				emperor_golden_vase_chest.open(player, NPC("emperor_golden_vase_chest"))
				--scramble
				guard_house.scramble(player)
				--[[
				local tileAB = {1233, 1251}
				for iX = 3, 7 do
					for iY = 5, 9 do
						local tile = tileAB[math.random(#tileAB)]
						setTile(6005, iX, iY, tile)
					end
				end
				]]--
			end
		end
	end
end

onSign = function(player, signType)
	local objFacing = getObjFacing(player)
	local m = player.m
	local x = player.x
	local y = player.y
	local side = player.side
	local str = ""

	if (signType == 1) then--onLook
		if (m == 15) then
			if ((x >= 86 and x <= 89) and (y >= 29 and y <= 31)) then--Arena Board
				player:showBoard(270)
			end
		end
		if (m == 161) then
			if (x == 20 and y == 6) then--Arena Board
				player:showBoard(151)
			end
		end
		if (m == 0) then
			if ((x >= 9 and x <= 12) and (y >= 18 and y <= 20)) then--GM Board
				player:showBoard(290)
			end
		end
		if (m == 72) then
			if ((x >= 2 and x <= 5) and (y >= 9 and y <= 11)) then--Magistrate Board
				player:showBoard(150)
			end
		end
	elseif (signType == 2) then--onScriptedTile
		--subpath boards
		if (m == 2006) then
			if (((x == 9 or x == 10) and y == 17) and player.side == 0) then
				player:showBoard(106)
			end
		end
		if (m == 2007) then
			if (((x == 4 or x == 5) and y == 3) and player.side == 0) then
				player:showBoard(107)
			end
		end
		if (m == 2008) then
			if (((x == 18 or x == 19) and y == 7) and player.side == 0) then
				player:showBoard(108)
			end
		end
		if (m == 2009) then
			if (((x == 7 or x == 8) and y == 10) and player.side == 0) then
				player:showBoard(109)
			end
		end
		if (m == 2010) then
			if (((x == 16 or x == 17) and y == 6) and player.side == 0) then
				player:showBoard(110)
			end
		end
		if (m == 2011) then
			if (((x == 15 or x == 16) and y == 14) and player.side == 0) then
				player:showBoard(111)
			end
		end
		if (m == 2012) then
			if (((x == 16 or x == 17) and y == 17) and player.side == 0) then
				player:showBoard(112)
			end
		end
		if (m == 2013) then
			if (((x == 10 or x == 11) and y == 5) and player.side == 0) then
				player:showBoard(113)
			end
		end
		--Stone Tablet
		if (m == 518) then
			if (((x == 4 or x == 5) and y == 22) and player.side == 0) then
				player:showBoard(200)
			end
		end
		--
		if (m == 161) then
			if (((x == 21 or x == 22) and y == 7) and player.side == 0) then
				player:showBoard(151)
			end
		end
		if (m == 40) then
			if ((x == 100 and y == 14 and side == 1) or
			((x == 101 or x == 102) and y == 15 and side == 0) or
			(x == 103 and y == 14 and side == 3)) then--Rat Cave sign
				str = "<b>DANGER!\n\n"
				str = str.."Rat infestation"
				player:popUp(str)
			elseif ((x == 114 or x == 115) and y == 44 and side == 0) then--The Mithian Edict
				player:showBoard(256)
			end
		end
		if (m == 15) then
			if ((x == 87 or x == 88) and y == 31 and side == 0) then--Arena Board
				player:showBoard(270)
			end
		end
		if (m == 0) then
			if ((x == 10 or x == 11) and y == 20 and side == 0) then--Arena Board
				player:showBoard(290)
			end
		end
		if (m == 72) then
			if ((x >= 3 and x <= 4) and (y == 11)) then--Magistrate Board
				player:showBoard(150)
			end
		end
	elseif (signType == 3) then--onTurn
		--subpath boards
		if (m == 2006) then
			if (((x == 9 or x == 10) and y == 17) and player.side == 0) then
				player:showBoard(106)
			end
		end
		if (m == 2007) then
			if (((x == 4 or x == 5) and y == 3) and player.side == 0) then
				player:showBoard(107)
			end
		end
		if (m == 2008) then
			if (((x == 18 or x == 19) and y == 7) and player.side == 0) then
				player:showBoard(108)
			end
		end
		if (m == 2009) then
			if (((x == 7 or x == 8) and y == 10) and player.side == 0) then
				player:showBoard(109)
			end
		end
		if (m == 2010) then
			if (((x == 16 or x == 17) and y == 6) and player.side == 0) then
				player:showBoard(110)
			end
		end
		if (m == 2011) then
			if (((x == 15 or x == 16) and y == 14) and player.side == 0) then
				player:showBoard(111)
			end
		end
		if (m == 2012) then
			if (((x == 16 or x == 17) and y == 17) and player.side == 0) then
				player:showBoard(112)
			end
		end
		if (m == 2013) then
			if (((x == 10 or x == 11) and y == 5) and player.side == 0) then
				player:showBoard(113)
			end
		end
		--Stone Tablet
		if (m == 518) then
			if (((x == 4 or x == 5) and y == 22) and player.side == 0) then
				player:showBoard(200)
			end
		end
		--
		if (m == 40) then
			if ((x == 114 or x == 115) and y == 44 and side == 0) then--The Mithian Edict
				player:showBoard(256)
			end
		end
		if (m == 161) then
			if (((x == 21 or x == 22) and y == 7) and player.side == 0) then
				player:showBoard(151)
			end
		end
	end
end

onLook = function(player, block)
	onSign(player, 1)
	player:lookAt(block.ID)
	--Check to avoid double printing for GMs
	if (player:staff("script") >= 3 and player:staff("pm") == -1 and player.gmLevel < 50) then
		--BL_PC, BL_MOB, BL_NPC, BL_ITEM
		local str = ""
		if (block.blType == BL_PC) then
			str = ""..block.classNameMark.." | "..block.name.." ("..string.format("%.2f", (block.health / block.maxHealth * 100)).."%) ID: "..block.id
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_MOB) then
			str = ""..block.name.." | "..block.yname.." ("..string.format("%.2f", (block.health / block.maxHealth * 100)).."%) id: "..block.id.." ID: "..block.ID.." mobID: "..block.mobID
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_NPC) then
			str = ""..block.name.." | "..block.yname.." "..block.id
			player:msg(0, ""..str, player.id)
		elseif (block.blType == BL_ITEM) then
			str = ""..block.name.." | "..block.yname.." "..block.id
			player:msg(0, ""..str, player.id)
		end
	end
end

onDismount = function(player)
	--if(player.registry["mount_type"] == 1) then
	--	player:spawn(24,player.x,player.y,1)
	--end
	if (player.registry["store_mount_id"] ~= 0) then
		local passCheck
		local warpCheck

		if (player.side == 0) then
			passCheck = getPass(player.m, player.x, player.y-1)
			warpCheck = getWarp(player.m, player.x, player.y-1)
			if (passCheck == 0 and warpCheck == false) then
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y-1)
			else
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y)
			end
		elseif (player.side == 1) then
			passCheck = getPass(player.m, player.x+1, player.y)
			warpCheck = getWarp(player.m, player.x+1, player.y)
			if (passCheck == 0 and warpCheck == false) then
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x+1, player.y)
			else
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y)
			end
		elseif (player.side == 2) then
			passCheck = getPass(player.m, player.x, player.y+1)
			warpCheck = getWarp(player.m, player.x, player.y+1)
			if (passCheck == 0 and warpCheck == false) then
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y+1)
			else
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y)
			end
		elseif (player.side == 3) then
			passCheck = getPass(player.m, player.x-1, player.y)
			warpCheck = getWarp(player.m, player.x-1, player.y)
			if (passCheck == 0 and warpCheck == false) then
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x-1, player.y)
			else
				Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y)
			end
		end
	end
	--Mob(player.registry["store_mount_id"]):warp(player.m, player.x, player.y)
	player.registry["store_mount_id"] = 0
	player.registry["mount_type"] = 0
	player.disguise = 0
	player.state = 0
	player:calcStat()
	player:updateState()
end

remount = function(player)
	local mount = player.registry["mount_type"]
	
	if (mount > 0 and player.state == 3) then
		if (mount == 1) then
			player.speed = player.speed - 20
		elseif (mount == 2) then
			player.speed = player.speed - 25
		end
		
		player:updateState()
	else
		player.registry["mount_type"] = 0
	end
end

onDeathMob = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].target == mob.ID and mobBlocks[i].owner > 0) then
				mobBlocks[i].target = mobBlocks[i].owner
			end
		end
	end
end
