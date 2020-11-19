rt_token = {
use = function(player)
	if (player.m == 7100) then
		if (player.x == 49) and (player.y == 13) then
			player:spawn(71, 49, 13, 1)
			broadcast(7100, "The red tower has been restored by: "..player.name.."")
			player:warp(7100, 49, 14)
			player.registry["towertokenholderred"] = 0
			player:removeItem("rt_token", 1)
		elseif (player.x == 5) and (player.y == 13) then
			broadcast(7100, ""..player.name.." has captured the red tower!")
			--player:addItem("rt_token", 1)
			player:spawn(71, 5, 13, 1)
			player:warp(7100, 5, 14)
			player.registry["towertokenholderred"] = 0
			player:removeItem("rt_token", 1)
		else
			player:sendMinitext("You must be standing on the red tower pannel to use this item.")
			--player:addItem("rt_token", 1)
			--player.registry["towertokenholderred"] = 0
		end
	end
end
}