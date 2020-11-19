gm_spawnmob = {
cast = function (player)
		local nP = player.question
		if (nP~=nil) then
				local t = tonumber(nP)
				player:spawn(t, player.x, player.y, 1)
		end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Spawn Mob creates a monster based on an ID. Please only use this spell if you are certain of the monter's ID or you will get a bugged monster."}
	return level, items, itemAmounts, description
end
}