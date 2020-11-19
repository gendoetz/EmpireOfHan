ogre_chest1 = {
unlocked = async(function(player, npc)
	local chest = {graphic = convertGraphic(809, "monster"), color = 13}
	player.npcGraphic = chest.graphic
	player.npcColor = chest.color
	player.dialogType = 0

	player:dialog("You could probably open this chest if you used the correct key on it...", chest)

end)
}

ogre_key1 = {
	use = async(function(player)
	local chest = {graphic = convertGraphic(809, "monster"), color = 13}
	local facingchest = getTargetFacing(player, BL_NPC)
	local goldvsitem = math.random(1, 100)

	player.npcGraphic = chest.graphic
	player.npcColor = chest.color
	player.dialogType = 0

		if (facingchest.id ~= nil) then
			if (facingchest.id == 101) then
				player:removeItem("ogre_key1",1)

					local chestwarp = math.random(0, 5)

					if (chestwarp == 0) then
						facingchest:warp(133, 4, 33)
					elseif (chestwarp == 1) then
						facingchest:warp(134, 3, 2)
					elseif (chestwarp == 2) then
						facingchest:warp(135, 17, 5)
					elseif (chestwarp == 3) then
						facingchest:warp(135, 24, 47)
					elseif (chestwarp == 4) then
						facingchest:warp(136, 4, 2)
					elseif (chestwarp == 5) then
						facingchest:warp(137, 24, 43)
					end

				if (goldvsitem <= 20) then
					local randchestitem = math.random(0, 3)
					if (randchestitem == 0) then
						player:addItem("war_sub1", 1)
					elseif (randchestitem == 1) then
						player:addItem("rog_sub1", 1)
					elseif (randchestitem == 2) then
						player:addItem("mag_sub1", 1)
					elseif (randchestitem == 3) then
						player:addItem("poe_sub1", 1)
					end
					player:dialog("You unlock the chest and find an item hidden inside!", chest)
				else
					player:addGold(1000)
					player:dialog("You unlock the chest and find only a bit of gold...", chest)
				end


			end
		end

	end)
}