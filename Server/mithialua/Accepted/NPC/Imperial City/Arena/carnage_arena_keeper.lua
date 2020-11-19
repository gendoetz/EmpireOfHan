carnage_arena_keeper = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local players = npc:getObjectsInSameMap(BL_PC)
	local options = {}
	local choice = ""
	local sells = {"pinyan_soju", "pinyan_soba"}
	
	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0
	player.lastClick = npc.ID
	
	if ((player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and player.m == 7005) then
		table.insert(options, "Dye participants")
		table.insert(options, "Bleach participants")
		table.insert(options, "Sort participants")
		table.insert(options, "Set battlefield")
		table.insert(options, "Set round count")
		table.insert(options, "Start event")
		table.insert(options, "Host Sage")
		table.insert(options, "Nuisance")
		table.insert(options, "====================")
	end

	if ((player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and (player.m == 7010 or player.m == 7011)) then
		table.insert(options, "Round Start: 10 seconds")
		table.insert(options, "Round Start: 60 seconds")
		table.insert(options, "Pause Match")
		table.insert(options, "Resume Match")
		table.insert(options, "Decide Winner")
		table.insert(options, "Cancel Match")
		table.insert(options, "====================")
	end
	
	if (player.m == 7005) then
		table.insert(options, "Buy")
	end
	
	if (player.m == 7005 and player.armorColor ~= 60 and player.armorColor ~= 61 and player.armorColor ~= 63 and player.armorColor ~= 65) then
		table.insert(options, "Leave Event")
	end
	
	choice = player:menuString("How can I help you?", options)
	
	if (choice == "Buy") then
		player:buyExtend("What do you wish to buy?", sells)

	elseif (choice == "Round Start: 10 seconds" and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and #players > 0) then
		for i = 1, #players do
			players[i]:setTimer(2, 10)
		end

		npc.registry["roundStart"] = os.time() + 10
		broadcast(npc.m, "Round starting in 10 seconds.")
	elseif (choice == "Round Start: 60 seconds" and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and #players > 0) then
		for i = 1, #players do
			players[i]:setTimer(2, 60)
		end
		
		npc.registry["roundStart"] = os.time() + 60
		broadcast(npc.m, "Round starting in 1 minute.")
	elseif (choice == "Pause Match") then
		broadcast(npc.m, "The match has been paused.")
		player.pvp = 0
	elseif (choice == "Resume Match") then
		broadcast(npc.m, "The match has been resumed.")
		player.pvp = 1
	elseif (choice == "Cancel Match") then
		for i = 1, #players do
			local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
			
			if (players[i].armorColor == 63) then
				players[i]:warp(7005, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 60) then
				players[i]:warp(7005, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (players[i].armorColor == 61) then
				players[i]:warp(7005, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7005, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7005, 13, 16)
			end
			
			players[i]:flushDuration(1)
			--players[i]:flushAether(1)
			players[i].state = 0
			players[i].health = players[i].maxHealth
			players[i].magic = players[i].maxMagic
			players[i]:updateState()
			players[i]:sendStatus()
		end
		npc:warp(7005, 14, 3)
		npc.registry["roundCount"] = npc.registry["roundCount"] + 1
	elseif (choice == "Decide Winner" and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and #players > 0) then
		local redWins = npc.registry["redWins"]
		local blackWins = npc.registry["blackWins"]
		local whiteWins = npc.registry["whiteWins"]
		local blueWins = npc.registry["blueWins"]
		local roundCount = npc.registry["roundCount"]

		local redCount = 0
		local blackCount = 0
		local whiteCount = 0
		local blueCount = 0
		local winner = {}
		local eventWinner = {}
		local comparison = function(a, b)
			return a > b
		end
		
		for i = 1, #players do
			if (players[i].state == 0) then
				if (players[i].armorColor == 60) then
					blackCount = blackCount + 1
				elseif (players[i].armorColor == 61) then
					whiteCount = whiteCount + 1
				elseif (players[i].armorColor == 63) then
					redCount = redCount + 1
				elseif (players[i].armorColor == 65) then
					blueCount = blueCount + 1
				end
			end
		end
		
		table.insert(winner, redCount)
		table.insert(winner, blackCount)
		table.insert(winner, whiteCount)
		table.insert(winner, blueCount)
		table.sort(winner, comparison)
		
		if (winner[1] == redCount) then
			broadcast(npc.m, "Red wins the match.")
			npc.registry["redWins"] = redWins + 1
			redWins = redWins + 1
		end
		
		if (winner[1] == blackCount) then
			broadcast(npc.m, "Black wins the match.")
			npc.registry["blackWins"] = blackWins + 1
			blackWins = blackWins + 1
		end
		
		if (winner[1] == whiteCount) then
			broadcast(npc.m, "White wins the match.")
			npc.registry["whiteWins"] = whiteWins + 1
			whiteWins = whiteWins + 1
		end
		
		if (winner[1] == blueCount) then
			broadcast(npc.m, "Blue wins the match.")
			npc.registry["blueWins"] = blueWins + 1
			blueWins = blueWins + 1
		end
		
		for i = 1, 4 do
			table.remove(winner)
		end
		
		table.insert(winner, redWins)
		table.insert(winner, blackWins)
		table.insert(winner, whiteWins)
		table.insert(winner, blueWins)
		table.sort(winner, comparison)
		
		--npc:talk(0, winner[1].." "..winner[2].." "..winner[3].." "..winner[4])
		
		if (roundCount == 0 or winner[1] > winner[2] + roundCount) then
			table.insert(eventWinner, redWins)
			table.insert(eventWinner, blackWins)
			table.insert(eventWinner, whiteWins)
			table.insert(eventWinner, blueWins)
			table.sort(eventWinner, comparison)
			
			if (eventWinner[1] == redWins) then
				npc.registry["winner"] = 63
			elseif (eventWinner[1] == blackWins) then
				npc.registry["winner"] = 60
			elseif (eventWinner[1] == whiteWins) then
				npc.registry["winner"] = 61
			elseif (eventWinner[1] == blueWins) then
				npc.registry["winner"] = 65
			end
			
			npc.registry["roundCount"] = 0
		end
		
		for i = 1, #players do
			local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
			
			if (players[i].armorColor == 63) then
				players[i]:warp(7005, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 60) then
				players[i]:warp(7005, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (players[i].armorColor == 61) then
				players[i]:warp(7005, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7005, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7005, 13, 16)
			end
			
			players[i]:flushDuration(1)
			--players[i]:flushAether(1)
			players[i].state = 0
			players[i].health = players[i].maxHealth
			players[i].magic = players[i].maxMagic
			players[i]:updateState()
			players[i]:sendStatus()
		end
		
		npc:warp(7005, 14, 3)
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
	elseif (choice == "Dye participants") then
		powerBoard(player)
	elseif (choice == "Bleach participants") then
		for i = 1, #players do
			if (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel < 50) then
				players[i].armorColor = 0
			end
		end
	elseif (choice == "Sort participants" and #players > 0) then
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
	elseif (choice == "Set battlefield") then
			local options = {"Crossroads", "Violet Fire"}
			local choice = player:menuString("Please select the arena.", options)
			
			if (choice == "Crossroads") then
				npc.registry["arena"] = 7010
				--player:broadcast(player.m, "Host "..player.name.." has chosen Crossroads arena.")
			elseif (choice == "Violet Fire") then
				npc.registry["arena"] = 7011
				--player:broadcast(player.m, "Host "..player.name.." has chosen Violet Fire arena.")
			end
	elseif (choice == "Set round count") then
		npc.registry["roundCount"] = tonumber(player:input("How many rounds will this event be?"))
		--player:broadcast(player.m, "Host "..player.name.." has selected "..npc.registry["roundCount"].." rounds")
	elseif (choice == "Start event") then
		npc.registry["eventStarted"] = 1
	elseif (choice == "Leave Event") then
		local choice = player:menuString("Are you sure you wish to leave the event?", {"Yes", "No"})
		if (choice == "Yes") then
			
			player.armorColor = player.registry["arenaDyeSave"]
			player.registry["arenaDyeSave"] = 0
			player:warp(7000, math.random(7, 16), math.random(13, 14))
		else
			player:dialogSeq({npcGraphics, "Very well, please be patient."}, 1)
		end
	end
end),

say = function(player, npc)
	local speech = string.lower(player.speech)
	local players = npc:getObjectsInSameMap(BL_PC)
	local redWins = npc.registry["redWins"]
	local blackWins = npc.registry["blackWins"]
	local whiteWins = npc.registry["whiteWins"]
	local blueWins = npc.registry["blueWins"]
	local roundCount = npc.registry["roundCount"]
	
	if (npc.m < 7010) then
		return
	end
	
	if ((string.find(speech, "(.*)pause match(.*)")) and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1)) then
		broadcast(npc.m, "The match has been paused.")
		player.pvp = 0
	elseif ((string.find(speech, "(.*)resume match(.*)")) and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1)) then
		broadcast(npc.m, "The match has resumed.")
		player.pvp = 1
	elseif ((string.find(speech, "(.*)stop match(.*)")) and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and #players > 0) then
		local redCount = 0
		local blackCount = 0
		local whiteCount = 0
		local blueCount = 0
		local winner = {}
		local eventWinner = {}
		local comparison = function(a, b)
			return a > b
		end
		
		for i = 1, #players do
			if (players[i].state == 0) then
				if (players[i].armorColor == 60) then
					blackCount = blackCount + 1
				elseif (players[i].armorColor == 61) then
					whiteCount = whiteCount + 1
				elseif (players[i].armorColor == 63) then
					redCount = redCount + 1
				elseif (players[i].armorColor == 65) then
					blueCount = blueCount + 1
				end
			end
		end
		
		table.insert(winner, redCount)
		table.insert(winner, blackCount)
		table.insert(winner, whiteCount)
		table.insert(winner, blueCount)
		table.sort(winner, comparison)
		
		if (winner[1] == redCount) then
			broadcast(npc.m, "Red wins the match.")
			npc.registry["redWins"] = redWins + 1
			redWins = redWins + 1
		end
		
		if (winner[1] == blackCount) then
			broadcast(npc.m, "Black wins the match.")
			npc.registry["blackWins"] = blackWins + 1
			blackWins = blackWins + 1
		end
		
		if (winner[1] == whiteCount) then
			broadcast(npc.m, "White wins the match.")
			npc.registry["whiteWins"] = whiteWins + 1
			whiteWins = whiteWins + 1
		end
		
		if (winner[1] == blueCount) then
			broadcast(npc.m, "Blue wins the match.")
			npc.registry["blueWins"] = blueWins + 1
			blueWins = blueWins + 1
		end
		
		for i = 1, 4 do
			table.remove(winner)
		end
		
		table.insert(winner, redWins)
		table.insert(winner, blackWins)
		table.insert(winner, whiteWins)
		table.insert(winner, blueWins)
		table.sort(winner, comparison)
		
		--npc:talk(0, winner[1].." "..winner[2].." "..winner[3].." "..winner[4])
		
		if (roundCount == 0 or winner[1] > winner[2] + roundCount) then
			table.insert(eventWinner, redWins)
			table.insert(eventWinner, blackWins)
			table.insert(eventWinner, whiteWins)
			table.insert(eventWinner, blueWins)
			table.sort(eventWinner, comparison)
			
			if (eventWinner[1] == redWins) then
				npc.registry["winner"] = 63
			elseif (eventWinner[1] == blackWins) then
				npc.registry["winner"] = 60
			elseif (eventWinner[1] == whiteWins) then
				npc.registry["winner"] = 61
			elseif (eventWinner[1] == blueWins) then
				npc.registry["winner"] = 65
			end
			
			npc.registry["roundCount"] = 0
		end
		
		for i = 1, #players do
			local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
			
			if (players[i].armorColor == 63) then
				players[i]:warp(7005, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (players[i].armorColor == 60) then
				players[i]:warp(7005, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (players[i].armorColor == 61) then
				players[i]:warp(7005, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (players[i].armorColor == 65) then
				players[i]:warp(7005, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
				players[i]:warp(7005, 13, 16)
			end
			
			players[i]:flushDuration(1)
			--players[i]:flushAether(1)
			players[i].state = 0
			players[i].health = players[i].maxHealth
			players[i].magic = players[i].maxMagic
			players[i]:updateState()
			players[i]:sendStatus()
		end
		
		npc:warp(7005, 14, 3)
	elseif ((string.find(speech, "(.*)start match(.*)")) and (player.gmLevel >= 50 or player.registry["carnagehost"] >= 1) and #players > 0) then
		for i = 1, #players do
			players[i]:setTimer(2, 60)
		end
		
		npc.registry["roundStart"] = os.time() + 60
		broadcast(npc.m, "Round starting in 1 minute.")
	end
end,

action = function(npc)
	local traps = npc:getObjectsInMap(npc.registry["arena"], BL_NPC)
	local players = npc:getObjectsInSameMap(BL_PC)
	local roundCount = npc.registry["roundCount"]
	local color = npc.registry["winner"]
	
	if (npc.m == 7005) then
		if (npc.registry["eventStarted"] == 1 and roundCount > 0 and #players > 0) then
			carnage_arena_keeper.togglePass(npc, 1)
			carnage_arena_keeper.warpPlayers(npc, players)
			
			if (#traps > 0) then
				for i = 1, #traps do
					if (traps[i].yname ~= "carnage_arena_keeper") then
						if (traps[i].yname ~= "exit_arena_games") then
							traps[i]:delete()
						end
					end
				end
			end
			
			carnage_arena_keeper.warpSelf(npc)
			npc.registry["eventStarted"] = 0
			npc.registry["roundCount"] = roundCount - 1
		elseif (npc.registry["winner"] > 0 and npc.registry["roundCount"] == 0 and #players > 0) then
			if (color == 60) then
				color = "Black"
			elseif (color == 61) then
				color = "White"
			elseif (color == 63) then
				color = "Red"
			elseif (color == 65) then
				color = "Blue"
			end
			
			broadcast(npc.m, color.. " has won the Carnage. Thank you for participating.")
			
			for i = 1, #players do
				if (players[i].armorColor == npc.registry["winner"]) then
					players[i]:warp(7003, math.random(3, 13), math.random(9, 11))
					players[i].registry["event_win_type"] = 1
				elseif (players[i].registry["carnagehost"] >= 1 or players[i].gmLevel >= 50) then
					players[i]:warp(7005, 14, 12)
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
			npc.registry["winner"] = 0
			npc.registry["arena"] = 0
		end
	else
		if (npc.registry["roundStart"] > 0 and npc.registry["roundStart"] <= os.time()) then
			carnage_arena_keeper.togglePass(npc, 0)
			npc.registry["roundStart"] = 0
		elseif (npc.registry["roundStart"] > 0 and npc.registry["roundStart"] > os.time()) then
			carnage_arena_keeper.togglePass(npc, 1)
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
				carnage_veil.cast(players[i])
			elseif (players[i].armorColor == 61) then
				players[i]:warp(map, math.random(22, 29), math.random(8))
				carnage_veil.cast(players[i])
			elseif (players[i].armorColor == 63) then
				players[i]:warp(map, math.random(8), math.random(8))
				carnage_veil.cast(players[i])
			elseif (players[i].armorColor == 65) then
				players[i]:warp(map, math.random(22, 29), math.random(26, 33))
				carnage_veil.cast(players[i])
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
			if (players[i].registry["inCarnage"] == 1) then
			carnage_veil.cast(players[i])
			end
		end
	end
end,

togglePass = function(npc, bool)
	local map = npc.registry["arena"]
	
	if (map == 7010) then
		setPass(map, 1, 25, bool)
		setPass(map, 2, 25, bool)
		setPass(map, 3, 25, bool)
		setPass(map, 4, 25, bool)
		setPass(map, 6, 25, bool)
		setPass(map, 7, 25, bool)
		setPass(map, 8, 25, bool)
		setPass(map, 9, 26, bool)
		setPass(map, 9, 27, bool)
		setPass(map, 9, 28, bool)
		setPass(map, 9, 29, bool)
		setPass(map, 9, 30, bool)
		setPass(map, 9, 31, bool)
		setPass(map, 9, 32, bool)
		setPass(map, 9, 33, bool)
		
		setPass(map, 29, 9, bool)
		setPass(map, 28, 9, bool)
		setPass(map, 27, 9, bool)
		setPass(map, 26, 9, bool)
		setPass(map, 25, 9, bool)
		setPass(map, 24, 9, bool)
		setPass(map, 23, 9, bool)
		setPass(map, 22, 9, bool)
		setPass(map, 21, 8, bool)
		setPass(map, 21, 7, bool)
		setPass(map, 21, 6, bool)
		setPass(map, 21, 5, bool)
		setPass(map, 21, 4, bool)
		setPass(map, 21, 3, bool)
		setPass(map, 21, 2, bool)
		setPass(map, 21, 1, bool)
		
		setPass(map, 1, 9, bool)
		setPass(map, 2, 9, bool)
		setPass(map, 3, 9, bool)
		setPass(map, 4, 9, bool)
		setPass(map, 5, 9, bool)
		setPass(map, 6, 9, bool)
		setPass(map, 7, 9, bool)
		setPass(map, 8, 9, bool)
		setPass(map, 9, 8, bool)
		setPass(map, 9, 7, bool)
		setPass(map, 9, 6, bool)
		setPass(map, 9, 5, bool)
		setPass(map, 9, 4, bool)
		setPass(map, 9, 3, bool)
		setPass(map, 9, 2, bool)
		setPass(map, 9, 1, bool)
		
		setPass(map, 22, 25, bool)
		setPass(map, 23, 25, bool)
		setPass(map, 24, 25, bool)
		setPass(map, 25, 25, bool)
		setPass(map, 26, 25, bool)
		setPass(map, 27, 25, bool)
		setPass(map, 28, 25, bool)
		setPass(map, 29, 25, bool)
		setPass(map, 21, 26, bool)
		setPass(map, 21, 27, bool)
		setPass(map, 21, 28, bool)
		setPass(map, 21, 29, bool)
		setPass(map, 21, 30, bool)
		setPass(map, 21, 31, bool)
		setPass(map, 21, 32, bool)
		setPass(map, 21, 33, bool)
	elseif (map == 7011) then
		setPass(map, 1, 28, bool)
		setPass(map, 2, 28, bool)
		setPass(map, 3, 28, bool)
		setPass(map, 4, 28, bool)
		setPass(map, 5, 28, bool)
		setPass(map, 6, 28, bool)
		setPass(map, 7, 28, bool)
		setPass(map, 8, 28, bool)
		setPass(map, 9, 29, bool)
		setPass(map, 9, 30, bool)
		setPass(map, 9, 31, bool)
		setPass(map, 9, 32, bool)
		setPass(map, 9, 33, bool)
		setPass(map, 9, 34, bool)
		setPass(map, 9, 35, bool)
		setPass(map, 9, 36, bool)
		
		setPass(map, 34, 9, bool)
		setPass(map, 33, 9, bool)
		setPass(map, 32, 9, bool)
		setPass(map, 31, 9, bool)
		setPass(map, 30, 9, bool)
		setPass(map, 29, 9, bool)
		setPass(map, 28, 9, bool)
		setPass(map, 27, 9, bool)
		setPass(map, 26, 8, bool)
		setPass(map, 26, 7, bool)
		setPass(map, 26, 6, bool)
		setPass(map, 26, 5, bool)
		setPass(map, 26, 4, bool)
		setPass(map, 26, 3, bool)
		setPass(map, 26, 2, bool)
		setPass(map, 26, 1, bool)
		
		setPass(map, 1, 9, bool)
		setPass(map, 2, 9, bool)
		setPass(map, 3, 9, bool)
		setPass(map, 4, 9, bool)
		setPass(map, 5, 9, bool)
		setPass(map, 6, 9, bool)
		setPass(map, 7, 9, bool)
		setPass(map, 8, 9, bool)
		setPass(map, 9, 8, bool)
		setPass(map, 9, 7, bool)
		setPass(map, 9, 6, bool)
		setPass(map, 9, 5, bool)
		setPass(map, 9, 4, bool)
		setPass(map, 9, 3, bool)
		setPass(map, 9, 2, bool)
		setPass(map, 9, 1, bool)
		
		setPass(map, 27, 28, bool)
		setPass(map, 28, 28, bool)
		setPass(map, 29, 28, bool)
		setPass(map, 30, 28, bool)
		setPass(map, 31, 28, bool)
		setPass(map, 32, 28, bool)
		setPass(map, 33, 28, bool)
		setPass(map, 34, 28, bool)
		setPass(map, 26, 29, bool)
		setPass(map, 26, 30, bool)
		setPass(map, 26, 31, bool)
		setPass(map, 26, 32, bool)
		setPass(map, 26, 33, bool)
		setPass(map, 26, 34, bool)
		setPass(map, 26, 35, bool)
		setPass(map, 26, 36, bool)
	end
end
}