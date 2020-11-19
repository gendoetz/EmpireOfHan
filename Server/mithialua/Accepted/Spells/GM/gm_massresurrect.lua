gm_massresurrect={
	cast=function(player,target)
		check = player:getObjectsInArea(BL_PC)
		if(#check > 0) then
			for i=1,#check do
				if (check[i].state == 1) then
					check[i]:sendAnimation(116)
					check[i].state = 0
					check[i]:addHealth(check[i].maxHealth)
					check[i]:addMagic(check[i].maxMagic)
					check[i]:updateState()
				end
			end
		end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Mass Resurrect returns all players in your line of view to life."}
	return level, items, itemAmounts, description
end
}