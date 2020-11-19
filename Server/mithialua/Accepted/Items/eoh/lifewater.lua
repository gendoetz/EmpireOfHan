pe_lwater = {
use = function(player)
	local magicGiven = 1000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("pe_lwater", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		player.magic = player.magic + magicGiven
		player:sendStatus()
	end
end
}