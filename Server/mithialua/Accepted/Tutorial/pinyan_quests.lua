rare_p_flower = {
click = async(function(player, npc)
	local npcT = {graphic = convertGraphic(769, "monster"), color = 24}
	local menuOptions = {}
	
	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0
	
	if (player.quest["P_rareflower"] == 1) then
		player:dialogSeq({npcT, "This looks like the flower Dobak was talking about...",
		npcT, "*You pluck the flower and store it safely.*"}, 1)
		player.quest["P_rareflower"] = 2
	end
end)
}