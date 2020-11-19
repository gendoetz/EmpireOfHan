dragons_brawn = {
cast = function(player)
	local aether = 60000
	local duration = 600000
	local magicCost = 75
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("dragons_brawn2") or player:hasDuration("dragons_brawn3") or player:hasDuration("dragons_brawn4") or player:hasDuration("enrage")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("dragons_brawn")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("dragons_brawn", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("dragons_brawn", duration)
	player:playSound(31)
	player:sendAnimation(219, 2)
	player:sendAnimation(36, 0)
	player:calcStat()
	player:sendMinitext("You use Dragon's Brawn.")
end,

recast = function(player)
	player.rage = player.rage + .15
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 12
	local items = {}
	local itemAmounts = {}
	local description = {"Dragon's Brawn gives you an edge of focus over your opponent increasing your skills in a small manner."}
	return level, items, itemAmounts, description
end
}

dragons_brawn2 = {
cast = function(player)
	local aether = 60000
	local duration = 600000
	local magicCost = 375
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("dragons_brawn3") or player:hasDuration("dragons_brawn4") or player:hasDuration("enrage")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("dragons_brawn2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("dragons_brawn")) then
		player:setDuration("dragons_brawn", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("dragons_brawn2", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("dragons_brawn2", duration)
	player:playSound(31)
	player:sendAnimation(219, 2)
	player:sendAnimation(36, 0)
	player:calcStat()
	player:sendMinitext("You use Dragon's Brawn II.")
end,

recast = function(player)
	player.rage = player.rage + .30
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 22
	local items = {}
	local itemAmounts = {}
	local description = {"Dragon's Brawn II gives you an edge of focus over your opponent increasing your skills in a moderate manner."}
	return level, items, itemAmounts, description
end
}

dragons_brawn3 = {
cast = function(player)
	local aether = 60000
	local duration = 600000
	local magicCost = 575
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("dragons_brawn4") or player:hasDuration("enrage")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("dragons_brawn3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("dragons_brawn")) then
		player:setDuration("dragons_brawn", 0)
	end

	if (player:hasDuration("dragons_brawn2")) then
		player:setDuration("dragons_brawn2", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("dragons_brawn3", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("dragons_brawn3", duration)
	player:playSound(31)
	player:sendAnimation(219, 2)
	player:sendAnimation(36, 0)
	player:calcStat()
	player:sendMinitext("You use Dragon's Brawn III.")
end,

recast = function(player)
	player.rage = player.rage + .45
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Dragon's Brawn III gives you an edge of focus over your opponent increasing your skills in a greater manner."}
	return level, items, itemAmounts, description
end
}

dragons_brawn4 = {
cast = function(player)
	local aether = 60000
	local duration = 600000
	local magicCost = 975
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("dragons_brawn4")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("enrage")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end

	if (player:hasDuration("dragons_brawn")) then
		player:setDuration("dragons_brawn", 0)
	end

	if (player:hasDuration("dragons_brawn2")) then
		player:setDuration("dragons_brawn2", 0)
	end

	if (player:hasDuration("dragons_brawn3")) then
		player:setDuration("dragons_brawn3", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("dragons_brawn4", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("dragons_brawn4", duration)
	player:playSound(31)
	player:sendAnimation(219, 2)
	player:sendAnimation(36, 0)
	player:calcStat()
	player:sendMinitext("You use Dragon's Brawn IV.")
end,

recast = function(player)
	player.rage = player.rage + .60
end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Dragon's Brawn IV gives you an edge of focus over your opponent increasing your skills in a massive manner."}
	return level, items, itemAmounts, description
end
}