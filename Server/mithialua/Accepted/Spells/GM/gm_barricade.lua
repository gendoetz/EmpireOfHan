gm_barricade = {
cast=function(player,target)
	local bar=player:getObjectsInCell(player.m,player.x,player.y,BL_MOB)
	local check=0
	local delete=0
	if(#bar>0) then
		for z=1,#bar do
			if(string.lower(bar[z].name)=="barricade") then
				bar[z].attacker=player.ID
				bar[z]:delete()
				--bar[z]:removeHealth(3000000000)
				delete=1
			end
		end
	end
	if(delete==0) then
		player:spawn(100, player.x, player.y, 1)
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Barricade places a stone block on a tile. This tile cannot be passed by normal players."}
	return level, items, itemAmounts, description
end
}