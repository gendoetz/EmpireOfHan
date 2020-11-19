spawn_controller = {

click = async(function(player, npc)

end),

click = async(function(player, npc)
	--if (player.gmLevel >= 90) then
		--player:freeAsync()
		test_check.popup(npc, player)
	--end
end),

popup = function(npc, player)
	local t = {graphic = convertGraphic(854, "monster"), color = 126}
	local menuOptions = {}
	local slot
	
	if (player.gmLevel >= 90) then
	table.insert(menuOptions, "Set Spawn Mob 1")
	table.insert(menuOptions, "Set Spawn Mob 2")
	table.insert(menuOptions, "Set Spawn Mob 3")
	table.insert(menuOptions, "Set Spawn Mob 4")
	table.insert(menuOptions, "Set Spawn Mob 5")
	table.insert(menuOptions, "Set Timer")
	end
	table.insert(menuOptions, "Respawn Room")
	


	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	player.lastClick = npc.ID
		local choice = player:menuString("Which spawn settings would you like to change?", menuOptions)
		if(choice == "Set Spawn Mob 1") then
			slot = 1

			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			if (what_mobXend > npc.xmax) then
			what_mobXend = npc.xmax
			end

			if (what_mobYend > npc.ymax) then
			what_mobYend = npc.ymax
			end

			if (what_mobXstart > npc.xmax or what_mobXstart == 0) then
			what_mobXstart = 1
			end

			if (what_mobYstart > npc.ymax or what_mobYstart == 0) then
			what_mobYstart = 1
			end

			npc.mapRegistry["what" .. slot .. "_mobID"] = what_mobID
			npc.mapRegistry["what" .. slot .. "_mobAMT"] = what_mobAMT
			npc.mapRegistry["what" .. slot .. "_mobXstart"] = what_mobXstart
			npc.mapRegistry["what" .. slot .. "_mobYstart"] = what_mobYstart
			npc.mapRegistry["what" .. slot .. "_mobXend"] = what_mobXend
			npc.mapRegistry["what" .. slot .. "_mobYend"] = what_mobYend

			if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobAMT"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXend"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYend"] ~= nil) then
				--npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobAMT"], npc.m)
				player:sendMinitext("Spawn entry registered!")
			else
				player:sendMinitext("Spawn entry failed!")
				npc.mapRegistry["what" .. slot .. "_mobID"] = 0
			end

		elseif(choice == "Set Spawn Mob 2") then
			slot = 2

			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			if (what_mobXend > npc.xmax) then
			what_mobXend = npc.xmax
			end

			if (what_mobYend > npc.ymax) then
			what_mobYend = npc.ymax
			end

			if (what_mobXstart > npc.xmax or what_mobXstart == 0) then
			what_mobXstart = 1
			end

			if (what_mobYstart > npc.ymax or what_mobYstart == 0) then
			what_mobYstart = 1
			end

			npc.mapRegistry["what" .. slot .. "_mobID"] = what_mobID
			npc.mapRegistry["what" .. slot .. "_mobAMT"] = what_mobAMT
			npc.mapRegistry["what" .. slot .. "_mobXstart"] = what_mobXstart
			npc.mapRegistry["what" .. slot .. "_mobYstart"] = what_mobYstart
			npc.mapRegistry["what" .. slot .. "_mobXend"] = what_mobXend
			npc.mapRegistry["what" .. slot .. "_mobYend"] = what_mobYend

			if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobAMT"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXend"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYend"] ~= nil) then
				--npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobAMT"], npc.m)
				player:sendMinitext("Spawn entry registered!")
			else
				player:sendMinitext("Spawn entry failed!")
				npc.mapRegistry["what" .. slot .. "_mobID"] = 0
			end
		elseif(choice == "Set Spawn Mob 3") then
			slot = 3
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			if (what_mobXend > npc.xmax) then
			what_mobXend = npc.xmax
			end

			if (what_mobYend > npc.ymax) then
			what_mobYend = npc.ymax
			end

			if (what_mobXstart > npc.xmax or what_mobXstart == 0) then
			what_mobXstart = 1
			end

			if (what_mobYstart > npc.ymax or what_mobYstart == 0) then
			what_mobYstart = 1
			end

			npc.mapRegistry["what" .. slot .. "_mobID"] = what_mobID
			npc.mapRegistry["what" .. slot .. "_mobAMT"] = what_mobAMT
			npc.mapRegistry["what" .. slot .. "_mobXstart"] = what_mobXstart
			npc.mapRegistry["what" .. slot .. "_mobYstart"] = what_mobYstart
			npc.mapRegistry["what" .. slot .. "_mobXend"] = what_mobXend
			npc.mapRegistry["what" .. slot .. "_mobYend"] = what_mobYend

			if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobAMT"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXend"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYend"] ~= nil) then
				--npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobAMT"], npc.m)
				player:sendMinitext("Spawn entry registered!")
			else
				player:sendMinitext("Spawn entry failed!")
				npc.mapRegistry["what" .. slot .. "_mobID"] = 0
			end
		elseif(choice == "Set Spawn Mob 4") then
			slot = 4
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			if (what_mobXend > npc.xmax) then
			what_mobXend = npc.xmax
			end

			if (what_mobYend > npc.ymax) then
			what_mobYend = npc.ymax
			end

			if (what_mobXstart > npc.xmax or what_mobXstart == 0) then
			what_mobXstart = 1
			end

			if (what_mobYstart > npc.ymax or what_mobYstart == 0) then
			what_mobYstart = 1
			end

			npc.mapRegistry["what" .. slot .. "_mobID"] = what_mobID
			npc.mapRegistry["what" .. slot .. "_mobAMT"] = what_mobAMT
			npc.mapRegistry["what" .. slot .. "_mobXstart"] = what_mobXstart
			npc.mapRegistry["what" .. slot .. "_mobYstart"] = what_mobYstart
			npc.mapRegistry["what" .. slot .. "_mobXend"] = what_mobXend
			npc.mapRegistry["what" .. slot .. "_mobYend"] = what_mobYend

			if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobAMT"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXend"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYend"] ~= nil) then
				--npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobAMT"], npc.m)
				player:sendMinitext("Spawn entry registered!")
			else
				player:sendMinitext("Spawn entry failed!")
				npc.mapRegistry["what" .. slot .. "_mobID"] = 0
			end
		elseif(choice == "Set Spawn Mob 5") then
			slot = 5
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			if (what_mobXend > npc.xmax) then
			what_mobXend = npc.xmax
			end

			if (what_mobYend > npc.ymax) then
			what_mobYend = npc.ymax
			end

			if (what_mobXstart > npc.xmax or what_mobXstart == 0) then
			what_mobXstart = 1
			end

			if (what_mobYstart > npc.ymax or what_mobYstart == 0) then
			what_mobYstart = 1
			end

			npc.mapRegistry["what" .. slot .. "_mobID"] = what_mobID
			npc.mapRegistry["what" .. slot .. "_mobAMT"] = what_mobAMT
			npc.mapRegistry["what" .. slot .. "_mobXstart"] = what_mobXstart
			npc.mapRegistry["what" .. slot .. "_mobYstart"] = what_mobYstart
			npc.mapRegistry["what" .. slot .. "_mobXend"] = what_mobXend
			npc.mapRegistry["what" .. slot .. "_mobYend"] = what_mobYend

			if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobAMT"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYstart"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobXend"] ~= nil and npc.mapRegistry["what" .. slot .. "_mobYend"] ~= nil) then
				--npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobAMT"], npc.m)
				player:sendMinitext("Spawn entry registered!")
			else
				player:sendMinitext("Spawn entry failed!")
				npc.mapRegistry["what" .. slot .. "_mobID"] = 0
			end
		elseif(choice == "Respawn Room") then
			local mobBlocks = npc:getObjectsInSameMap(BL_MOB)
			local mobCheck
			local pcCheck
			local spawned_mob
			local spawnAMOUNT
			local x
			local y

			slot = 0
			repeat
				slot = slot + 1
				spawned_mob = 0
					if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
						if (#mobBlocks > 0) then
							for i = 1, #mobBlocks do
								if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
									spawned_mob = spawned_mob + 1
								end
							end
						end

					end

					if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
						spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
						for i = 1, spawnAMOUNT do
							--local spawnMob = 123 + math.random(0, 3)
							--npc:talk(0,"Beep "..spawnAMOUNT)
							repeat
								x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
								y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
								mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
								pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
							until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
							
							npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

						end
					end
			until (slot == 5)
		elseif(choice == "Set Timer") then
		local spawn_timer = tonumber(player:input("What will the spawn timer be? (in minutes)"))
		npc.actionTime = (spawn_timer * 1000) * 60
		npc.mapRegistry["SpawnNPC_timer"] = (spawn_timer * 1000) * 60
		player:sendMinitext("NPC timer has changed to "..spawn_timer.." minutes.")
		end
end,

action = function(npc)

if (npc.mapRegistry["SpawnNPC_timer"] ~= nil) then
	npc.actionTime = npc.mapRegistry["SpawnNPC_timer"]
end

local mobCheck
local pcCheck
local spawnAMOUNT
local x
local y
local slot
local mobBlocks = npc:getObjectsInSameMap(BL_MOB)
--local mobBlocks
local spawned_mob

	slot = 1
	spawned_mob = 0
	if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
					spawned_mob = spawned_mob + 1
				end
			end
		end

	end

	if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
		spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
		for i = 1, spawnAMOUNT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
			repeat
				x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
				y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
				mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
				pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
			until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
			
			npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

		end
	end

	slot = 2
	spawned_mob = 0
	if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
					spawned_mob = spawned_mob + 1
				end
			end
		end

	end

	if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
		spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
		for i = 1, spawnAMOUNT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
			repeat
				x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
				y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
				mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
				pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
			until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
			
			npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

		end
	end

	slot = 3
	spawned_mob = 0
	if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
					spawned_mob = spawned_mob + 1
				end
			end
		end

	end

	if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
		spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
		for i = 1, spawnAMOUNT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
			repeat
				x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
				y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
				mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
				pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
			until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
			
			npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

		end
	end

	slot = 4
	spawned_mob = 0
	if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
					spawned_mob = spawned_mob + 1
				end
			end
		end

	end

	if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
		spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
		for i = 1, spawnAMOUNT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
			repeat
				x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
				y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
				mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
				pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
			until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
			
			npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

		end
	end

	slot = 5
	spawned_mob = 0
	if (npc.mapRegistry["what" .. slot .. "_mobID"] ~= nil) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].mobID == npc.mapRegistry["what" .. slot .. "_mobID"]) then
					spawned_mob = spawned_mob + 1
				end
			end
		end

	end

	if (spawned_mob < npc.mapRegistry["what" .. slot .. "_mobAMT"]) then
		spawnAMOUNT = (npc.mapRegistry["what" .. slot .. "_mobAMT"] - spawned_mob)
		for i = 1, spawnAMOUNT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
			repeat
				x = math.random(npc.mapRegistry["what" .. slot .. "_mobXstart"], npc.mapRegistry["what" .. slot .. "_mobXend"])
				y = math.random(npc.mapRegistry["what" .. slot .. "_mobYstart"], npc.mapRegistry["what" .. slot .. "_mobYend"])
				mobCheck = npc:getObjectsInCell(npc.m, x, y, BL_MOB)
				pcCheck = npc:getObjectsInCell(npc.m, x, y, BL_PC)
			until (getPass(npc.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0)
			
			npc:spawn(npc.mapRegistry["what" .. slot .. "_mobID"], x, y, 1, npc.m)

		end
	end

end
}