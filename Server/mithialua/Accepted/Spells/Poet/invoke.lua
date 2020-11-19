invoke = {
cast = function(player)
	local aether = 25000
	local healthCost = (player.maxMagic * .4)
	local minMagic = 30
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < minMagic) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.health - healthCost < 1) then
		player.health = 100
	else
		player.health = player.health - healthCost
	end
	
	player:sendAction(6, 20)
	player:setAether("invoke", aether)
	player:playSound(34)
	player:sendAnimation(251, 0)
	player.magic = player.maxMagic
	player:sendStatus()
	player:sendMinitext("You cast Invoke.")
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Invoke takes away the casters vita in exchange for mana. To learn this spell you must sacrifice (1) Gold Acorn, (5) Tainted Antlers, and 100 gold coins."}
	return level, items, itemAmounts, description
end
}