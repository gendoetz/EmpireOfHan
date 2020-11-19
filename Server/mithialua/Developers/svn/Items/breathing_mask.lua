breathing_mask = {
	equip = function(player)
	if(player.state==0) then
		player:sendMinitext("You can breathe underwater now.")
	end
end
}