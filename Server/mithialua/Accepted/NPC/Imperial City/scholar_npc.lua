scholar_npc = {
click = async(function(player, npc)
	local npcG = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local opts = { }

	if(player.gmLevel >= 20) then
	table.insert(opts,"Buy")
	end

	table.insert(opts,"Scholar History Spell")


	player.npcGraphic = npcG.graphic
	player.npcColor = npcG.color
	player.dialogType = 0

	local menuOption=player:menuString("How may I assist you?",opts)
	if(menuOption=="Buy") then
	player:buyExtend("What do you wish to buy?", {198})
	elseif(menuOption=="Scholar History Spell") then
		player:dialogSeq({npcG, "This option grants you the Scholar History spell. Abuse will not be tolerated.",
		npcG, "You must have the Scholar History Token to be granted the spell."}, 1)
		if (player:hasItem("scholar_token1", 1) == true) then
			player:removeItem("scholar_token1",1)
			player:addSpell("scholars_history")
			player:dialogSeq({npcG, "The spell has been granted."}, 1)
		end
	end
end)
}