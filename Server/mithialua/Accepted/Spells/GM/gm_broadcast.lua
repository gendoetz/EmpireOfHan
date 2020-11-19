gm_broadcast = {
cast=function(player)
	local question = player.question
	if (player.gmLevel > 0) then
		if(string.len(question) > 0) then
			if(player.ID == 2) then
				player:broadcast(-1, "[GM "..player.name.."]: "..question)
			else
				player:broadcast(-1, "[Archon "..player.name.."]: "..question)
			end
		else
			player:sendMinitext("Can't send an empty broadcast")
		end
		player:broadcast("Player "..player.name.."has a GM spell.", -1)
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Broadcast sends a message to all players online."}
	return level, items, itemAmounts, description
end
}