exit_arena_games = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = { }
	table.insert(opts,"Leave")

	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0
	local menuOption=player:menuString("Hello. How can I help you?",opts)
	if(menuOption=="Leave") then
		player:dialogSeq({npcGraphics, "It looks like you are on your way out, let me help you to exit."}, 1)
		local carnage_prep = player:getEquippedItem(EQ_COAT)
		if (carnage_prep ~= nil) then
			if (carnage_prep.id ~= nil) then
				if (carnage_prep.id > 200 and carnage_prep.id < 234) then
					player:dialogSeq({npcGraphics, "Please remove your battle coat."}, 1)
					return
				end
			end
		end
		for i = 201, 233 do
			if (player:hasItem(i, 1) == true) then
				player:removeItem(i, 1)
			end
		end
		player.armorColor = player.registry["arenaDyeSave"]
		player.registry["arenaDyeSave"] = 0
		player:warp(7000, math.random(7, 16), math.random(13, 14))
		player:dialogSeq({npcGraphics, "Thanks for participating!"}, 0)
	end
end),
}