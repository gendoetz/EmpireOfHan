gm_wipemonsters = {
cast = function(player)
local mobBlocks = player:getObjectsInSameMap(BL_MOB)

player:playSound(73)

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if(mobBlocks[i].mobID ~= 100) then
				--mobBlocks[i].attacker=player.ID
				--mobBlocks[i]:removeHealth(mobBlocks[i].health-1)
				--mobBlocks[i]:removeHealth(mobBlocks[i].health)
				mobBlocks[i]:removeHealthWithoutDamageNumbers(mobBlocks[i].health)
				mobBlocks[i]:sendAnimation(14)
			end
		end
	end
end,

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"Wipe Monsters kills all monsters on the map."}
	
	return level, items, itemAmounts, description
end
}