gm_killmonster = {
	cast=function(player,target)
		if(target.blType==BL_MOB) then
			target.attacker=player.ID
			target:removeHealth(target.health-1)
			target:removeHealth(target.health)
		end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Kill Monster causes a monster to die."}
	return level, items, itemAmounts, description
end
}