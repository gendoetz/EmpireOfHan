fighters_stance = {
cast = function(player)
	local aether = 30000
	local duration = 600000
	local magicCost = 200
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("fighters_stance")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (player:hasDuration("fighters_stance2") or player:hasDuration("fighters_stance3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("fighters_stance", duration)
	player:setAether("fighters_stance", aether)
	player:playSound(34)
	player:sendAnimation(56, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Fighter's Stance.")
end,

recast = function(player)
	player.enchant = player.enchant + .5
	player.hit = player.hit + 1
	player.dam = player.dam + 1
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Fighter's Stance prepares your weapon for battle increasing your dam and hit a moderate amount."}
	return level, items, itemAmounts, description
end
}

fighters_stance2 = {
cast = function(player)
	local aether = 30000
	local duration = 600000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("fighters_stance2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("fighters_stance")) then
		player:setDuration("fighters_stance", 0)
	end

	
	if (player:hasDuration("fighters_stance3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("fighters_stance2", duration)
	player:setAether("fighters_stance2", aether)
	player:playSound(34)
	player:sendAnimation(56, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Fighter's Stance II.")
end,

recast = function(player)
	player.enchant = player.enchant + .8
	player.hit = player.hit + 2
	player.dam = player.dam + 2
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {"Fighter's Stance II prepares your weapon for battle increasing your dam and hit a greater amount. This ability replaces Fighter's Stance."}
	return level, items, itemAmounts, description
end
}

fighters_stance3 = {
cast = function(player)
	local aether = 30000
	local duration = 600000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("fighters_stance3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("fighters_stance")) then
		player:setDuration("fighters_stance", 0)
	end

	if (player:hasDuration("fighters_stance2")) then
		player:setDuration("fighters_stance2", 0)
	end
	
	player:sendAction(6, 20)
	player:setDuration("fighters_stance3", duration)
	player:setAether("fighters_stance3", aether)
	player:playSound(34)
	player:sendAnimation(56, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Fighter's Stance III.")
end,

recast = function(player)
		player.enchant = player.enchant + 1.1
		player.hit = player.hit + 3
		player.dam = player.dam + 3
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 80
	local items = {}
	local itemAmounts = {}
	local description = {"Fighter's Stance III prepares your weapon for battle increasing your dam and hit a considerable amount. This ability replaces Fighter's Stance II."}
	return level, items, itemAmounts, description
end
}