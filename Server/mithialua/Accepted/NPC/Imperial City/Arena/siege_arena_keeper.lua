siege_arena_keeper = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local players = npc:getObjectsInSameMap(BL_PC)
	local options = {}
	local choice = ""
	local sells = {"pinyan_soju", "pinyan_soba"}
	
	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	if (player.m == 7001) then
		table.insert(options, "Buy")
	end

	if (player.m == 7001) then
		table.insert(options, "Leave Event")
	end
	if ((player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and player.m == 7001) then
		table.insert(options, "Dye Participants")
		table.insert(options, "Bleach Participants")
		table.insert(options, "Sort Participants")
		table.insert(options, "Set Round Count")
		table.insert(options, "Host Sage")
		table.insert(options, "Nuisance")
		table.insert(options, "====================")
		if (npc.registry["roundCount"] > 0) then
			table.insert(options, "Start Tower Battle")
		end
	end
		if ((player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and player.m == 7100) then
		table.insert(options, "Nuisance")
		table.insert(options, "Round Start: 10 seconds")
		table.insert(options, "Round Start: 60 seconds")
		table.insert(options, "Cancel Round")
		end

	
	choice = player:menuString("How can I help you?", options)
	
	if (choice == "Buy") then
		player:buyExtend("What do you wish to buy?", sells)
	elseif (choice =="Nuisance") then
		local nameofPlayer
		nameofPlayer=player:input("Who do you need to remove?")
		local nuisance = Player(nameofPlayer)
			if(nuisance ~= nil) then
				if (nuisance.m >= 7000 and nuisance.m <= 7200) then
							nuisance:warp(7008, 8, 8)
							nuisance.registry["inCarnage"] = 0
							nuisance:sendMinitext("You have been removed by "..player.name..".")
							player:sendMinitext(""..nameofPlayer.." has been removed.")
				else
				player:sendMinitext("They are not on any arena maps.")
				end
			else
			player:sendMinitext("They are not on any arena maps.")
			end
	elseif (choice == "Dye Participants") then
		powerBoard(player)
	elseif (choice == "Bleach Participants") then
		for i = 1, #players do
			if (players[i].registry["inCarnage"] == 1) then
				players[i].armorColor = 0
				players[i]:updateState()
			end
		end
	elseif (choice == "Sort Participants" and #players > 0) then
		local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
		
		for i = 1, #players do
			if (players[i].armorColor == 63) then
				players[i]:warp(npc.m, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 60) then
				players[i]:warp(npc.m, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (players[i].armorColor == 61) then
				players[i]:warp(npc.m, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(npc.m, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			end
		end
	elseif (choice == "Set Battlefield") then
		local options = {"Onslaught"}
		local choice = player:menuString("Which event type are you hosting?", options)
		
		if (choice == "Onslaught") then
			local options = {"Village", "Do Not Use"}
			local choice = player:menuString("Please select the arena.", options)
			
			if (choice == "Village") then
				npc.registry["arena"] = 7010
				player:broadcast(player.m, "Host "..player.name.." has chosen Village arena.")
			elseif (choice == "Do Not Use") then
				npc.registry["arena"] = 7011
				player:broadcast(player.m, "Host "..player.name.." has chosen Do Not Use arena.")
			end
		end
	elseif (choice == "Host Sage") then
		player:addSpell("host_sage")
		player:sendMinitext("Your mind expands as you learn Host Sage.")
	elseif (choice == "Set Round Count") then
		npc.registry["roundCount"] = tonumber(player:input("How many rounds will this event be?"))
		player:sendMinitext("You set the round count to: "..npc.registry["roundCount"].." rounds.")
		--player:broadcast(player.m, "Host "..player.name.." has selected "..npc.registry["roundCount"].." rounds")
	elseif (choice == "Start Tower Battle") then
		npc.registry["siegeStarted"] = 1
	elseif (choice == "Round Start: 60 seconds") then
		for i = 1, #players do
			players[i]:setTimer(2, 60)
		end
		npc.registry["siegeBegin"] = os.time() + 60
		broadcast(npc.m, "Siege starting in 1 minute.")
	elseif (choice == "Cancel Round") then

	local playersrezred = npc:getObjectsInMap(7101, BL_PC)
	local playersrezblue = npc:getObjectsInMap(7102, BL_PC)
	local towers = npc:getObjectsInSameMap(BL_MOB)
		--Kill towers because we need to start a new match...
		if (#towers ~= 0) then
			for i = 1, #towers do
				if (towers[i].mobID == 70) then
					towers[i]:delete()
				elseif (towers[i].mobID == 71) then
					towers[i]:delete()
				end
			end
		end

		for i = 1, #players do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (players[i].armorColor == 63) then
				players[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			players[i]:flushDuration(1)
			players[i]:flushAether(1)
			players[i].state = 0
			players[i].health = players[i].maxHealth
			players[i].magic = players[i].maxMagic
			players[i]:removeItem("bt_token", 3)
			players[i]:removeItem("rt_token", 3)
			players[i]:updateState()
			players[i]:sendStatus()
		end
		for i = 1, #playersrezred do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (playersrezred[i].armorColor == 63) then
				playersrezred[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (playersrezred[i].armorColor == 65) then
				playersrezred[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (playersrezred[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				playersrezred[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			playersrezred[i]:flushDuration(1)
			playersrezred[i]:flushAether(1)
			playersrezred[i].state = 0
			playersrezred[i].health = players[i].maxHealth
			playersrezred[i].magic = players[i].maxMagic
			playersrezred[i]:removeItem("bt_token", 3)
			playersrezred[i]:removeItem("rt_token", 3)
			playersrezred[i]:updateState()
			playersrezred[i]:sendStatus()
		end
		for i = 1, #playersrezblue do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (playersrezblue[i].armorColor == 63) then
				playersrezblue[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (playersrezblue[i].armorColor == 65) then
				playersrezblue[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (playersrezblue[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				playersrezblue[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			playersrezblue[i]:flushDuration(1)
			playersrezblue[i]:flushAether(1)
			playersrezblue[i].state = 0
			playersrezblue[i].health = players[i].maxHealth
			playersrezblue[i].magic = players[i].maxMagic
			playersrezblue[i]:removeItem("bt_token", 3)
			playersrezblue[i]:removeItem("rt_token", 3)
			playersrezblue[i]:updateState()
			playersrezblue[i]:sendStatus()
		end

		npc:warp(7001, 14, 3)

	elseif (choice == "Round Start: 10 seconds") then
		for i = 1, #players do
			players[i]:setTimer(2, 10)
		end
		npc.registry["siegeBegin"] = os.time() + 10
		broadcast(npc.m, "Siege starting in 1 minute.")
	elseif (choice == "Leave Event") then
		local choice = player:menuString("Are you sure you wish to leave the event?", {"Yes", "No"})
		if (choice == "Yes") then
			
			player:removeItem("bt_token",3)
			player:removeItem("rt_token",3)
			player.armorColor = player.registry["arenaDyeSave"]
			player.registry["arenaDyeSave"] = 0
			player:warp(7000, math.random(7, 16), math.random(13, 14))
		else
			player:dialogSeq({npcGraphics, "Very well, please be patient."}, 1)
		end
	end
end),

action = function(npc)
	local traps = npc:getObjectsInMap(7100, BL_NPC)
	local players = npc:getObjectsInSameMap(BL_PC)
	local towertokensonground = npc:getObjectsInSameMap(BL_ITEM)
	local blueground = 0
	local redground = 0
	local bluetokenplayercheck = 0
	local redtokenplayercheck = 0
	local towers = npc:getObjectsInSameMap(BL_MOB)
	local bluetowercount = 0		
	local redtowercount = 0
	local roundCount = npc.registry["roundCount"]
	local color = npc.registry["siege_winner"]

	local redWins = npc.registry["redWins"]
	local blueWins = npc.registry["blueWins"]
	local winner = winner

--I see dead people, warp them to rez locations.

if (npc.registry["calcsiegewins"] == 1) then
	local playersrezred = npc:getObjectsInMap(7101, BL_PC)
	local playersrezblue = npc:getObjectsInMap(7102, BL_PC)
		--Kill towers because we need to start a new match...
		if (#towers ~= 0) then
			for i = 1, #towers do
				if (towers[i].mobID == 70) then
					towers[i]:delete()
				elseif (towers[i].mobID == 71) then
					towers[i]:delete()
				end
			end
		end

		if (roundCount == 0 and redWins > blueWins) or (redWins > blueWins + roundCount) then
			npc.registry["siege_winner"] = 63
			npc.registry["roundCount"] = 0
		elseif (roundCount == 0 and blueWins > redWins) or (blueWins > redWins + roundCount) then
			npc.registry["siege_winner"] = 65
			npc.registry["roundCount"] = 0
		end	

		for i = 1, #players do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (players[i].armorColor == 63) then
				players[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			players[i]:flushDuration(1)
			players[i]:flushAether(1)
			players[i].state = 0
			players[i].health = players[i].maxHealth
			players[i].magic = players[i].maxMagic
			players[i]:removeItem("bt_token", 3)
			players[i]:removeItem("rt_token", 3)
			players[i]:updateState()
			players[i]:sendStatus()
		end
		for i = 1, #playersrezred do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (playersrezred[i].armorColor == 63) then
				playersrezred[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (playersrezred[i].armorColor == 65) then
				playersrezred[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (playersrezred[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				playersrezred[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			playersrezred[i]:flushDuration(1)
			playersrezred[i]:flushAether(1)
			playersrezred[i].state = 0
			playersrezred[i].health = players[i].maxHealth
			playersrezred[i].magic = players[i].maxMagic
			playersrezred[i]:removeItem("bt_token", 3)
			playersrezred[i]:removeItem("rt_token", 3)
			playersrezred[i]:updateState()
			playersrezred[i]:sendStatus()
		end
		for i = 1, #playersrezblue do
			local mats = {red = {3, 5, 11, 13},  blue = {17, 5, 25, 13}}
			
			if (playersrezblue[i].armorColor == 63) then
				playersrezblue[i]:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (playersrezblue[i].armorColor == 65) then
				playersrezblue[i]:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (playersrezblue[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				playersrezblue[i]:warp(7001, math.random(13, 15), math.random(13, 14))
			end
			
			playersrezblue[i]:flushDuration(1)
			playersrezblue[i]:flushAether(1)
			playersrezblue[i].state = 0
			playersrezblue[i].health = players[i].maxHealth
			playersrezblue[i].magic = players[i].maxMagic
			playersrezblue[i]:removeItem("bt_token", 3)
			playersrezblue[i]:removeItem("rt_token", 3)
			playersrezblue[i]:updateState()
			playersrezblue[i]:sendStatus()
		end



		npc:warp(7001, 14, 3)
		npc.registry["calcsiegewins"] = 0
		return
end

	if (npc.m == 7100) then
		for i = 1, #players do
			if (players[i].state == 1) then
				if (players[i].armorColor == 63) then
				players[i]:warp(7101, math.random(3, 13), math.random(7, 9))
				elseif (players[i].armorColor == 65) then
				players[i]:warp(7102, math.random(3, 13), math.random(5, 7))
				end
			end
		end
		--------------------------------------
------------------------------------
--------Calculate Siege wins
-------------------------------------
		for i = 1, #towertokensonground do
			if (towertokensonground[i].id == 70) then
				blueground = blueground + 1
				broadcast(npc.m,"There is a "..towertokensonground[i].name.." on the ground at: ("..towertokensonground[i].x..", "..towertokensonground[i].y..")")
			end
			if (towertokensonground[i].id == 71) then
				redground = redground + 1
				broadcast(npc.m,"There is a "..towertokensonground[i].name.." on the ground at: ("..towertokensonground[i].x..", "..towertokensonground[i].y..")")
			end
		end

		for i = 1, #players do
			if (players[i]:hasItem("bt_token", 1) == true) then
				bluetokenplayercheck = bluetokenplayercheck + 1
				--broadcast(npc.m,""..players[i].name.." is in possession of the Blue Tower Token!")
				players[i]:sendAnimation(218, 2)
			end
			if (players[i]:hasItem("rt_token", 1) == true) then
				redtokenplayercheck = redtokenplayercheck + 1
				--broadcast(npc.m,""..players[i].name.." is in possession of the Red Tower Token!")
				players[i]:sendAnimation(206, 2)
			end
		end

		for i = 1, #towers do
			if (towers[i].mobID == 70 and towers[i].x == 54 and towers[i].y == 13) then
				npc.registry["calcsiegewins"] = 1
				broadcast(7100, "Red wins the round!")
				towers[i]:delete()
				npc.registry["redWins"] = redWins + 1
				redWins = redWins + 1
				return
			elseif (towers[i].mobID == 71 and towers[i].x == 5 and towers[i].y == 13) then
				npc.registry["calcsiegewins"] = 1
				broadcast(7100, "Blue wins the round!")
				towers[i]:delete()
				npc.registry["blueWins"] = blueWins + 1
				blueWins = blueWins + 1
				return
			end
			if (towers[i].mobID == 70) then
				bluetowercount = bluetowercount + 1
			elseif (towers[i].mobID == 71) then
				redtowercount = redtowercount + 1
			end
		end
				--The tower is gone, and a player with the token left.. we have to make a new tower.. none on ground
				if (bluetowercount == 0 and blueground == 0 and bluetokenplayercheck == 0) then
				npc:spawn(70, 10, 13, 1)
				end
				if (redtowercount == 0 and redground == 0 and redtokenplayercheck == 0) then
				npc:spawn(71, 49, 13, 1)
				end
	end



if (npc.m == 7001) then
--Siege start script
if (npc.registry["siegeStarted"] == 1 and roundCount > 0 and #players > 0) then
			if (#traps > 0) then
				for i = 1, #traps do
					if (traps[i].yname ~= "siege_arena_keeper") then
						if (traps[i].yname ~= "exit_arena_games") then
							traps[i]:delete()
						end
					end
				end
			end
		for i = 1, #players do
			players[i].registry["towertokenholderblue"] = 0
			players[i].registry["towertokenholderred"] = 0
			if (players[i].armorColor == 63) then
				players[i]:warp(7100, math.random(43, 55), math.random(9, 19))
				carnage_veil.cast(players[i])
				players[i]:removeItem("bt_token", 3)
				players[i]:removeItem("rt_token", 3)
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7100, math.random(4, 16), math.random(9, 19))
				carnage_veil.cast(players[i])
				players[i]:removeItem("bt_token", 3)
				players[i]:removeItem("rt_token", 3)
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7100, 28, 9)
			end
		end
		npc:warp(7100, 29, 12)

--Closing doors and making unpassable
	setPass(npc.m, 9, 20, 1)
	setPass(npc.m, 10, 20, 1)
	setPass(npc.m, 11, 20, 1)
	setPass(npc.m, 9, 8, 1)
	setPass(npc.m, 10, 8, 1)
	setPass(npc.m, 11, 8, 1)
	setPass(npc.m, 48, 20, 1)
	setPass(npc.m, 49, 20, 1)
	setPass(npc.m, 50, 20, 1)
	setPass(npc.m, 48, 8, 1)
	setPass(npc.m, 49, 8, 1)
	setPass(npc.m, 50, 8, 1)
	--Closing
		setObject(npc.m, 9, 20, 53)
		setObject(npc.m, 10, 20, 54)
		setObject(npc.m, 11, 20, 55)

		setObject(npc.m, 9, 8, 53)
		setObject(npc.m, 10, 8, 54)
		setObject(npc.m, 11, 8, 55)

		setObject(npc.m, 48, 8, 78)
		setObject(npc.m, 49, 8, 79)
		setObject(npc.m, 50, 8, 80)

		setObject(npc.m, 48, 20, 78)
		setObject(npc.m, 49, 20, 79)
		setObject(npc.m, 50, 20, 80)

npc.registry["siegeStarted"] = 0
npc.registry["roundCount"] = roundCount - 1
--end

------------------------------------------------------
		elseif (npc.registry["siege_winner"] > 0 and npc.registry["roundCount"] == 0 and #players > 0) then
			if (color == 60) then
				color = "Black"
			elseif (color == 61) then
				color = "White"
			elseif (color == 63) then
				color = "Red"
			elseif (color == 65) then
				color = "Blue"
			end
			
			broadcast(npc.m, color.. " has won the Tower Battle! Thank you for participating.")
			
			for i = 1, #players do
				if (players[i].armorColor == npc.registry["siege_winner"]) then
					players[i]:warp(7003, math.random(3, 13), math.random(9, 11))
					--Give them the WIN MARK! Maybe not.. NPC in prize room can do that.
					players[i].registry["event_win_type"] = 3
				elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7001, math.random(13, 15), math.random(13, 14))
				else
					players[i].armorColor = players[i].registry["arenaDyeSave"]
					players[i].registry["arenaDyeSave"] = 0
					players[i]:warp(7000, math.random(7, 16), math.random(13, 14))
				end
				
				players[i].registry["inCarnage"] = 0
			end
			
			npc.registry["redWins"] = 0
			npc.registry["blackWins"] = 0
			npc.registry["whiteWins"] = 0
			npc.registry["blueWins"] = 0
			npc.registry["siege_winner"] = 0
			npc.registry["arena"] = 0
		end
	else


	if (npc.registry["siegeBegin"] > 0 and npc.registry["siegeBegin"] <= os.time()) then
	setPass(npc.m, 9, 20, 0)
	setPass(npc.m, 10, 20, 0)
	setPass(npc.m, 11, 20, 0)
	setPass(npc.m, 9, 8, 0)
	setPass(npc.m, 10, 8, 0)
	setPass(npc.m, 11, 8, 0)
	setPass(npc.m, 48, 20, 0)
	setPass(npc.m, 49, 20, 0)
	setPass(npc.m, 50, 20, 0)
	setPass(npc.m, 48, 8, 0)
	setPass(npc.m, 49, 8, 0)
	setPass(npc.m, 50, 8, 0)
		setObject(npc.m, 9, 20, 102)
		setObject(npc.m, 10, 20, 103)
		setObject(npc.m, 11, 20, 104)

		setObject(npc.m, 9, 8, 102)
		setObject(npc.m, 10, 8, 103)
		setObject(npc.m, 11, 8, 104)

		setObject(npc.m, 48, 8, 105)
		setObject(npc.m, 49, 8, 106)
		setObject(npc.m, 50, 8, 107)

		setObject(npc.m, 48, 20, 105)
		setObject(npc.m, 49, 20, 106)
		setObject(npc.m, 50, 20, 107)
		npc.registry["siegeBegin"] = 0
	elseif (npc.registry["siegeBegin"] > 0 and npc.registry["siegeBegin"] > os.time()) then
	setPass(npc.m, 9, 20, 1)
	setPass(npc.m, 10, 20, 1)
	setPass(npc.m, 11, 20, 1)
	setPass(npc.m, 9, 8, 1)
	setPass(npc.m, 10, 8, 1)
	setPass(npc.m, 11, 8, 1)
	setPass(npc.m, 48, 20, 1)
	setPass(npc.m, 49, 20, 1)
	setPass(npc.m, 50, 20, 1)
	setPass(npc.m, 48, 8, 1)
	setPass(npc.m, 49, 8, 1)
	setPass(npc.m, 50, 8, 1)
	--Closing
		setObject(npc.m, 9, 20, 53)
		setObject(npc.m, 10, 20, 54)
		setObject(npc.m, 11, 20, 55)

		setObject(npc.m, 9, 8, 53)
		setObject(npc.m, 10, 8, 54)
		setObject(npc.m, 11, 8, 55)

		setObject(npc.m, 48, 8, 78)
		setObject(npc.m, 49, 8, 79)
		setObject(npc.m, 50, 8, 80)

		setObject(npc.m, 48, 20, 78)
		setObject(npc.m, 49, 20, 79)
		setObject(npc.m, 50, 20, 80)
	end
end
end,

warpSelf = function(npc)
	local map = npc.registry["arena"]
	
	if (map == 7010) then
		npc:warp(map, 16, 18)
	elseif (map == 7011) then
		npc:warp(map, 18, 19)
	end
end,

warpPlayers = function(npc, players)
	local map = npc.registry["arena"]
	
	if (map == 7010) then
		for i = 1, #players do
			if (players[i].armorColor == 60) then
				players[i]:warp(map, math.random(8), math.random(26, 33))
			elseif (players[i].armorColor == 61) then
				players[i]:warp(map, math.random(22, 29), math.random(8))
			elseif (players[i].armorColor == 63) then
				players[i]:warp(map, math.random(8), math.random(8))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(map, math.random(22, 29), math.random(26, 33))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(map, math.random(14, 17), math.random(16, 19))
			end
		end
	elseif (map == 7011) then
		local x = 0
		local y = 0
		
		for i = 1, #players do
			if (players[i].armorColor == 60) then
				repeat
					x = math.random(8)
					y = math.random(29, 36)
				until (getPass(7011, x, y) == 0 and getObject(7011, x, y) == 0)
			elseif (players[i].armorColor == 61) then
				repeat
					x = math.random(27, 34)
					y = math.random(8)
				until (getPass(7011, x, y) == 0 and getObject(7011, x, y) == 0)
			elseif (players[i].armorColor == 63) then
				repeat
					x = math.random(8)
					y = math.random(8)
				until (getPass(7011, x, y) == 0 and getObject(7011, x, y) == 0)
			elseif (players[i].armorColor == 65) then
				repeat
					x = math.random(27, 34)
					y = math.random(29, 36)
				until (getPass(7011, x, y) == 0 and getObject(7011, x, y) == 0)
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				repeat
					x = math.random(15, 20)
					y = math.random(16, 20)
				until (getPass(7011, x, y) == 0 and getObject(7011, x, y) == 0)
			end
			
			players[i]:warp(map, x, y)
		end
	end
end,

}