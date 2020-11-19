stun_strike = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = (player.level * 0.01225) + (player.grace * 5.7175)
	local aether = 12000
	local duration = 7000
	local magicCost = (.01 * player.maxMagic)
	local threat
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
		
	if (mobTarget == nil and pcTarget == nil) then
		player:sendMinitext("That is not useful without a target.")
		return
	end

	if (mobTarget ~= nil) then
		if(mobTarget.protection == 1) then
			return
		end
	end
	
	--player:setAether("stun_strike", aether)
	
	if (mobTarget ~= nil) then
	player:sendAction(1, 20)
	player:sendMinitext("You strike your enemy with a stunning blow.")
	player:playSound(7)

		player:setAether("stun_strike", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		mobTarget:sendAnimation(120, 0)
		mobTarget.attacker = player.ID
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		mobTarget.paralyzed = true
		mobTarget:setDuration("stun_strike", duration, 0, 1)

	local chanceturn = math.random(0, 3)
	if (chanceturn == 3) then
		mobTarget:sendAnimation(248, 0)
		if (player.side == 0) then
			mobTarget.side = 0
			mobTarget:sendSide()
		elseif (player.side == 1) then
			mobTarget.side = 1
			mobTarget:sendSide()
		elseif (player.side == 2) then
			mobTarget.side = 2
			mobTarget:sendSide()
		elseif (player.side == 3) then
			mobTarget.side = 3
			mobTarget:sendSide()
		end
	end

	elseif (pcTarget ~= nil) then
		if (player:canPK(pcTarget)) then
	player:sendAction(1, 20)
	player:sendMinitext("You strike your enemy with a stunning blow.")
	player:playSound(7)
		player:setAether("stun_strike", 24000)
		pcTarget:sendAnimation(120, 0)

			player.magic = player.magic - magicCost
			player:sendStatus()
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		pcTarget.paralyzed = true
		pcTarget:setDuration("stun_strike", 2000, 0, 1)

	local chanceturn = math.random(0, 3)
	if (chanceturn == 3) then
		pcTarget:sendAnimation(248, 0)
		if (player.side == 0) then
			pcTarget.side = 0
			pcTarget:sendSide()
		elseif (player.side == 1) then
			pcTarget.side = 1
			pcTarget:sendSide()
		elseif (player.side == 2) then
			pcTarget.side = 2
			pcTarget:sendSide()
		elseif (player.side == 3) then
			pcTarget.side = 3
			pcTarget:sendSide()
		end
	end

			pcTarget:sendMinitext(player.name.." strikes you with Stun Strike.")
		end
	end
end,

uncast = function(block)
	if (block:hasDuration("freeze")) then
		return
	else
		block.paralyzed = false
	end
end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Stun Strike harms your foe and stuns them, if the hit is hard enough they may expose their back as a weakness."}
	return level, items, itemAmounts, description
end
}

stun_strike2 = {
on_learn = function(player)
	if (player:hasSpell("stun_strike")) then
		player:removeSpell("stun_strike")
	end
	
	player.registry["learned_stun_strike"] = 1
end,

cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local damage = (player.level * 0.0245) + (player.level * 11.435)
	local aether = 12000
	local duration = 7000
	local magicCost = (.005 * player.maxMagic)
	local threat
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
		
	if (mobTarget == nil and pcTarget == nil) then
		player:sendMinitext("That is not useful without a target.")
		return
	end
	
	if (mobTarget ~= nil) then
		if(mobTarget.protection == 1) then
			return
		end
	end
	--player:setAether("stun_strike", aether)
	
	if (mobTarget ~= nil) then
	player:sendAction(1, 20)
	player:sendMinitext("You strike your enemy with a stunning blow.")
	player:playSound(7)

		player:setAether("stun_strike2", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		mobTarget:sendAnimation(120, 0)
		mobTarget.attacker = player.ID
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		mobTarget.paralyzed = true
		mobTarget:setDuration("stun_strike2", duration, 0, 1)

		mobTarget:sendAnimation(248, 0)
		if (player.side == 0) then
			mobTarget.side = 0
			mobTarget:sendSide()
		elseif (player.side == 1) then
			mobTarget.side = 1
			mobTarget:sendSide()
		elseif (player.side == 2) then
			mobTarget.side = 2
			mobTarget:sendSide()
		elseif (player.side == 3) then
			mobTarget.side = 3
			mobTarget:sendSide()
		end

	elseif (pcTarget ~= nil) then

		if (player:canPK(pcTarget)) then
	player:sendAction(1, 20)
	player:sendMinitext("You strike your enemy with a stunning blow.")
	player:playSound(7)
			player:setAether("stun_strike2", 24000)
			pcTarget:sendAnimation(120, 0)
		
			player.magic = player.magic - magicCost
			player:sendStatus()
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		pcTarget.paralyzed = true
		pcTarget:setDuration("stun_strike2", 2000, 0, 1)

		pcTarget:sendAnimation(248, 0)
		if (player.side == 0) then
			pcTarget.side = 0
			pcTarget:sendSide()
		elseif (player.side == 1) then
			pcTarget.side = 1
			pcTarget:sendSide()
		elseif (player.side == 2) then
			pcTarget.side = 2
			pcTarget:sendSide()
		elseif (player.side == 3) then
			pcTarget.side = 3
			pcTarget:sendSide()
		end

			pcTarget:sendMinitext(player.name.." stuns you.")
		end
	end
end,

uncast = function(block)
	if (block:hasDuration("freeze")) then
		return
	else
		block.paralyzed = false
	end
end,

requirements = function(player)
	local level = 35
	local items = {}
	local itemAmounts = {}
	local description = {"Stun Strike II harms your foe and stuns them, with an improved hit target always exposes their back."}
	return level, items, itemAmounts, description
end
}