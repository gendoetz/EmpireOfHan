player_sage = {
cast = function(player, target)
	--aether normally 900000
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if(player.state==1) then
		player:sendMinitext("Spirits can't do that.")
		return
	end

	local a
	a=player.question
	player:sendAction(6,22)
	player:setAether("player_sage",5000)
	player:broadcast(-1,"["..player.name.."]: "..player.question)

end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Allows you to speak to the entire kingdom on the winds. ((Abuse will not be tolerated.))"}
	return level, items, itemAmounts, description
end
}



