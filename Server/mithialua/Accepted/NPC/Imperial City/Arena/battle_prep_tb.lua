battle_prep_tb = {
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
		end
	end


	if (coat_equip == false) then
	player:dialogSeq({npcGraphics, "Put on your battle coat and I will allow you to enter into battle."}, 1)
	elseif (coat_equip == true) then
			if (player.armorColor == 63) then
				player:warp(7100, math.random(43, 55), math.random(9, 19))
			elseif (player.armorColor == 65) then
				player:warp(7100, math.random(4, 16), math.random(9, 19))
			end
			player:dialogSeq({npcGraphics, "Best of luck in your match!"}, 0)
	end
end)
}