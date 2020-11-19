gm_masssummon = {
cast=function(player,target)
	if(string.lower(player.name) == ark) then--WTF?
		return
	end
	local list = player:getUsers()
	if(#list > 0) then
		for i = 1, #list do
			if(list[i].m ~= 134 and list[i].m ~= 135) then
				list[i]:warp(player.m, player.x, player.y)
			end
		end
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Mass Summon brings all online users to your location."}
	return level, items, itemAmounts, description
end
}