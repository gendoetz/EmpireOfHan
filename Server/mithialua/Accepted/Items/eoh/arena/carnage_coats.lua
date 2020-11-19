ccoat_warp = {
warp_to = function(player)
	local mats = {red = {3, 5, 11, 13}, black = {3, 19, 11, 27}, white = {17, 19, 25, 27}, blue = {17, 5, 25, 13}}

	if (player.armorColor == 63) then
		player:warp(7001, math.random(mats.red[1], mats.red[3]), math.random(mats.red[2], mats.red[4]))
	elseif (player.armorColor == 60) then
		player:warp(7001, math.random(mats.black[1], mats.black[3]), math.random(mats.black[2], mats.black[4]))
	elseif (player.armorColor == 61) then
		player:warp(7001, math.random(mats.white[1], mats.white[3]), math.random(mats.white[2], mats.white[4]))
	elseif (player.armorColor == 65) then
		player:warp(7001, math.random(mats.blue[1], mats.blue[3]), math.random(mats.blue[2], mats.blue[4]))
	end
end
}

arena_coat = { 
equip = function(player)
	if (player.m >= 7000 and player.m <= 7500) then
		--can enter carnage
	else
		player:deductDura(EQ_COAT, 10000)
	end
end,


unequip = function(player)
		--cannot enter carnage
	if (player.m >= 7000 and player.m <= 7500) then
		--warp back to carnage hall
		if (player.m ~= 7001) then
			ccoat_warp.warp_to(player)
		end
	end
end

--while_passive = function(player)

--end
}