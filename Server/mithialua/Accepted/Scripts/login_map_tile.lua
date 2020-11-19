login = function(player)
	player.helper = player.registry["fulltnl"]
	player:sendStatus()
	player:calcStat()
	--FIRST LOGIN
	local logincount = player.registry["login_count"]

--player.registry["inCarnage"] = 0

	logincount = logincount + 1
	if (logincount == 0) then
		if (player.m == 0) then
			player:freeAsync()
			opening_scene.firstlogin(player)
		elseif (player.m == 144) then
			player:freeAsync()
			tutorial.choice(player)
		end
	elseif (logincount > 0) then
		logincount = logincount + 1
		if (player:staff() == true) then
		--
		else
			local friends = player:getFriends()
			
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, ""..player.name.." has logged in.", friends[i].ID)
				end
			end
		end
		player.registry["login_count"] = logincount
	end
	
	if (not player:hasLegend("arrived") and player.gmLevel == 0) then
			if (player.id == 17) then
				return
			end
		player:addLegend("Washed up on the Pinyan shore. "..curT(), "arrived", 0, 16)
	end

	if (player.registry["login_count_koh"] <= 1) then
		player.registry["login_count_koh"] = player.registry["login_count_koh"] + 1
	end

	if (player.registry["login_count_koh"] == 1) then
		player.basemight = player.basemight + 1
		player.basegrace = player.basegrace + 1
		player.basewill = player.basewill + 1

		local calc1 = (player.level + 1)
		local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
		local tnlcalc = (nextlevel - player.exp)
		player.tnl = tnlcalc
		player.helper = player.registry["fulltnl"]
		player:calcStat()
		player:sendStatus()
	end
	--[[if (logincount == 0) then
		if (player.m == 0) then
			player:freeAsync()
			opening_scene.firstlogin(player)
		elseif (player.m == 144) then
			player:freeAsync()
			tutorial.choice(player)
		end
	elseif (logincount > 0) then
		logincount = logincount + 1
		if (player:staff() == true) then
		--
		else
			local friends = player:getFriends()
			
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, ""..player.name.." has logged in.", friends[i].ID)
				end
			end
		end
		player.registry["login_count"] = logincount
	end
	
	if (player.registry["instanceMap"] > 0) then
		player:warp(player.registry["instanceMap"], player.registry["instanceX"], player.registry["instanceY"])
		player.registry["instanceMap"] = 0
		player.registry["instanceX"] = 0
		player.registry["instanceY"] = 0
	end
	
	if (player.m == 10000) then
		objBrowser()
	elseif (player.m == 10001) then
		tileBrowser()
	end]]--
	
	if (player.gmLevel > 50) then
		player:speak("/online",0)
		--player:speak("/stealth",0)--Disabling stealth on login for now.
	end
	
end

