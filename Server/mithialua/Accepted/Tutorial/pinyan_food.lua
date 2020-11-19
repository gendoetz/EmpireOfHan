pinyan_soba = {
use = function(player)
		if(player.state==1) then
			player:sendMinitext("Spirits can't do that")
			return
		end
	if (player:hasItem("pinyan_soba", 1) == true) then
	player:deductDuraInv(player.invSlot, 1)
	player:addHealth2(100)
	player:sendAction(8,25)
	end
end
}