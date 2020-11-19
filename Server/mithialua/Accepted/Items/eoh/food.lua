pirate_food1 = {
use = function(player)

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasItem("pirate_food1", 1) == true) then
	player:deductDuraInv(player.invSlot, 1)
	player:addHealth2(700)
	player:sendAction(8,25)
	end
end
}