logout = function(player)
	player:removeItem("bt_token", 1)
	player.registry["towertokenholderblue"] = 0
	player.registry["towertokenholderred"] = 0
	player.registry["has_shadow_self"] = 0
	player.totemTime = 0

	if (player.registry["mushroomactive"] == 1) then
	setObject(player.registry["mushroommap"], player.registry["mushroomx"], player.registry["mushroomy"], 0)
	if (player:hasDuration("wild_mushroom")) then
		player:setDuration("wild_mushroom", 0, 0, 1)
	end
	end


	if (player.registry["store_mount_id"] > 0) then
		local mobis = Mob(player.registry["store_mount_id"])
		mobis:warp(mobis.startM, mobis.startX, mobis.startY)
		player.registry["store_mount_id"] = 0
		player.registry["mount_type"] = 0
		player.disguise = 0
		player.state = 0
	end
	
	player.registry["ambush_timer"] = 0
	if (player.gmLevel < 50) then
		if (player:staff() == true) then
			--staff doesn't broadcast
		else
			local friends = player:getFriends()
			
			if (#friends > 0) then
				for i = 1, #friends do
					player:msg(4, ""..player.name.." has logged out.", friends[i].ID)
				end
			end
		end
	end
	
	--[[if (player.m >= 60000) then
		player.registry["instanceMap"] = player.m
		player.registry["instanceX"] = player.x
		player.registry["instanceY"] = player.y
		player:warp(40, math.random(75, 82), math.random(17, 19))
	end
	
	if (player.m > 30000) then
		player:warp(10010, 8, 7)
	end
	
	if (player.m >= 20000 and player.m <= 20020) then
		player.registry["login_count"] = 0
		player.state = 0
		player:warp(144, 59, 40)
	end
	
	if (player.m >= 21000 and player.m <= 21020) then
		player:warp(1, 28, 62)
	end]]--
end

mapWeather = function()
	local x, weather
	weather = math.random(1,5)
	if(math.random(4) == 2) then
		if(weather > 3 and weather < 5 and getCurSeason() == "Spring") then
			setWeather(0,0,0)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Summer") then
			setWeather(0,0,0)
		elseif(weather == 4 and getCurSeason() == "Fall") then
			setWeather(0,0,0)
		elseif(weather > 3 and getCurSeason() == "Winter") then
			setWeather(0,0,0)
		elseif(weather <= 3 and weather > 1 and getCurSeason() == "Spring") then
			setWeather(0,0,1)
		elseif(weather == 1 and getCurSeason() == "Summer") then
			setWeather(0,0,1)
		elseif(weather >= 2 and weather < 4 and getCurSeason() == "Fall") then
			setWeather(0,0,1)
		elseif(weather == 1 and (getCurSeason() == "Spring" or getCurSeason() == "Fall")) then
			setWeather(0,0,2)
		elseif(weather <= 3 and getCurSeason() == "Winter") then
			setWeather(0,0,2)
		elseif(weather == 5 and getCurSeason() == "Spring") then
			setWeather(0,0,0)
		elseif(weather >= 4 and getCurSeason() == "Summer") then
			setWeather(0,0,0)
		elseif(weather == 5 and getCurSeason() == "Fall") then
			setWeather(0,0,0)
		else
			setWeather(0,0,getWeather(0,0))
		end
	else
		setWeather(0,0,getWeather(0,0))
	end
end

mapEnter = function(player)
	local m = player.m

	--checking if mounts are allowed on the map
	if (player.state == 3) then
		if (player.mountallow == 0) then
			if (player.registry["store_mount_id"] ~= 0) then
				player:sendMinitext("Mounts are not allowed here.")
				Mob(player.registry["store_mount_id"]):warp(Mob(player.registry["store_mount_id"]).startM, Mob(player.registry["store_mount_id"]).startX, Mob(player.registry["store_mount_id"]).startY)
				player.registry["store_mount_id"] = 0
			end
			onDismount(player)
		end
	end

	if (player.mapRegistry["bondedRing_vitaReq"] > 0 and player.mapRegistry["bondedRing_manaReq"] > 0) then
		if (player.gmLevel == 99) then
			player:sendMinitext("HP Req: "..player.mapRegistry["bondedRing_vitaReq"])
			player:sendMinitext("MP Req: "..player.mapRegistry["bondedRing_manaReq"])
		end
		--player:sendMinitext("Entering:")
		if (player.maxHealth > (player.mapRegistry["bondedRing_vitaReq"] + 25000)) then
			player.shieldVal = 3
			player:sendStatus()
		end

		if (player.maxMagic > (player.mapRegistry["bondedRing_manaReq"] + 12500)) then
			player.shieldVal = 3
			player:sendStatus()
		end

		if (player.maxHealth > (player.mapRegistry["bondedRing_vitaReq"] + 50000)) then
			player.shieldVal = 5
			player:sendStatus()
		end

		if (player.maxMagic > (player.mapRegistry["bondedRing_manaReq"] + 25000)) then
			player.shieldVal = 5
			player:sendStatus()
		end

	else
		player.shieldVal = 0

	end

	


	--[[player:sendMinitext("Entering")
	if (m == 0 and player.registry["login_count"] == 0) then
		player:freeAsync()
		opening_scene.firstlogin(player)
	elseif (m==6) then
		local xset = {5,6,8,10,12,8}
		local yset = {3,6,9,6,3,3}
		local b1 = 0
		local b2 = 0
		--find if any boss is alive
		local bosscount = 0
		local finding = {}
		finding = player:getObjectsInSameMap(BL_MOB)
		for i = 1, #finding do
			if (finding[i].mobID == 9) or (finding[i].mobID == 10) then
				bosscount = bosscount + 1
			end
		end
		if (bosscount == 0 and player.mapRegistry["worm_spawn"] < os.time()) then
			player.mapRegistry["worm_spawn"] = os.time() + 60
			--spawn
			local c = math.random(1,16)
			if (c<=3) and (c>=1) then
				b1 = 1
			elseif (c<=6) and (c>=4) then
				b1 = 2
			elseif (c<=9) and (c>=7) then
				b1 = 3
			elseif (c<=12) and (c>=10) then
				b1 = 4
			elseif (c<=15) and (c>=13) then
				b1 = 5
			elseif (c==16) then
				b1 = 6
			end
			repeat
				local d = math.random(1,16)
				if (d<=3) and (d>=1) and (b1 ~= 1) then
					b2 = 1
				elseif (d<=6) and (d>=4) and (b1 ~= 2) then
					b2 = 2
				elseif (d<=9) and (d>=7) and (b1 ~= 3) then
					b2 = 3
				elseif (d<=12) and (d>=10) and (b1 ~= 4) then
					b2 = 4
				elseif (d<=15) and (d>=13) and (b1 ~= 5) then
					b2 = 5
				elseif (d==16) and (b1 ~= 6) then
					b2 = 6
				end
			until b2 > 0
			player:spawn(9,xset[b1],yset[b1],1)
			player:spawn(10,xset[b2],yset[b2],1)
		end
	elseif (m == 10000) then
		objBrowser()
	elseif (m == 10001) then
		tileBrowser()
	elseif (m == 10010) then
		if ((player:staff("pm") > 0) or (player:staff("map") > 0) or (player:staff("lore") > 0) or (player:staff("script") > 0)) then
			player:sendMinitext("Welcome "..player.name..".")
		else
			broadcast(-1,""..player.name.." is attempting to hack into the meeting room.")
			player:warp(1,15,15)
			--SEND TO JAIL
		end
	elseif (m == 10013) then
		player:addSpell("bomber_bomb")
		player.registry["bomber_count"] = 4
		player.registry["bomber_range"] = 4
	elseif (m >= 60000) then
		doInstanceSpawns(player)
	end
	--player:talk(0,"Entered")--]]
	local spellIDs = player:getSpells()
	if (m == 7041 and #spellIDs >= 52) then
		player:dialog("You may not learn any more spells, please forget a spell first to participate in this game.", {})
		return
	end
	if (m == 7041 and #spellIDs < 52) then
		player:sendMinitext("Check your spells for Bomber Bomb.")
		player:addSpell("bomber_bomb")
		player.registry["bomber_count"] = 4
		player.registry["bomber_range"] = 4
	end
end

mapLeave = function(player)
	local m = player.m
	if (m == 7041) then
		player:removeSpell("bomber_bomb")
		player.registry["bomber_count"] = 0
		player.registry["bomber_range"] = 0
	end
	--player:sendMinitext("Leaving")
	--player:talk(0,"Left")--]]
end

onScriptedTile = function(player)
	--Runs before warps
	local x = player.x
	local y = player.y
	local m = player.m
	local level = player.level
	--player:talk(0,"Map: "..m.." X: "..x.." Y: "..y)
	--[[if (player.state == 0) then
		player.steps = player.steps + 1
	end]]--

	onSign(player, 2)

	if (m == 1) then--Droplet Cave
		if (y == 6 and (x == 61 or x == 62 or x == 63) and player.quest["tutorial"] ~= 8) then
			player:sendMinitext("You may not enter here.")
			player:warp(player.m, x, y + 1)
		elseif (y == 52 and (x >= 22 and x <= 27) and player.quest["tutorial"] <= 9) then
			player:sendMinitext("You are not ready to travel down this path just yet.")
			player:warp(player.m, x, y - 1)
		elseif (y == 10 and (x == 73 or x == 74) and player.gmLevel < 1) then
			player:sendMinitext("This area is restricted to GM only.")
			player:warp(player.m, x, y + 1)
		elseif ((x == 6 and y == 6) or (x == 5 and y == 6)) then
				--local npcg = {graphic = convertGraphic(1385, "monster"), color = 0}
				local icong = {graphic = convertGraphic(885, "item"), color = 0}
				player.npcGraphic = icong.graphic
				player.npcColor = icong.color
				player.dialogType = 0
			if (player.registry["loginmessagetut"] == 0) then
			player.registry["loginmessagetut"] = 1
			--player:dialogSeq({"You awaken to the sounds of waves.  You are a bit dazed and confused but you can see a house in the distance.  You should probably make your way there. ((35, 15))"}, 1)
			player:dialogSeq({icong,"You awaken to the sounds of waves. You are a bit dazed and confused but you can see a house in the distance. You should probably make your way there. ((35, 15))"})
			--player:sendMinitext("You awaken to the sounds of waves.  You are a bit dazed and confused but you can see a house in the distance.  You should probably make your way there. ((35, 15))")
			--player.dialogType = 0
			--player:dialogSeq({"You awaken to the sounds of waves.  You are a bit dazed and confused but you can see a house in the distance.  You should probably make your way there. ((35, 15))"}, 1)
			end
		end
	elseif (m == 5)then
		if(x == 27) and (y >= 20 and y <= 26) then
			if (player.quest["path_choice_quest"] == 0 or player.quest["path_choice_quest"] == 1) then
			player:sendMinitext("You must first complete the guard's task and obtain more insight. ((Level 5 required.))")
			player:warp(player.m, x - 1, y)
			end
		end
--City of Han
	elseif (m == 15) then
		--Bats
		if (y == 61 and x == 9 and level < 15) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x, y + 1)
		end
		--Foxes
		if (y == 24 and (x == 77 or x == 78) and level < 8) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x, y + 1)
		end

		if (y == 12 and (x >= 76 and x <= 85) and level < 85) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x, y + 1)
		end
		--Knights and Seers
		if (x == 104 and y == 109 and player.class == 6) then
				player:warp(2006, 9, 18)
		end
		if (x == 105 and y == 109 and player.class == 6) then
				player:warp(2006, 10, 18)
		end

		if (x == 85 and y == 107 and player.class == 11) then
				player:warp(2011, 9, 18)
		end
		if (x == 86 and y == 107 and player.class == 11) then
				player:warp(2011, 10, 18)
		end
