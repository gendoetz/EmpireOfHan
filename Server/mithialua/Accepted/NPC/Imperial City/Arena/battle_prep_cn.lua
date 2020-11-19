battle_prep_cn = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	--local players = npc:getObjectsInSameMap(BL_PC)
	local options = {}
	local choice = ""
	local carnage_prep = player:getEquippedItem(EQ_COAT)
	local coat_equip = false
	local inv_coat = false
	
	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	if (carnage_prep ~= nil) then
		if (carnage_prep.id ~= nil) then
			if (carnage_prep.id > 200 and carnage_prep.id < 234) then
				coat_equip = true
			end
		end
	end


	for i = 201, 233 do
		if (player:hasItem(i, 1) == true) then
			inv_coat = true
		end
	end
	

	if (inv_coat == false and coat_equip == false) then
	player:dialogSeq({npcGraphics, "Here take this battle coat. You must wear it at all times during battle or you will be forced back to the barracks."}, 1)
		if (player.armorColor == 63) then
			if (player.baseClass == 1) then
				if (player.sex == 0) then --MALE
					player:addItem(209, 1)
				else
					player:addItem(210, 1)
				end
			elseif (player.baseClass == 2) then
				if (player.sex == 0) then --MALE
					player:addItem(211, 1)
				else
					player:addItem(212, 1)
				end
			elseif (player.baseClass == 3) then
				if (player.sex == 0) then --MALE
					player:addItem(213, 1)
				else
					player:addItem(214, 1)
				end
			elseif (player.baseClass == 4) then
				if (player.sex == 0) then --MALE
					player:addItem(215, 1)
				else
					player:addItem(216, 1)
				end
			end
		elseif (player.armorColor == 65) then
			if (player.baseClass == 1) then
				if (player.sex == 0) then --MALE
					player:addItem(218, 1)
				else
					player:addItem(219, 1)
				end
			elseif (player.baseClass == 2) then
				if (player.sex == 0) then --MALE
					player:addItem(220, 1)
				else
					player:addItem(221, 1)
				end
			elseif (player.baseClass == 3) then
				if (player.sex == 0) then --MALE
					player:addItem(222, 1)
				else
					player:addItem(223, 1)
				end
			elseif (player.baseClass == 4) then
				if (player.sex == 0) then --MALE
					player:addItem(224, 1)
				else
					player:addItem(225, 1)
				end
			end
		elseif (player.armorColor == 60) then
			if (player.baseClass == 1) then
				if (player.sex == 0) then --MALE
					player:addItem(201, 1)
				else
					player:addItem(202, 1)
				end
			elseif (player.baseClass == 2) then
				if (player.sex == 0) then --MALE
					player:addItem(203, 1)
				else
					player:addItem(204, 1)
				end
			elseif (player.baseClass == 3) then
				if (player.sex == 0) then --MALE
					player:addItem(205, 1)
				else
					player:addItem(206, 1)
				end
			elseif (player.baseClass == 4) then
				if (player.sex == 0) then --MALE
					player:addItem(207, 1)
				else
					player:addItem(208, 1)
				end
			end
		elseif (player.armorColor == 61) then
			if (player.baseClass == 1) then
				if (player.sex == 0) then --MALE
					player:addItem(226, 1)
				else
					player:addItem(227, 1)
				end
			elseif (player.baseClass == 2) then
				if (player.sex == 0) then --MALE
					player:addItem(228, 1)
				else
					player:addItem(229, 1)
				end
			elseif (player.baseClass == 3) then
				if (player.sex == 0) then --MALE
					player:addItem(230, 1)
				else
					player:addItem(231, 1)
				end
			elseif (player.baseClass == 4) then
				if (player.sex == 0) then --MALE
					player:addItem(232, 1)
				else
					player:addItem(233, 1)
				end
			end
		end
	end

if(NPC(131).registry["arena"] == 0) then
	player:dialogSeq({npcGraphics, "Looks like you missed the match, I'll send you back to the hall so you can exit."}, 1)
	local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
			
			if (player.armorColor == 63) then
				player:warp(7005, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (player.armorColor == 60) then
				player:warp(7005, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (player.armorColor == 61) then
				player:warp(7005, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (player.armorColor == 65) then
				player:warp(7005, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			elseif (player.registry["arenaHost"] == 250 or player.gmLevel >= 50) then
				player:warp(7005, math.random(19, 21), math.random(21, 23))
			end
end


	if (coat_equip == false) then
	player:dialogSeq({npcGraphics, "Put on your battle coat and I will allow you to enter into battle."}, 1)
	elseif (coat_equip == true) then
		local map = NPC(131).registry["arena"]
			if (player.armorColor == 60) then
				player:warp(map, math.random(8), math.random(26, 33))
			elseif (player.armorColor == 61) then
				player:warp(map, math.random(22, 29), math.random(8))
			elseif (player.armorColor == 63) then
				player:warp(map, math.random(8), math.random(8))
			elseif (player.armorColor == 65) then
				player:warp(map, math.random(22, 29), math.random(26, 33))
			elseif (player.registry["carnagehost"] >= 1 or player.gmLevel >= 50) then
				player:warp(map, math.random(14, 17), math.random(16, 19))
			end
			player:dialogSeq({npcGraphics, "Best of luck in your match!"}, 0)
	end
end)
}