burn = {
cast = function(player, target)
	local aether = 10000
	local duration = 20000
	local damage = player.level + (player.will*2)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
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
	
	if (target:hasDurationID("burn", player.id)) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end

	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("burn", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(370)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			player:sendMinitext("You cast Burn.")
			target:setDuration("burn", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("burn", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			player:sendMinitext("You cast Burn.")
			target:setDuration("burn", duration, player.id)
			target:sendMinitext(player.name.." burns you.")
		--end
	end
end,

while_cast = function(block, caster)
	local damage = caster.level + (caster.will*2)
	local threat
	
	block.attacker = caster.ID

	if (block.m ~= caster.m) then
		block:setDuration("burn", 0, caster.id)
	end
	
	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
	
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	block:sendAnimation(46, 0)
end,

requirements = function(player)
	local level = 12
	local items = {}
	local itemAmounts = {}
	local description = {"Burn scorches the flesh of your enemies.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

burn2 = {
on_learn = function(player)
	if (player:hasSpell("burn")) then
		player:removeSpell("burn")
	end
	
	player.registry["learned_burn"] = 1
end,

cast = function(player, target)
	local aether = 10000
	local duration = 20000
	local damage = player.level + (player.will*3)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
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
	
	if (target:hasDurationID("burn2", player.id)) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("burn2", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(370)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(47, 1)
			player:sendMinitext("You cast Burn II.")
			target:setDuration("burn2", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("burn2", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(47, 1)
			player:sendMinitext("You cast Burn II.")
			target:setDuration("burn2", duration, player.id)
			target:sendMinitext(player.name.." burns you.")
		--end
	end
end,

while_cast = function(block, caster)
	local damage = caster.level + (caster.will*3)
	local threat
	
	block.attacker = caster.ID

	if (block.m ~= caster.m) then
		block:setDuration("burn2", 0, caster.id)
	end
	
	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end
	
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	block:sendAnimation(47, 0)
end,

requirements = function(player)
	local level = 35
	local items = {}
	local itemAmounts = {}
	local description = {"Burn II scorches the flesh of your enemies.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}

burn3 = {
on_learn = function(player)
	if (player:hasSpell("burn")) then
		player:removeSpell("burn")
	end
	
	player.registry["learned_burn"] = 1

	if (player:hasSpell("burn2")) then
		player:removeSpell("burn2")
	end
	
	player.registry["learned_burn2"] = 1
end,

cast = function(player, target)
	local aether = 10000
	local duration = 20000
	local damage = player.level + (player.will*4)
	local threat
	local healthCost = (.005 * player.maxHealth)
	local magicCost = (player.will * 3)
	local minHealth = 50
	
	if (not player:canCast(1, 1, 0)) then
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
	
	if (target:hasDurationID("burn3", player.id)) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("burn3", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(370)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(48, 1)
			player:sendMinitext("You cast Burn III.")
			target:setDuration("burn3", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("burn3", aether)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(48, 1)
			player:sendMinitext("You cast Burn III.")
			target:setDuration("burn3", duration, player.id)
			target:sendMinitext(player.name.." burns you.")
		--end
	end
end,

while_cast = function(block, caster)
		local damage = caster.level + (caster.will*4)
		local threat

		local enspellCheck = caster:magicDamageMod_enspell(damage)

		damage = enspellCheck
		
		block.attacker = caster.ID

		if (block.m ~= caster.m) then
			block:setDuration("burn3", 0, caster.id)
		end
		
		if (block.blType == BL_MOB) then
			threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			caster:addThreat(block.ID, threat)
			
			if (#caster.group > 1) then
				block:setGrpDmg(caster.ID, threat)
			else
				block:setIndDmg(caster.ID, threat)
			end
		end
		
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		block:sendAnimation(48, 0)
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Burn III scorches the flesh of your enemies.  To learn this spell you must sacrifice (1) Gold Acorn, (5) Squirrel Pelts, and (1) Amethyst."}
	return level, items, itemAmounts, description
end
}