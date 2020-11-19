bt_token = {
use = function(player)
	if (player.m == 7100) then
		if (player.x == 10) and (player.y == 13) then
			player:spawn(70, 10, 13, 1)
			broadcast(7100, "The blue tower has been restored by: "..player.name.."")
			player:warp(7100, 10, 14)
			player.registry["towertokenholderblue"] = 0
			player:removeItem("bt_token", 1)
		elseif (player.x == 54) and (player.y == 13) then
			broadcast(7100, ""..player.name.." has captured the blue tower!")
			--player:addItem("bt_token", 1)
			player:spawn(70, 54, 13, 1)
			player:warp(7100, 54, 14)
			player.registry["towertokenholderblue"] = 0
			player:removeItem("bt_token", 1)
		else
			player:sendMinitext("You must be standing on the blue tower pannel to use this item.")
			--player:addItem("bt_token", 1)
			--player.registry["towertokenholderblue"] = 0
		end
	end
end
}