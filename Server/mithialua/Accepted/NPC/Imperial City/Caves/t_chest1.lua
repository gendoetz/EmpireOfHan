t_chest1 = {
unlocked = async(function(player, npc)
local chestwarp = math.random(0, 3)

	if (chestwarp == 0) then
		npc:warp(33, 33, 41)
	elseif (chestwarp == 1) then
		npc:warp(34, 3, 3)
	elseif (chestwarp == 2) then
		npc:warp(35, 20, 3)
	elseif (chestwarp == 3) then
		npc:warp(36, 35, 3)
	end

end),


action = function(npc)
	local hiddenkeys = npc:getObjectsInSameMap(BL_NPC)
	local countkeys = 0

		for i = 1, #hiddenkeys do
			if (hiddenkeys[i].yname == "t_keypopup1") then
			countkeys = (countkeys + 1)
			end
		end

	if (countkeys <= 3) then
		repeat

		local hiddenkeys = npc:getObjectsInSameMap(BL_NPC)
		local countkeys = 0

		for i = 1, #hiddenkeys do
			if (hiddenkeys[i].yname == "t_keypopup1") then
			countkeys = (countkeys + 1)
			end
		end

			local newX = math.random(0, npc.xmax)
			local newY = math.random(0, npc.xmax)
			local passCheck = getPass(npc.m, newX, newY)
			local tileCheck = getTile(npc.m, newX, newY)
			if (passCheck == 0 and (tileCheck == 36302 or tileCheck == 36301)) then
				npc:addNPC("t_keypopup1", npc.m, newX, newY, 0, 80000, 0)
			end
		until (countkeys == 4)
	end
--npc:warp(33, 33, 41)

end
}

t_keypopup1 = {
click = function(block, npc)
	if (block.blType == BL_PC) then
		if (block.state ~= 1) then
		block:playSound(703)
		block:sendAnimation(16, 0)
		npc:dropItemXY(48, 1, npc.m, npc.x, npc.y, 0)
		npc:delete()
		block:sendMinitext("You kick up some dirt and notice a shiny object.")
		end
	end
end
}

t_key1 = {
	use = async(function(player)
	local chest = {graphic = convertGraphic(809, "monster"), color = 2}
	local facingchest = getTargetFacing(player, BL_NPC)

	player.npcGraphic = chest.graphic
	player.npcColor = chest.color
	player.dialogType = 0

		if (facingchest.id ~= nil) then
			if (facingchest.id == 42) then
				--player:sendMinitext("You kick up some dirt and notice a shiny object.")
				player:removeItem("t_key1",1)
				local randchestitem = math.random(0, 3)
				if (randchestitem == 0) then
					player:addItem("warriorhand1", 1)
				elseif (randchestitem == 1) then
					player:addItem("roguehand1", 1)
				elseif (randchestitem == 2) then
					player:addItem("magehand1", 1)
				elseif (randchestitem == 3) then
					player:addItem("poethand1", 1)
				end

				local chestwarp = math.random(0, 3)

					if (chestwarp == 0) then
						facingchest:warp(33, 34, 41)
					elseif (chestwarp == 1) then
						facingchest:warp(34, 3, 3)
					elseif (chestwarp == 2) then
						facingchest:warp(35, 20, 3)
					elseif (chestwarp == 3) then
						facingchest:warp(36, 35, 3)
					end

				player:dialog("You unlock the chest and find an item hidden inside.", chest)
			end
		end

	end)
}