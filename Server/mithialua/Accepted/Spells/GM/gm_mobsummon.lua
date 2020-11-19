gm_mobsummon = {
	cast = function (player)
		local nP = player.question
		local str, t
		if (nP~=nil) then
			if (string.byte(nP) <= 57) and (string.byte(nP) >= 48) then--num
				t = Mob(nP)
				t:warp(player.m, player.x, player.y)
				player:refresh()
			else
				player:sendMinitext("ID expected.")
			end
		end
end,

requirements = function(player)
	local level = 37
	local items = {}
	local itemAmounts = {}
	local description = {"MOB Summon allows you to summon a monster. A monster is randomly chosen from those that exist with the ID, this will not disappear when no players on map."}
	return level, items, itemAmounts, description
end
}