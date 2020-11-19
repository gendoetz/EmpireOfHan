arena_winprize = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}

	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	local carnage_prep = player:getEquippedItem(EQ_COAT)
	if (carnage_prep ~= nil) then
		if (carnage_prep.id ~= nil) then
			if (carnage_prep.id > 208 and carnage_prep.id < 234) then
				player:dialogSeq({npcGraphics, "Please remove your battle coat."}, 1)
				return
			end
		end
	end
	for i = 209, 233 do
		if (player:hasItem(i, 1) == true) then
			player:removeItem(i, 1)
		end
	end

	if (player.registry["event_win_type"] == 1) then
	local wins = player.registry["carnageWins"] + 1

	
	player:dialogSeq({npcGraphics, "I see you've won the Carnage. Congratulations on your victory!!"}, 1)
	player.registry["carnageWins"] = wins
	player.armorColor = player.registry["arenaDyeSave"]
	player.registry["arenaDyeSave"] = 0
	player.registry["event_win_type"] = 0
	player:warp(7000, math.random(9, 15), math.random(9, 11))
	player:removeLegendbyName("carnageWins")
	if (wins == 1) then
		player:addLegend("Has claimed victory in "..wins.." Carnage.", "carnageWins", 1, 16)
	else
		player:addLegend("Has claimed victory in "..wins.." Carnages.", "carnageWins", 1, 16)
	end
	end

	if (player.registry["event_win_type"] == 3) then
	local wins = player.registry["towerbattleWins"] + 1

	
	player:dialogSeq({npcGraphics, "I see you've won the Tower Battle. Congratulations on your victory!!"}, 1)
	player.registry["towerbattleWins"] = wins
	player.armorColor = player.registry["arenaDyeSave"]
	player.registry["arenaDyeSave"] = 0
	player.registry["event_win_type"] = 0
	player:warp(7000, math.random(9, 15), math.random(9, 11))
	player:removeLegendbyName("towerbattleWins")
	if (wins == 1) then
		player:addLegend("Has claimed victory in "..wins.." Tower Battle.", "towerbattleWins", 1, 16)
	else
		player:addLegend("Has claimed victory in "..wins.." Tower Battles.", "towerbattleWins", 1, 16)
	end
	end

	if (player.registry["event_win_type"] == 2) then
	local wins = player.registry["elixirWins"] + 1

	
	player:dialogSeq({npcGraphics, "I see you've won the Elixir War. Congratulations on your victory!!"}, 1)
	player.registry["elixirWins"] = wins
	player.armorColor = player.registry["arenaDyeSave"]
	player.registry["arenaDyeSave"] = 0
	player.registry["event_win_type"] = 0
	player:warp(7000, math.random(9, 15), math.random(9, 11))
	player:removeLegendbyName("elixirWins")
	if (wins == 1) then
		player:addLegend("Has claimed victory in "..wins.." Elixir War.", "elixirWins", 1, 16)
	else
		player:addLegend("Has claimed victory in "..wins.." Elixir Wars.", "elixirWins", 1, 16)
	end
	end
end)
}