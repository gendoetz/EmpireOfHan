molten_blast = {
cast = function(player, target)
	local aether = 1000
	player.registry["mana_increase_fg"] = 15
	local damage = (player.level * 1.25) + (player.will * 4) + math.random(1,5)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (.02 * player.maxMagic)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
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

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(40, 1)
			player:sendMinitext("You cast Molten Blast.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(40, 1)
			player:sendMinitext("You cast Molten Blast.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." blasts you with Molten Blast.")
		--end
	end
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Molten Blast is a weak fire attack on a target."}
	return level, items, itemAmounts, description
end
}

molten_blast2 = {
cast = function(player, target)
	local aether = 1000
	player.registry["mana_increase_fg"] = 15
	local damage = (player.level * 1.5) + (player.will * 4) + math.random(1,5)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (.02 * player.maxMagic)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasAether("cast_limit")) then
		return
	end

	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
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

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(41, 1)
			player:sendMinitext("You cast Molten Blast II.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(41, 1)
			player:sendMinitext("You cast Molten Blast II.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." blasts you with Molten Blast II.")
		--end
	end
end,

requirements = function(player)
	local level = 20
	local items = {}
	local itemAmounts = {}
	local description = {"Molten Blast II is a moderate fire attack on a target."}
	return level, items, itemAmounts, description
end
}

molten_blast3 = {
cast = function(player, target)
	local aether = 1000
	player.registry["mana_increase_fg"] = 15
	local damage = (player.level * 2.5) + (player.will * 4) + math.random(1,5)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (.02 * player.maxMagic)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
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

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(42, 1)
			player:sendMinitext("You cast Molten Blast III.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("cast_limit", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(42, 1)
			player:sendMinitext("You cast Molten Blast III.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." blasts you with Molten Blast III.")
		--end
	end
end,

requirements = function(player)
	local level = 60
	local items = {}
	local itemAmounts = {}
	local description = {"Molten Blast III is a strong fire attack on a target."}
	return level, items, itemAmounts, description
end
}