--Pinyan quest script
	elseif (m == 28) then
		if (y == 35 and (x == 1 or x == 2) and player.quest["P_anapple"] == 1) then
			player:freeAsync()
			pinyan_inn_keeper.shakeappletree(player)
			--player:dialogSeq({apple, "You notice a healthy apple tree and give it a shake!",
			--apple, "Test"}, 1)
			--pinyan_inn_keeper.shakeappletree(player)
			--local ranx math.random(0, 4)
			--local rany math.random(31, 38)
			--player:dropItemXY(40, 1, 28, 6, 35, 0)
		end
--Dor Nolan Wilds
	elseif (m == 37) then
			if (y == 63 and (x == 27 or x == 28 or x == 29 or x == 30) and level < 20) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 38 and (x == 62 or x == 63 or x == 64) and level < 37) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 51 and x == 99 and level < 25) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 9 and x == 36 and level < 79) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			--portal warps
			if (x == 4 and y == 51 and player.class == 8) then
					player:warp(2008, 9, 18)
			end
			--Shadows
			if ((x == 31 or x == 32) and y == 24) then
				--local npc = player:getObjectsInCell(37, 33, 25, BL_NPC)
				EoDestiny.portalwarpcheck(player, npc)
			end
--Pirates ent, for ship
	elseif (m == 38) then
			if (x == 55 and (y >= 10 and y <= 16) and level < 95) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x - 1, y)
			end
	elseif (m == 39) then
		if ((y == 3 and x == 26) and player.quest["H_deadpeople2"] == 1) then
			player:freeAsync()
			han_inn_keeper.book_han_inn(player)
			--player:dialogSeq({apple, "You notice a healthy apple tree and give it a shake!",
			--apple, "Test"}, 1)
			--pinyan_inn_keeper.shakeappletree(player)
			--local ranx math.random(0, 4)
			--local rany math.random(31, 38)
			--player:dropItemXY(40, 1, 28, 6, 35, 0)
		end
	--Kalbog Pass
	elseif (m == 47) then
		--Du Jan Volcano
		if (x == 0 and (y == 9 or y == 8 or y == 7) and level < 73) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x + 1, y)
		end
		-- Kalbog Fae
		if (x == 44 and (y == 39 or y == 40 or y == 41 or y == 42) and level < 43) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x - 1, y)
		end
		--Ogres
		if (y == 0 and (x >= 31 and x <= 39) and level < 91) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x, y + 1)
		end
	elseif (m == 67) then
		if (y == 13) then
			local golemparacheck = player:getObjectsInMap(player.m, BL_MOB)
			if (golemparacheck[1].paralyzed == true) then
				player:sendMinitext("You quickly make an escape from the golem!")
			else
				player:sendMinitext("You attempt to go south but the golem is too close, you retreat!")
				player:warp(player.m, x, y - 1)
				local icong = {graphic = convertGraphic(2246, "item"), color = 0}
				player.npcGraphic = icong.graphic
				player.npcColor = icong.color
				player.dialogType = 0
				player:dialogSeq({icong,"The golem will not allow you to pass, perhaps he can be incapacitated some how."})
			end
		end
