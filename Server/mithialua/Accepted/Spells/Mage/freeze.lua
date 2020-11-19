freeze = {
cast = function(player, target)
	local aether = 0
	local duration = 25000
	local magicCost = 20
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (target:hasDuration("freeze")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (target.state == 1 or target.blType ~= BL_MOB or target.paralyzed == true) then
		player:sendMinitext("You cannot cast Freeze on them.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	player:sendAction(6, 20)
	player:setAether("freeze", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Freeze.")
	player:playSound(73)
	
	--if (target:hasDuration("break_time")) then
	--	target:setDuration("break_time", 0)
	--end
	
	target:sendAnimation(52, 0)
	target:setDuration("freeze", duration, 0, 1)
	target.paralyzed = true
end,

--while_cast = function(block, caster)
--	block:sendAnimation(425, 0)
--end,

recast = function(mob)
	mob.paralyzed = true
end,

uncast = function(block)
	block.paralyzed = false
end,

requirements = function(player)
	local level = 15
	local items = {}
	local itemAmounts = {}
	local description = {"Freezes a foe in place for a short time.  To learn this spell you must sacrifice (1) Crystal Shard and (10) Amber."}
	return level, items, itemAmounts, description
end
}