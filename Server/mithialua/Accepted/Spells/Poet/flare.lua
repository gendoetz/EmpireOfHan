flare = {
cast = function(player, target)
	local aether = 1000
	local damage = (player.level * 4) + (player.will * 4) + math.random(1,5)
	local halfdamagemod = 0
	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
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

			target:sendAnimation(27, 1)
			player:sendMinitext("You cast Flare.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC and player:canPK(target)) then

			target:sendAnimation(27, 1)
			player:sendMinitext("You cast Flare.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." casts Flare on you.")
	end

		--multihitcode
	local targets = {}
	local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
	local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
	local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
	local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

	if (#targetsLeft == 0) then
		targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		
		if (#targetsLeft > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsLeft[i])) then
					table.remove(targetsLeft, i)
					i = i - 1
				end
			until (i == #targetsLeft)
		end
	end
	
	if (#targetsRight == 0) then
		targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		
		if (#targetsRight > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsRight[i])) then
					table.remove(targetsRight, i)
					i = i - 1
				end
			until (i == #targetsRight)
		end
	end
	
	if (#targetsUp == 0) then
		targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		
		if (#targetsUp > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsUp[i])) then
					table.remove(targetsUp, i)
					i = i - 1
				end
			until (i == #targetsUp)
		end
	end
	
	if (#targetsDown == 0) then
		targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		
		if (#targetsDown > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsDown[i])) then
					table.remove(targetsDown, i)
					i = i - 1
				end
			until (i == #targetsDown)
		end
	end
	
	if (#targetsLeft > 0) then
		if (targetsLeft[1].blType == BL_MOB and targetsLeft[1].protection ~= 1) then
			table.insert(targets, targetsLeft[1])
		end
		if (targetsLeft[1].blType == BL_PC) then
			table.insert(targets, targetsLeft[1])
		end
	end
	
	if (#targetsRight > 0) then
		--table.insert(targets, targetsRight[1])

		if (targetsRight[1].blType == BL_MOB and targetsRight[1].protection ~= 1) then
			table.insert(targets, targetsRight[1])
		end
		if (targetsRight[1].blType == BL_PC) then
			table.insert(targets, targetsRight[1])
		end
	end
	
	if (#targetsUp > 0) then
		--table.insert(targets, targetsUp[1])

		if (targetsUp[1].blType == BL_MOB and targetsUp[1].protection ~= 1) then
			table.insert(targets, targetsUp[1])
		end
		if (targetsUp[1].blType == BL_PC) then
			table.insert(targets, targetsUp[1])
		end
	end
	
	if (#targetsDown > 0) then
		--table.insert(targets, targetsDown[1])

		if (targetsDown[1].blType == BL_MOB and targetsDown[1].protection ~= 1) then
			table.insert(targets, targetsDown[1])
		end
		if (targetsDown[1].blType == BL_PC) then
			table.insert(targets, targetsDown[1])
		end
	end

	if (#targets > 0) then
		--Testing x4 dividing among targets
		damage = (damage / 2)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext(player.name.." casts Flare on you.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(27, 0)
				--player:setAether("flame_guard", aether)
			--end
			--if (checkProtection(player, targets[i], 750)) then
				--targets[i]:talk(0, "deflect")
				--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
			else
			targets[i].attacker = player.ID
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			if (#player.group > 1) then
				targets[i]:setGrpDmg(player.ID, threat)
			else
				targets[i]:setIndDmg(player.ID, threat)
			end			
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(27, 0)
			end
		end
	end

	if (target.blType == BL_MOB or (#targets > 0 and target.blType == BL_PC) or target.blType == BL_PC and player:canPK(target)) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("cast_limit", aether)
		player:playSound(701)
		player:sendAction(6, 20)
	end
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Flare is a weak spiritual attack on a target. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

flare2 = {
cast = function(player, target)
	local aether = 1000
	local damage = (player.level * 5) + (player.will * 5) + math.random(1,5)
	local halfdamagemod = 0
	
	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
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

			target:sendAnimation(30, 1)
			player:sendMinitext("You cast Flare II.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC and player:canPK(target)) then

			target:sendAnimation(30, 1)
			player:sendMinitext("You cast Flare II.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." casts Flare II on you.")
	end

		--multihitcode
	local targets = {}
	local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
	local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
	local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
	local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

	if (#targetsLeft == 0) then
		targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		
		if (#targetsLeft > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsLeft[i])) then
					table.remove(targetsLeft, i)
					i = i - 1
				end
			until (i == #targetsLeft)
		end
	end
	
	if (#targetsRight == 0) then
		targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		
		if (#targetsRight > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsRight[i])) then
					table.remove(targetsRight, i)
					i = i - 1
				end
			until (i == #targetsRight)
		end
	end
	
	if (#targetsUp == 0) then
		targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		
		if (#targetsUp > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsUp[i])) then
					table.remove(targetsUp, i)
					i = i - 1
				end
			until (i == #targetsUp)
		end
	end
	
	if (#targetsDown == 0) then
		targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		
		if (#targetsDown > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsDown[i])) then
					table.remove(targetsDown, i)
					i = i - 1
				end
			until (i == #targetsDown)
		end
	end
	
	if (#targetsLeft > 0) then
		if (targetsLeft[1].blType == BL_MOB and targetsLeft[1].protection ~= 1) then
			table.insert(targets, targetsLeft[1])
		end
		if (targetsLeft[1].blType == BL_PC) then
			table.insert(targets, targetsLeft[1])
		end
	end
	
	if (#targetsRight > 0) then
		--table.insert(targets, targetsRight[1])

		if (targetsRight[1].blType == BL_MOB and targetsRight[1].protection ~= 1) then
			table.insert(targets, targetsRight[1])
		end
		if (targetsRight[1].blType == BL_PC) then
			table.insert(targets, targetsRight[1])
		end
	end
	
	if (#targetsUp > 0) then
		--table.insert(targets, targetsUp[1])

		if (targetsUp[1].blType == BL_MOB and targetsUp[1].protection ~= 1) then
			table.insert(targets, targetsUp[1])
		end
		if (targetsUp[1].blType == BL_PC) then
			table.insert(targets, targetsUp[1])
		end
	end
	
	if (#targetsDown > 0) then
		--table.insert(targets, targetsDown[1])

		if (targetsDown[1].blType == BL_MOB and targetsDown[1].protection ~= 1) then
			table.insert(targets, targetsDown[1])
		end
		if (targetsDown[1].blType == BL_PC) then
			table.insert(targets, targetsDown[1])
		end
	end

	if (#targets > 0) then
		--Testing x4 dividing among targets
		damage = (damage / 2)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext(player.name.." casts Flare II on you.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(30, 0)
				--player:setAether("flame_guard", aether)
			--end
			--if (checkProtection(player, targets[i], 750)) then
				--targets[i]:talk(0, "deflect")
				--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
			else
			targets[i].attacker = player.ID
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			if (#player.group > 1) then
				targets[i]:setGrpDmg(player.ID, threat)
			else
				targets[i]:setIndDmg(player.ID, threat)
			end			
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(30, 0)
			end
		end
	end

	if (target.blType == BL_MOB or (#targets > 0 and target.blType == BL_PC) or target.blType == BL_PC and player:canPK(target)) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("cast_limit", aether)
		player:playSound(55)
		player:sendAction(6, 20)
	end
end,

requirements = function(player)
	local level = 22
	local items = {}
	local itemAmounts = {}
	local description = {"Flare II is a moderate spiritual attack on a target. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

flare3 = {
cast = function(player, target)
	local aether = 1000
	local damage = (player.level * 6) + (player.will * 6) + math.random(1,5)
	local halfdamagemod = 0
	
		local enspiritCheck = player:magicDamageMod_enspirit(damage)

		damage = enspiritCheck
	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
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
			target:sendAnimation(256, 1)
			player:sendMinitext("You cast Flare III.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC and player:canPK(target)) then

			target:sendAnimation(256, 1)
			player:sendMinitext("You cast Flare III.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." casts Flare III on you.")
	end

		--multihitcode
	local targets = {}
	local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
	local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
	local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
	local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

	if (#targetsLeft == 0) then
		targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		
		if (#targetsLeft > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsLeft[i])) then
					table.remove(targetsLeft, i)
					i = i - 1
				end
			until (i == #targetsLeft)
		end
	end
	
	if (#targetsRight == 0) then
		targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		
		if (#targetsRight > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsRight[i])) then
					table.remove(targetsRight, i)
					i = i - 1
				end
			until (i == #targetsRight)
		end
	end
	
	if (#targetsUp == 0) then
		targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		
		if (#targetsUp > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsUp[i])) then
					table.remove(targetsUp, i)
					i = i - 1
				end
			until (i == #targetsUp)
		end
	end
	
	if (#targetsDown == 0) then
		targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		
		if (#targetsDown > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsDown[i])) then
					table.remove(targetsDown, i)
					i = i - 1
				end
			until (i == #targetsDown)
		end
	end
	
	if (#targetsLeft > 0) then
		if (targetsLeft[1].blType == BL_MOB and targetsLeft[1].protection ~= 1) then
			table.insert(targets, targetsLeft[1])
		end
		if (targetsLeft[1].blType == BL_PC) then
			table.insert(targets, targetsLeft[1])
		end
	end
	
	if (#targetsRight > 0) then
		--table.insert(targets, targetsRight[1])

		if (targetsRight[1].blType == BL_MOB and targetsRight[1].protection ~= 1) then
			table.insert(targets, targetsRight[1])
		end
		if (targetsRight[1].blType == BL_PC) then
			table.insert(targets, targetsRight[1])
		end
	end
	
	if (#targetsUp > 0) then
		--table.insert(targets, targetsUp[1])

		if (targetsUp[1].blType == BL_MOB and targetsUp[1].protection ~= 1) then
			table.insert(targets, targetsUp[1])
		end
		if (targetsUp[1].blType == BL_PC) then
			table.insert(targets, targetsUp[1])
		end
	end
	
	if (#targetsDown > 0) then
		--table.insert(targets, targetsDown[1])

		if (targetsDown[1].blType == BL_MOB and targetsDown[1].protection ~= 1) then
			table.insert(targets, targetsDown[1])
		end
		if (targetsDown[1].blType == BL_PC) then
			table.insert(targets, targetsDown[1])
		end
	end

	if (#targets > 0) then
		--Testing x4 dividing among targets
		damage = (damage / 2)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext(player.name.." casts Flare III on you.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(256, 0)
				--player:setAether("flame_guard", aether)
			--end
			--if (checkProtection(player, targets[i], 750)) then
				--targets[i]:talk(0, "deflect")
				--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
			else
			targets[i].attacker = player.ID
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			if (#player.group > 1) then
				targets[i]:setGrpDmg(player.ID, threat)
			else
				targets[i]:setIndDmg(player.ID, threat)
			end			
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(256, 0)
			end
		end
	end

	if (target.blType == BL_MOB or (#targets > 0 and target.blType == BL_PC) or target.blType == BL_PC and player:canPK(target)) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("cast_limit", aether)
		player:playSound(58)
		player:sendAction(6, 20)
	end
end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Flare III is a strong spiritual attack on a target. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}

flare4 = {
cast = function(player, target)
	local aether = 1000
	local damage = (player.level * 6) + (player.will * 6)
	local halfdamagemod = 0
	local threat

		local enspiritCheck = player:magicDamageMod_enspirit(damage)

		damage = enspiritCheck

	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player:hasAether("cast_limit")) then
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

	if (target.blType == BL_MOB) then
			target:sendAnimation(256, 1)
			player:sendMinitext("You cast Flare III.")
			target.attacker = player.ID
			threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(target.ID, threat)
			
			if (#player.group > 1) then
				target:setGrpDmg(player.ID, threat)
			else
				target:setIndDmg(player.ID, threat)
			end
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
			target:sendAnimation(256, 1)
			player:sendMinitext("You cast Flare III.")
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			target:sendMinitext(player.name.." casts Flare III on you.")
	end

	--multihitcode
	local targets = {}
	local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
	local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
	local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
	local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

	if (#targetsLeft == 0) then
		targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_PC)
		
		if (#targetsLeft > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsLeft[i])) then
					table.remove(targetsLeft, i)
					i = i - 1
				end
			until (i == #targetsLeft)
		end
	end
	
	if (#targetsRight == 0) then
		targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_PC)
		
		if (#targetsRight > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsRight[i])) then
					table.remove(targetsRight, i)
					i = i - 1
				end
			until (i == #targetsRight)
		end
	end
	
	if (#targetsUp == 0) then
		targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_PC)
		
		if (#targetsUp > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsUp[i])) then
					table.remove(targetsUp, i)
					i = i - 1
				end
			until (i == #targetsUp)
		end
	end
	
	if (#targetsDown == 0) then
		targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_PC)
		
		if (#targetsDown > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsDown[i])) then
					table.remove(targetsDown, i)
					i = i - 1
				end
			until (i == #targetsDown)
		end
	end
	
	if (#targetsLeft > 0) then
		table.insert(targets, targetsLeft[1])
	end
	
	if (#targetsRight > 0) then
		table.insert(targets, targetsRight[1])
	end
	
	if (#targetsUp > 0) then
		table.insert(targets, targetsUp[1])
	end
	
	if (#targetsDown > 0) then
		table.insert(targets, targetsDown[1])
	end

	if (#targets > 0) then
		--Testing x4 dividing among targets
		damage = (damage / 2)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext(player.name.." casts Flare III on you.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(256, 0)
				--player:setAether("flame_guard", aether)
			--end
			--if (checkProtection(player, targets[i], 750)) then
				--targets[i]:talk(0, "deflect")
				--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
			else
			targets[i].attacker = player.ID
			threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(targets[i].ID, threat)
			if (#player.group > 1) then
				targets[i]:setGrpDmg(player.ID, threat)
			else
				targets[i]:setIndDmg(player.ID, threat)
			end			
			targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			targets[i]:sendAnimation(256, 0)
			end
		end
	end

	if (target.blType == BL_MOB or (#targets > 0 and target.blType == BL_PC) or target.blType == BL_PC and player:canPK(target)) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setAether("cast_limit", aether)
		player:playSound(58)
		player:sendAction(6, 20)
	end
end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Flare III is a weak spiritual attack on a target. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}