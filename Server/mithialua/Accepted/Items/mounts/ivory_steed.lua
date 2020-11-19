ivory_steed = {
use = function(player)

	if(player.state==1) then
		player:sendMinitext("You cannot do that while dead.")
		return
	elseif (player.state == 3) then
		player:sendMinitext("Can't do that while riding.")
		return
	end

	if(player.region == 5) then
		player:sendMinitext("You cannot do that while in an event.")
		return
	end

	if(player.mountallow == 0) then
		player:sendMinitext("You cannot use a mount here.")
		return
	end
	
	player:sendAction(6, 80)
	player.disguise = 2
	player.registry["mount_type"] = 1
	player.state = 3
	player.speed= 45
	player:updateState()
	player:sendStatus()
end
}