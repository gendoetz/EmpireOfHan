carnage_ent = {
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

	choice = player:menuString("Would you like to participate in the Carnage? The fee is 1000 coins.", options)
	if (choice == "Yes") then
		if (player:removeGold(1000) == true) then
			local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}
			local matChoice = math.random(4)
			
			if (matChoice == 1) then
				player:warp(7005, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
			elseif (matChoice == 2) then
				player:warp(7005, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
			elseif (matChoice == 3) then
				player:warp(7005, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
			elseif (matChoice == 4) then
				player:warp(7005, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
			end
			local participations = player.registry["carnageParticipations"] + 1

			player:removeLegendbyName("carnageParticipations")
			
			if (participations == 1) then
				player:addLegend("Participated in "..participations.." Carnage.", "carnageParticipations", 1, 16)
			else
				player:addLegend("Participated in "..participations.." Carnages.", "carnageParticipations", 1, 16)
			end
			
			player.registry["arenaDyeSave"] = player.armorColor
			player.armorColor = 0
			player.registry["inCarnage"] = 1
			player.registry["carnageParticipations"] = participations
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