--Vogt Forest
	elseif (m == 74) then
		--Druids, Archers, and Elementalists
			if (x == 54 and y == 101 and player.class == 12) then
					player:warp(2012, 9, 18)
			end
			if (x == 55 and y == 101 and player.class == 12) then
					player:warp(2012, 10, 18)
			end

			if (x == 9 and y == 63 and player.class == 9) then
					player:warp(2009, 4, 18)
			end

			if (x == 92 and y == 65 and player.class == 10) then
					player:warp(2010, 8, 18)
			end
			if (x == 93 and y == 65 and player.class == 10) then
					player:warp(2010, 9, 18)
			end
			--Serpent Cave
			if (y == 36 and x == 57 and level < 61) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			--Flower Cave
			if (y == 23 and (x == 79 or x == 80) and level < 67) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
-- Seong Lowlands
	elseif (m == 77) then
			if (y == 10 and (x == 65 or x == 66 or x == 67 or x == 68) and level < 50) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 58 and x == 53 and level < 31) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 65 and (x == 44 or x == 45 or x == 46) and level < 55) then
				player:sendMinitext("You lack the insight to walk in here.")
				player:warp(player.m, x, y + 1)
			end
			if (y == 15 and (x >= 39 or x <= 53)) then
				if (player.quest["spec_deliv"] == 1) then
					if (player:hasItem("c_deliv", 1) == true) then
						local wolf = {graphic = convertGraphic(23, "monster"), color = 21}
						player.dialogType = 0
						player:removeItem("c_deliv", 1)
						player.quest["spec_deliv"] = 2
						player:dialogSeq({wolf, "A wolf jumps out at you and snatches the package but you strike back, in a single blow the wolf... VANISHES!?"}, 1)
					end
				end
			end
