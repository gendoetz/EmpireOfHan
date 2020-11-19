hindrance = {
cast = function(player, target)
	local aether = 0--1000
	local duration = 120000
	local magicCost = 10
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	if (target:hasDuration("hindrance")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target:hasDuration("hindrance2") or target:hasDuration("hindrance3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("hindrance", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance.")
		target:setDuration("hindrance", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target.deduction = target.deduction + .15
		target.snare = true
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("hindrance", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance.")
		target:setDuration("hindrance", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target:calcStat()
		target:sendMinitext(player.name.." curses you.")
	end
end,

while_cast = function(block)
	block:sendAnimation(34, 0)
end,

recast = function(player)
	player.armor = player.armor * .85
	--player.deduction = player.deduction + .15
	--player.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		block.deduction = block.deduction - .15
		block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 2
	local items = {}
	local itemAmounts = {}
	local description = {"Hinderance weakens a target causing them to take more damage."}
	return level, items, itemAmounts, description
end
}

hindrance2 = {
cast = function(player, target)
	local aether = 0--1000
	local duration = 120000
	local magicCost = 75
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target:hasDuration("hindrance")) then
		target:setDuration("hindrance", 0)
	end
	
	if (target:hasDuration("hindrance2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target:hasDuration("hindrance3")) then
		player:sendMinitext("A stronger spell is in effect.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("hindrance2", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance II.")
		target:setDuration("hindrance2", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target.deduction = target.deduction + .25
		target.snare = true
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("hindrance2", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance II.")
		target:setDuration("hindrance2", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target:calcStat()
		target:sendMinitext(player.name.." curses you.")
	end
end,

while_cast = function(block)
	block:sendAnimation(34, 0)
end,

recast = function(player)
	player.armor = player.armor * .75
	--player.deduction = player.deduction + .25
	--player.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		block.deduction = block.deduction - .25
		block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Hinderance II weakens a target causing them to take more damage."}
	return level, items, itemAmounts, description
end
}

hindrance3 = {
cast = function(player, target)
	local aether = 0--1000
	local duration = 120000
	local magicCost = 100
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

	if (target:hasDuration("hindrance")) then
		target:setDuration("hindrance", 0)
	end

	if (target:hasDuration("hindrance2")) then
		target:setDuration("hindrance2", 0)
	end
	
	if (target:hasDuration("hindrance3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("hindrance3", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance III.")
		target:setDuration("hindrance3", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target.deduction = target.deduction + .35
		target.snare = true
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("hindrance3", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Hindrance III.")
		target:setDuration("hindrance3", duration)
		player:playSound(37)
		target:sendAnimation(128, 0)
		target:calcStat()
		target:sendMinitext(player.name.." curses you.")
	end
end,

while_cast = function(block)
	block:sendAnimation(34, 0)
end,

recast = function(player)
	--player.deduction = player.deduction + .35
	player.armor = player.armor * .65
	--player.snare = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		block.deduction = block.deduction - .35
		block.snare = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Hinderance III weakens a target causing them to take more damage."}
	return level, items, itemAmounts, description
end
}