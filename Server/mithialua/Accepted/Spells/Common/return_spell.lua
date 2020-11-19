return_spell = {
cast = function(player)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.registry["bindMap"] == 0) then
		player:sendMinitext("You must set a bind location to use this spell.")
		return
	end

	if (player.warpOut == 1) then
		player:warp(player.registry["bindMap"], player.registry["bindX"], player.registry["bindY"])
		player:sendAction(6, 20)
		player:playSound(708)
		player:setAether("return_spell", 5000)
		player:sendMinitext("You cast Return.")
	end
end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Return brings your back to your bound location. You will come across places of interest that will offer this option. There is no cost to learn this spell."}
	return level, items, itemAmounts, description
end
}