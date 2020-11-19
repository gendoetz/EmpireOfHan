pinyan_inn_scroll = {
use = function(player)
	if (not player:canCast(1, 1, 0)) then
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
		return
	end
	
	if (player.warpOut == 1) then
		local x = math.random(3, 7)
		if (x == 5) then
		x = x + 1
		end
		player:warp(25, x, 5)
	else
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
	end
end
}

han_inn_scroll = {
use = function(player)
	if (not player:canCast(1, 1, 0)) then
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
		return
	end
	
	if (player.warpOut == 1) then
		local bed = math.random(1, 2)

		if (bed == 1) then
		local x = math.random(15, 16)
		player:warp(39, x, 5)
		else
		local x = math.random(25, 26)
		player:warp(39, x, 16)
		end
	else
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
	end
end
}

kindred_talisman = {
use = function(player)
	if (not player:canCast(1, 1, 0)) then
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
		return
	end
	if (player.warpOut == 1) then
		if (player.clan ~= 0 and player.registry["clannpcmap"] ~= 0) then
			if (NPC(player.registry["clannpcmap"]).mapRegistry["clanwarpx"] == 0 and NPC(player.registry["clannpcmap"]).mapRegistry["clanwarpy"] == 0) then
			player:sendMinitext("Your clan has not yet set a return location.")
			return
			end
			player:warp(NPC(player.registry["clannpcmap"]).m, NPC(player.registry["clannpcmap"]).mapRegistry["clanwarpx"], NPC(player.registry["clannpcmap"]).mapRegistry["clanwarpy"])
		else
			player:sendMinitext("You do not have a clan to return to.")
		end
	else
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
	end
end
}

yibokyen_inn_scroll = {
use = function(player)
	if (not player:canCast(1, 1, 0)) then
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
		return
	end
	
	if (player.warpOut == 1) then
		local bed = math.random(1, 2)

		if (bed == 1) then
		local x = math.random(30, 31)
		player:warp(588, x, 5)
		else
		local x = math.random(7, 8)
		player:warp(588, x, 9)
		end
	else
		player:sendMinitext("You tear the scroll and nothing happens. The scroll's magic does not work here.")
	end
end
}