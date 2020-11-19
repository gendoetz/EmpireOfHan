gm_stopmonsters = {
cast = function(player)
	local mobBlocks = player:getObjectsInSameMap(BL_MOB)
	player:playSound(45)

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if(mobBlocks[i].blType==BL_MOB) then
				mobBlocks[i].attacker=player.ID
				mobBlocks[i].paralyzed = true
				mobBlocks[i]:sendAnimation(74)
			end
		end
	end
end,

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"Large paralyze that affects everything in the area"}
	
	return level, items, itemAmounts, description
end
}