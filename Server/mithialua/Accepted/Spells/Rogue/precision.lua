precision = {
cast = function(player)
	local aether = 0--30000
	local duration = 600000
	local magicCost = 200
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("precision")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (player:hasDuration("precision2") or player:hasDuration("precision3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("precision", duration)
	player:setAether("precision", aether)
	player:playSound(34)
	player:sendAnimation(106, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Precision.")
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
	local description = {"Precision prepares your weapon for battle increasing your dam and hit a moderate amount."}
	return level, items, itemAmounts, description
end
}

precision2 = {
cast = function(player)
	local aether = 0--30000
	local duration = 600000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("precision2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("precision")) then
		player:setDuration("precision", 0)
	end

	
	if (player:hasDuration("precision3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("precision2", duration)
	player:setAether("precision2", aether)
	player:playSound(34)
	player:sendAnimation(106, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Precision II.")
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
	local description = {"Precision II prepares your weapon for battle increasing your dam and hit a greater amount. This ability replaces Precision."}
	return level, items, itemAmounts, description
end
}

precision3 = {
cast = function(player)
	local aether = 0--30000
	local duration = 600000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player:hasDuration("precision3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("precision")) then
		player:setDuration("precision", 0)
	end

	if (player:hasDuration("precision2")) then
		player:setDuration("precision2", 0)
	end
	
	player:sendAction(6, 20)
	player:setDuration("precision3", duration)
	player:setAether("precision3", aether)
	player:playSound(34)
	player:sendAnimation(106, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Precision III.")
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
	local description = {"Precision III prepares your weapon for battle increasing your dam and hit a considerable amount. This ability replaces Precision II."}
	return level, items, itemAmounts, description
end
}