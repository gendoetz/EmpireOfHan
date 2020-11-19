brazen_fist = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 12000
	local magicCost = (.01 * player.maxMagic)
	local damage = (player.maxHealth * .1) + (player.might * 2)
	local threat
	local chancepush = math.random(0, 1)
	
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

	if (pcTarget ~= nil and not player:canPK(pcTarget)) then
		player:sendMinitext("You cannot attack that target now.")
		return
	end
	
--(mobTarget.mobID >= 70 and mobTarget.mobID <= 79)

	if (mobTarget ~= nil) then

		if (mobTarget.behavior == 2 or (mobTarget.mobID >= 70 and mobTarget.mobID <= 79) or mobTarget.mobID == 63) then
			player:sendMinitext("You cannot use this on that target.")
			return
		end

		if (chancepush == 1) then
			canPush_itemno(player, mobTarget)
			player:playSound(354)
		end

		mobTarget:sendAnimation(191, 0)
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		
		if (#player.group > 1) then
			mobTarget:setGrpDmg(player.ID, threat)
		else
			mobTarget:setIndDmg(player.ID, threat)
		end
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:setAether("brazen_fist", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Brazen Fist.")
			player:playSound(2)
			
	elseif (pcTarget ~= nil and pcTarget.gmLevel == 0 and player:canPK(pcTarget)) then

		if (chancepush == 1) then
			canPush(player, pcTarget)
			player:playSound(354)
		end

		pcTarget:sendAnimation(191, 0)
		pcTarget:sendMinitext(player.name.." uses Brazen Fist on you.")
		pcTarget.attacker = player.ID
		pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:setAether("brazen_fist", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Brazen Fist.")
			player:playSound(2)
	end
end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Brazen Fist is a forceful strike that has the potential to knock an enemy out of your path."}
	return level, items, itemAmounts, description
end
}

brazen_fist2 = {
on_learn = function(player)
	if (player:hasSpell("brazen_fist")) then
		player:removeSpell("brazen_fist")
	end
	
	player.registry["learned_brazen_fist"] = 1
end,
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 12000
	local magicCost = (.01 * player.maxMagic)
	local damage = (player.maxHealth * .1) + (player.might * 2)
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

	if (pcTarget ~= nil and not player:canPK(pcTarget)) then
		player:sendMinitext("You cannot attack that target now.")
		return
	end
	
--(mobTarget.mobID >= 70 and mobTarget.mobID <= 79)

	if (mobTarget ~= nil) then

		if (mobTarget.behavior == 2 or (mobTarget.mobID >= 70 and mobTarget.mobID <= 79) or mobTarget.mobID == 63) then
			player:sendMinitext("You cannot use this on that target.")
			return
		end

			canPush_itemno(player, mobTarget)
			player:playSound(354)

		mobTarget:sendAnimation(191, 0)
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		
		if (#player.group > 1) then
			mobTarget:setGrpDmg(player.ID, threat)
		else
			mobTarget:setIndDmg(player.ID, threat)
		end
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:setAether("brazen_fist2", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Brazen Fist II.")
			player:playSound(2)
			
	elseif (pcTarget ~= nil and pcTarget.gmLevel == 0 and player:canPK(pcTarget)) then

			canPush(player, pcTarget)
			player:playSound(354)

		pcTarget:sendAnimation(191, 0)
		pcTarget:sendMinitext(player.name.." uses Brazen Fist II on you.")
		pcTarget.attacker = player.ID
		pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:setAether("brazen_fist2", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Brazen Fist II.")
			player:playSound(2)
	end
end,

requirements = function(player)
	local level = 35
	local items = {}
	local itemAmounts = {}
	local description = {"Brazen Fist II is a forceful strike that always knock an enemy out of your path."}
	return level, items, itemAmounts, description
end
}