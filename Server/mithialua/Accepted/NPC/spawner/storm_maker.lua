storm_maker = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	local storm_maps = {15, 10, 77, 37, 74}
	local sums = 0

for i = 1, #storm_maps do
					local get_storm2 = npc:getObjectsInMap(storm_maps[i], BL_NPC)
					if (#get_storm2 ~= 0) then
					for i = 1, #get_storm2 do
						if (get_storm2[i].yname == "storm_generator_rain") then
							get_storm2[i]:delete()
						elseif (get_storm2[i].yname == "storm_generator") then
							get_storm2[i]:delete()
						end
					end
				end
end

	--[[for i = 1, #storm_maps do
		--Check for Players
		local players = npc:getObjectsInMap(storm_maps[i], BL_PC)
			if (#players >= 1) then
				local get_storm = npc:getObjectsInMap(storm_maps[i], BL_NPC)
				if (#get_storm ~= 0) then
					for i = 1, #get_storm do
						if (get_storm[i].yname == "storm_generator") then
							sums = sums + 1
						end
					end
					if(sums == 0) then
						npc:addNPC("storm_generator", storm_maps[i], 1, 1, 500, 900000)
						--local npcget = npc:getObjectsInCell(ritual_maps[i], randx, randy, BL_NPC)[1]
						--npcget.subType = 0
						--npcget.look = 1
					end
				end
			end
	end

	for i = 1, #storm_maps do
		--Check for Players
		local players = npc:getObjectsInMap(storm_maps[i], BL_PC)
			if (#players >= 1) then
				local get_storm = npc:getObjectsInMap(storm_maps[i], BL_NPC)
				if (#get_storm ~= 0) then
					for i = 1, #get_storm do
						if (get_storm[i].yname == "storm_generator_rain") then
							sums = sums + 1
						end
					end
					if(sums == 0) then
						npc:addNPC("storm_generator_rain", storm_maps[i], 1, 1, 500, 900000)
						--local npcget = npc:getObjectsInCell(ritual_maps[i], randx, randy, BL_NPC)[1]
						--npcget.subType = 0
						--npcget.look = 1
					end
				end
			end
	end--]]

	player:dialogSeq({t, "This monitor just made a storm."}, 1)
end),

action = function(npc)

--[[npc.actionTime = math.random(900000, 1350000)

	local storm_maps = {15, 10, 77, 37, 74}
	local sums = 0

	for i = 1, #storm_maps do
		--Check for Players
		local players = npc:getObjectsInMap(storm_maps[i], BL_PC)
			if (#players >= 1) then
				local get_storm = npc:getObjectsInMap(storm_maps[i], BL_NPC)
				if (#get_storm ~= 0) then
					for i = 1, #get_storm do
						if (get_storm[i].yname == "storm_generator") then
							sums = sums + 1
						end
					end
					if(sums == 0) then
						npc:addNPC("storm_generator", storm_maps[i], 1, 1, 500, 900000)
						--local npcget = npc:getObjectsInCell(ritual_maps[i], randx, randy, BL_NPC)[1]
						--npcget.subType = 0
						--npcget.look = 1
					end
				end
			end
	end

	for i = 1, #storm_maps do
		--Check for Players
		local players = npc:getObjectsInMap(storm_maps[i], BL_PC)
			if (#players >= 1) then
				local get_storm = npc:getObjectsInMap(storm_maps[i], BL_NPC)
				if (#get_storm ~= 0) then
					for i = 1, #get_storm do
						if (get_storm[i].yname == "storm_generator_rain") then
							sums = sums + 1
						end
					end
					if(sums == 0) then
						npc:addNPC("storm_generator_rain", storm_maps[i], 1, 1, 500, 900000)
						--local npcget = npc:getObjectsInCell(ritual_maps[i], randx, randy, BL_NPC)[1]
						--npcget.subType = 0
						--npcget.look = 1
					end
				end
			end
	end
--]]
end,
}

storm_generator = {
action = function(npc)

	local players = npc:getObjectsInMap(npc.m, BL_PC)
	local sounds = {55, 57, 58}
	npc.actionTime = math.random(500, 15000)

	if (#players >= 1) then

		local strikeTarget = math.random(#players)
		local randSound = math.random(#sounds)
			npc:sendAnimationXY(134, players[strikeTarget].x, players[strikeTarget].y, 0)
			players[strikeTarget]:playSound(sounds[randSound])
	end

end,

endAction = function(npc)
	npc:delete()
end,
}

storm_generator_rain = {
action = function(npc)

	local players = npc:getObjectsInMap(npc.m, BL_PC)
	if (#players >= 1) then

		for x = 0, npc.xmax do
			for y = 0, npc.ymax do
					if (x % 3 == 0 and y % 3 == 0) then
						npc:sendAnimationXY(407, x, y, 2)
					end
			end
		end
	end

end,

endAction = function(npc)
	npc:delete()
end,
}