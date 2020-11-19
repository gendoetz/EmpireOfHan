gm_spawn_design = {
cast = function(player)
	
	player:freeAsync()
	gm_spawn_design.popup(player)

end,

popup = async(function(player)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	local menuOptions = {"Design Map Spawn", "Design Radius Spawn", "", "", "Set Spawns Perminent"}

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0


		local choice = player:menuString3("Which option?", menuOptions)

		if(choice == "Design Map Spawn") then
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_mobXstart = tonumber(player:input("X start?"))
			local what_mobYstart = tonumber(player:input("Y Start?"))
			local what_mobXend = tonumber(player:input("X end?"))
			local what_mobYend = tonumber(player:input("Y end?"))

			local mobCheck
			local pcCheck
			local repCounter = 0

			if (what_mobXend > player.xmax) then
			what_mobXend = player.xmax
			end

			if (what_mobYend > player.ymax) then
			what_mobYend = player.ymax
			end

			if (what_mobAMT <= 0) then
				what_mobAMT = 1
			end

			for i = 1, what_mobAMT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
				repeat
					repCounter = repCounter + 1
					x = math.random(what_mobXstart, what_mobXend)
					y = math.random(what_mobYstart, what_mobYend)
					mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
					pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)

				until ((getPass(player.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) or repCounter >= 10)
				
				if (repCounter >= 10) then
					player:sendMinitext("Attempted spawning of mob over 10 times, aborted.")
					repCounter = 0
				else
					player:spawn(what_mobID, x, y, 1, player.m)
					local mob_para = player:getObjectsInCell(player.m, x, y, BL_MOB)
					mob_para[1].paralyzed = true
					mob_para[1]:sendAnimation(74)
				end

			end
		elseif(choice == "Design Radius Spawn") then
			local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
			local what_mobAMT = tonumber(player:input("How many monsters?"))
			local what_radius = tonumber(player:input("How far around you?"))

			local mobCheck
			local pcCheck
			local repCounter = 0

			local what_mobXstart = player.x - what_radius
			if (what_mobXstart < 0) then
				what_mobXstart = 0
			end
			local what_mobYstart = player.y - what_radius
			if (what_mobYstart < 0) then
				what_mobYstart = 0
			end
			local what_mobXend = player.x + what_radius
			if (what_mobXend > player.xmax) then
				what_mobXend = player.xmax
			end
			local what_mobYend = player.y + what_radius
			if (what_mobYend > player.ymax) then
				what_mobYend = player.ymax
			end

			for i = 1, what_mobAMT do
			--local spawnMob = 123 + math.random(0, 3)
			--npc:talk(0,"Beep "..spawnAMOUNT)
				repeat
					repCounter = repCounter + 1
					x = math.random(what_mobXstart, what_mobXend)
					y = math.random(what_mobYstart, what_mobYend)
					mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
					pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)

				until ((getPass(player.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) or repCounter >= 10)
				
				if (repCounter >= 10) then
					player:sendMinitext("Attempted spawning of mob over 10 times, aborted.")
					repCounter = 0
				else
					player:spawn(what_mobID, x, y, 1, player.m)
					local mob_para = player:getObjectsInCell(player.m, x, y, BL_MOB)
					mob_para[1].paralyzed = true
					mob_para[1]:sendAnimation(74)
				end

			end

		elseif(choice == "Set Spawns Perminent") then
			local what_mobID = tonumber(player:input("What monster ID will you set perminent?"))
			local mobPerm = player:getObjectsInSameMap(BL_MOB)

			if (#mobPerm >= 1) then
				for i = 1, #mobPerm do
					if (mobPerm[i].mobID == what_mobID) then
						mobPerm[i]:setPermSpawn(mobPerm[i].mobID, 25, 25, 0)
						mobPerm[i]:sendAnimation(106)
					end
				end
			end

		end
end),
}