--Gladiators and Bards
	elseif (m == 82) then
			if (x == 18 and y == 5 and player.class == 7) then
					player:warp(2007, 8, 18)
			end
			if (x == 19 and y == 5 and player.class == 7) then
					player:warp(2007, 9, 18)
			end

			if (x == 66 and y == 66 and player.class == 13) then
					player:warp(2013, 9, 18)
			end
			if (x == 67 and y == 66 and player.class == 13) then
					player:warp(2013, 10, 18)
			end
--Pirates Cave (Underwater ent)
	elseif (m == 142) then
		if (y == 4 and (x >= 24 and x <= 30) and level < 99) then
			player:sendMinitext("You lack the insight to walk in here.")
			player:warp(player.m, x, y + 1)
		end
--Scholars access to room
	elseif (m == 159) then
		if ((x == 23 or x == 24) and y == 2) then
			if (player:hasLegend("scholar_appoint") == false) then
				player:sendMinitext("You may not enter here.")
				player:warp(player.m, x, y + 1)
			end
		end
	--Sky Palace Tile Drops
	elseif (m == 252 or m == 252 or m == 253 or m == 254 or m == 255 or m == 256 or m == 257 or m == 258 or m == 259 or m == 260 or m == 261) then
		local tileCheck = getTile(m, x, y)
		if (tileCheck == 37053) then
					if (player.state ~= 1) then
						player:sendAnimationXY(103, player.x, player.y, 0)
						player:warp(262, player.x, player.y)
						player:die()
						player:updateState()
					else
						player:sendAnimationXY(103, player.x, player.y, 0)
						player:warp(262, player.x, player.y)
					end
					player:sendAnimationXY(378, player.x, player.y)
					player:playSound(92)
					player.dialogType = 0
					player:dialogSeq({"You have fallen from the sky palace."}, 1)
		end
	elseif (m == 173 and (x >= 32 or x <= 40) and y == 1) then
		if (player.maxHealth < 50000 and player.maxMagic < 25000) then
			player:sendMinitext("You must be stronger to enter here.")
			player:warp(player.m, x, y + 1)
			return
		end
		if (player.quest["yibokyen_intro"] == 0) then
			player:sendMinitext("You aren't certain you should travel here yet...")
			player:warp(player.m, x, y + 1)
		end
	elseif (m == 585 and (x == 32 or x == 33) and y == 17) then
		if (player.quest["yibokyen_intro"] == 2) then
			player.quest["yibokyen_intro"] = 3
			player:dialogSeq({"You stop before the door, a great chill comes over you.. You study the text written on the door, perhaps this will be of use to Gin Dian."}, 1)
		end
		if (player.quest["yibokyen_intro"] >= 4) then
			local weapon = player:getEquippedItem(EQ_WEAP)
			if (weapon ~= nil and weapon.id >= 271 and weapon.id <= 274) then
				player:warp(player.m, x, y + 3)
				player:dialogSeq({"The power of your weapon allows you to pass effortlessly through the spell-sealed door."}, 1)
			else
				player:warp(player.m, x, y - 1)
				player:dialogSeq({"You cannot pass this door without the power of the frozen weapons."}, 1)
			end
		end
	elseif (m == 585 and (x == 32 or x == 33) and y == 19) then
		player:warp(player.m, x, y - 3)
	-- Voo doo temple and mask quest
	elseif (m == 272 and (x >= 2 and x <= 6) and y == 0) then
		if (player.maxHealth < 25000 and player.maxMagic < 12500) then
			player:sendMinitext("You must be stronger to enter here.")
			player:warp(player.m, x, y + 1)
			return
		end
	elseif (m == 518 and (y >= 10 and y <= 13) and x == 27) then
		local mask = player:getEquippedItem(EQ_CROWN)
		if (mask ~= nil or player.quest["voodoo_mask_uw"] == 1) then
			if (player.quest["voodoo_mask_uw"] == 1) then
				player:sendMinitext("You jump into the water, immediately you are stunned. Somehow you are still able to breathe... Voodoo Magic.")
				player:warp(532, 5, 7)
				return
			end
			if (mask.id == 50028) then
				player:deductDura(EQ_CROWN, 1000)
				player:sendMinitext("You jump into the water, immediately you are stunned. Somehow you are still able to breathe... Voodoo Magic.")
				player.quest["voodoo_mask_uw"] = 1
				player:warp(532, 5, 7)
			else
				player:sendMinitext("You cant enter into the water without a breathing mask.")
				player:warp(player.m, x-1, y)
				return
			end
		else
			player:sendMinitext("You cant enter into the water without a breathing mask.")
			player:warp(player.m, x-1, y)
			return
		end
	end
	--Close
end

onTurn = function(player)
	onSign(player, 3)
end
