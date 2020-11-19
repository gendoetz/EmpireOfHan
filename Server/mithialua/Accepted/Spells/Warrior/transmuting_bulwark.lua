transmuting_bulwark = {
cast = function(player)
	local duration = 12000
	local aether = 60000
	local magicCost = 1000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("transmuting_bulwark")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("transmuting_bulwark", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Transmuting Bulwark.")
	player:setDuration("transmuting_bulwark", duration)
	player:playSound(68)
	player:sendAnimation(323, 0)
end,

while_cast = function(player)
	local seconds = math.floor(player.timerTick/2)
	
	if (seconds % 2 == 0) then
		--pc_timer.second2(player)
		player:sendAnimation(323, 0)
	end
end,

uncast = function(player)
	player:calcStat()
	player:sendMinitext("Your shield has dissapeared.")
end,

requirements = function(player)
	local level = 40
	local items = {}
	local itemAmounts = {}
	local description = {"Transmuting Bulwark heals champion for 100% of damage received over a 12 second duration."}
	return level, items, itemAmounts, description
end
}