gm_spottraps = {
cast = function(player, target)

	if (player:hasDuration("gm_spottraps")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	player:setDuration("gm_spottraps",180000)
	player:calcStat()
end,

uncast = function(player, target)
	player.spotTraps = false
	player:refresh()
end,

recast = function(player)
	player.spotTraps = true
	player:refresh()
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Spot Traps shows where traps have been laid in a room."}
	return level, items, itemAmounts, description
end
}