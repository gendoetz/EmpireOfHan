skypalace_floor = {
click = async(function(player, npc)

	if (player.gmLevel >= 90) then
		npc:talk(0,"Test")
	end

	local sky_maps = {252, 253, 254, 255, 256, 257, 258, 259, 260, 261}
	for i = 1, #sky_maps do
		npc:warp(sky_maps[i], 0, 0)
		local xmax = 40
		local ymax = 40
		for x=0, xmax do
			for y=0, ymax do
					local tileCheck = getTile(sky_maps[i], x, y)
					if (tileCheck == 37053) then
						setTile(sky_maps[i], x, y, 27633)
					end
			end
		end

	end
	npc:warp(5000, 10, 6)
end),

action = function(npc)
	--npc:talk(0,"Test")

	local sky_maps = {252, 253, 254, 255, 256, 257, 258, 259, 260, 261}

	for i = 1, #sky_maps do

			local playerBlocks = npc:getObjectsInMap(sky_maps[i], BL_PC)
			for i = 1, #playerBlocks do
				if(not playerBlocks[i]:hasDuration("pillars_blessing")) then
					local tileCheck = getTile(playerBlocks[i].m, playerBlocks[i].x, playerBlocks[i].y)
					if (tileCheck == 27633) then
						playerBlocks[i].registry["skyTile"] = playerBlocks[i].registry["skyTile"] + 1
						playerBlocks[i]:sendAnimation(132, 0)
						if (playerBlocks[i].registry["skyTile"] >= 6) then
							setTile(playerBlocks[i].m, playerBlocks[i].x, playerBlocks[i].y, 37053)
							if (playerBlocks[i].state ~= 1) then
								playerBlocks[i]:sendAnimationXY(103, playerBlocks[i].x, playerBlocks[i].y, 0)
								playerBlocks[i]:playSound(49)
								playerBlocks[i]:warp(262, playerBlocks[i].x, playerBlocks[i].y)
								playerBlocks[i]:die()
								playerBlocks[i]:updateState()
							else
								playerBlocks[i]:sendAnimationXY(103, playerBlocks[i].x, playerBlocks[i].y, 0)
								playerBlocks[i]:playSound(49)
								playerBlocks[i]:warp(262, playerBlocks[i].x, playerBlocks[i].y)

							end
							playerBlocks[i]:sendAnimationXY(378, playerBlocks[i].x, playerBlocks[i].y)
							playerBlocks[i]:playSound(92)
							playerBlocks[i].dialogType = 0
							playerBlocks[i]:dialogSeq({"You have fallen from the sky palace."}, 1)
							playerBlocks[i].registry["skyTile"] = 1
						end
					else
						playerBlocks[i].registry["skyTile"] = 1
					end
				end
			end
	end
end
}

skypalace_floor_resetter = {
click = async(function(player, npc)

	if (player.gmLevel >= 90) then
		npc:talk(0,"Test")
	end
	--npc:warp(5000, 10, 6)
end),

action = function(npc)
	local sky_maps = {252, 253, 254, 255, 256, 257, 258, 259, 260, 261}
	for i = 1, #sky_maps do
		--npc:warp(sky_maps[i], 0, 0)
		local xmax = 40
		local ymax = 40
		for x=0, xmax do
			for y=0, ymax do
					local tileCheck = getTile(sky_maps[i], x, y)
					if (tileCheck == 37053) then
						setTile(sky_maps[i], x, y, 27633)
					end
			end
		end
	end
end
}