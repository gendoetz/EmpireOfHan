elixir_war_ent = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local options = {"Yes", "No"}
	local choice = ""
	
	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	if(player.class==0) then
		player:dialogSeq({npcGraphics, "You may not participate in this event as a peasant."}, 1)
		return
	end

	choice = player:menuString("Would you like to participate in the elixir war? The fee is 1000 coins.", options)
	if (choice == "Yes") then
		if (player:removeGold(1000) == true) then
			local participations = player.registry["elixirParticipations"] + 1
			
			player:warp(7006, math.random(2, 26), math.random(25, 28))

			player:removeLegendbyName("elixirParticipations")
			
			if (participations == 1) then
				player:addLegend("Participated in "..participations.." Elixir War.", "elixirParticipations", 1, 16)
			else
				player:addLegend("Participated in "..participations.." Elixir Wars.", "elixirParticipations", 1, 16)
			end
			
			player.registry["arenaDyeSave"] = player.armorColor
			player.armorColor = 0
			player.registry["inCarnage"] = 1
			player.registry["elixirParticipations"] = participations
			player:flushDuration(1)
			--player:flushAether(1)
			player.state = 0
			player.health = player.maxHealth
			player.magic = player.maxMagic
			player:sendStatus()
			player:updateState()
		else
			player:dialogSeq({npcGraphics, "Please come back when you have the money."}, 1)
			return
		end
	else
		player:dialogSeq({npcGraphics, "Very well then."}, 1)
	end
end),
}