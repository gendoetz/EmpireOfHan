empress_sage = {
cast=function(player)
	local question = player.question
		if(string.len(question) > 0) then
				player:broadcast(-1, "[Empress "..player.name.."]: "..question)
		else
			player:sendMinitext("Can't send an empty broadcast")
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