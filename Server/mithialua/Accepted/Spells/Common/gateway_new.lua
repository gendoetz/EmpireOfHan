gateway_new = {
cast = function(player)
	local gate = string.lower(player.question)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if ((player.region == 0 or player.region == 1) and player.warpOut == 1) then
		if (gate == "n" and string.sub(gate, 1, 1) == "n") then
			local x = math.random(56, 63)
			local y = math.random(17, 18)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at North gate.")
		elseif (gate == "e" or string.sub(gate, 1, 1) == "e") then
			local x = math.random(135, 137)
			local y = math.random(43, 46)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at East gate.")
		elseif (gate == "w" or string.sub(gate, 1, 1) == "w") then
			local x = math.random(7, 11)
			local y = math.random(84, 88)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at West gate.")
		elseif (gate == "s" or string.sub(gate, 1, 1) == "s") then
			local x = math.random(59, 64)
			local y = math.random(133, 135)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at South gate.")
		elseif (string.match(gate, "n(%w+)") ~= nil) then
			local x = math.random(56, 63)
			local y = math.random(17, 18)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at North gate.")
		elseif (string.match(gate, "e(%w+)") ~= nil) then
			local x = math.random(135, 137)
			local y = math.random(43, 46)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at East gate.")
		elseif (string.match(gate, "w(%w+)") ~= nil) then
			local x = math.random(7, 11)
			local y = math.random(84, 88)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at West gate.")
		elseif (string.match(gate, "s(%w+)") ~= nil) then
			local x = math.random(59, 64)
			local y = math.random(133, 135)
			
			player:warp(15, x, y)
			player:sendMinitext("You have arrived at South gate.")
		end
		player:sendAction(6, 20)
		player:playSound(708)
	end
	if (player.region == 3 and player.warpOut == 1) then
		if (gate == "n" and string.sub(gate, 1, 1) == "n") then
			local x = math.random(35, 37)
			local y = math.random(3, 4)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at North Yi Bok Yen.")
		elseif (gate == "e" or string.sub(gate, 1, 1) == "e") then
			local x = math.random(64, 68)
			local y = math.random(48, 51)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at East Yi Bok Yen.")
		elseif (gate == "w" or string.sub(gate, 1, 1) == "w") then
			local x = math.random(8, 12)
			local y = math.random(31, 33)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at West Yi Bok Yen.")
		elseif (gate == "s" or string.sub(gate, 1, 1) == "s") then
			local x = math.random(34, 38)
			local y = math.random(82, 85)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at South Yi Bok Yen.")
		elseif (string.match(gate, "n(%w+)") ~= nil) then
			local x = math.random(35, 37)
			local y = math.random(3, 4)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at North Yi Bok Yen.")
		elseif (string.match(gate, "e(%w+)") ~= nil) then
			local x = math.random(64, 68)
			local y = math.random(48, 51)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at East Yi Bok Yen.")
		elseif (string.match(gate, "w(%w+)") ~= nil) then
			local x = math.random(8, 12)
			local y = math.random(31, 33)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at West Yi Bok Yen.")
		elseif (string.match(gate, "s(%w+)") ~= nil) then
			local x = math.random(34, 38)
			local y = math.random(82, 85)
			
			player:warp(173, x, y)
			player:sendMinitext("You have arrived at South Yi Bok Yen.")
		end
		player:sendAction(6, 20)
		player:playSound(708)
	end
end,

on_forget = function(player)
	player.registry["learned_gateway_new"] = 0
end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Teleports you to a gate in town"}
	return level, items, itemAmounts, description
end
}