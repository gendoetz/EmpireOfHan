tigers_cunning = {
cast = function(player)
	local aether = 0--60000
	local duration = 600000
	local magicCost = 75
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("tigers_cunning2") or player:hasDuration("tigers_cunning3") or player:hasDuration("tigers_cunning4") or player:hasDuration("enfocus")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("tigers_cunning")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("tigers_cunning", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("tigers_cunning", duration)
	player:playSound(31)
	player:sendAnimation(212, 2)
	player:sendAnimation(35, 0)
	player:calcStat()
	player:sendMinitext("You use Tiger's Cunning.")
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
	local description = {"Tiger's Cunning gives you an edge of focus over your opponent increasing your skills in a small manner."}
	return level, items, itemAmounts, description
end
}

tigers_cunning2 = {
cast = function(player)
	local aether = 0--60000
	local duration = 600000
	local magicCost = 375
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("tigers_cunning3") or player:hasDuration("tigers_cunning4") or player:hasDuration("enfocus")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("tigers_cunning2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("tigers_cunning")) then
		player:setDuration("tigers_cunning", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("tigers_cunning2", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("tigers_cunning2", duration)
	player:playSound(31)
	player:sendAnimation(212, 2)
	player:sendAnimation(35, 0)
	player:calcStat()
	player:sendMinitext("You use Tiger's Cunning II.")
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
	local description = {"Tiger's Cunning II gives you an edge of focus over your opponent increasing your skills in a moderate manner."}
	return level, items, itemAmounts, description
end
}

tigers_cunning3 = {
cast = function(player)
	local aether = 0--60000
	local duration = 600000
	local magicCost = 575
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("tigers_cunning4") or player:hasDuration("enfocus")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end
	
	if (player:hasDuration("tigers_cunning3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("tigers_cunning")) then
		player:setDuration("tigers_cunning", 0)
	end

	if (player:hasDuration("tigers_cunning2")) then
		player:setDuration("tigers_cunning2", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("tigers_cunning3", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("tigers_cunning3", duration)
	player:playSound(31)
	player:sendAnimation(212, 2)
	player:sendAnimation(35, 0)
	player:calcStat()
	player:sendMinitext("You use Tiger's Cunning III.")
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
	local description = {"Tiger's Cunning III gives you an edge of focus over your opponent increasing your skills in a greater manner."}
	return level, items, itemAmounts, description
end
}

tigers_cunning4 = {
cast = function(player)
	local aether = 0--60000
	local duration = 600000
	local magicCost = 975
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("tigers_cunning4")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (player:hasDuration("enfocus")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end

	if (player:hasDuration("tigers_cunning")) then
		player:setDuration("tigers_cunning", 0)
	end

	if (player:hasDuration("tigers_cunning2")) then
		player:setDuration("tigers_cunning2", 0)
	end

	if (player:hasDuration("tigers_cunning3")) then
		player:setDuration("tigers_cunning3", 0)
	end
	
	player:sendAction(6, 20)
	player:setAether("tigers_cunning4", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setDuration("tigers_cunning4", duration)
	player:playSound(31)
	player:sendAnimation(212, 2)
	player:sendAnimation(35, 0)
	player:calcStat()
	player:sendMinitext("You use Tiger's Cunning IV.")
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
	local description = {"Tiger's Cunning IV gives you an edge of focus over your opponent increasing your skills in a massive manner."}
	return level, items, itemAmounts, description
end
}