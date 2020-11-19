cast_limit = {
cast = function(player, aether)
	player:setAether("cast_limit", aether)
	--player:talk(2,"Test:"..aether)
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Cast Prevention"}
	return level, items, itemAmounts, description
end
}