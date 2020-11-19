flame_guard = {
cast = function(player)
	local aether = 40000
	local duration = 30000
	player.registry["mana_increase_fg"] = player.registry["mana_increase_fg"] + 100
	local magicCost = player.registry["mana_increase_fg"]
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("flame_guard")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("flame_guard", duration)
	player:setAether("flame_guard", aether)
	player:playSound(4)
	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You cast Flame Guard.")
end,

while_cast = function(player)
	--local aether = 3000
	--local delaytime = os.time()
	--local delay = 1
	local magicCost = 25
	local damage = math.random(1, 5) + (player.will * 5)
	local targets = {}
	local threat
	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	--if (os.time() >= delaytime + delay) then
	--local delaytime = os.time()
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end


	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end

	if (#targetsLeft == 0) then
		targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)
		
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
		targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)
		
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
		targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
		
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
		targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
		
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
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil) then
				if(targets[i].blType == BL_MOB and targets[i].protection == 1) then
					table.remove(targets, i)
				end
			end
		end
	end
	
	if (#targets > 0) then

		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)

		--Testing x4 dividing among targets
		--damage = (damage / #targets)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext("You are damaged by Flame Guard.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(47, 0)
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
			targets[i]:sendAnimation(45, 0)
			end
		end
	end
--end
end,

uncast = function(player)

end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Weak elemental shield that damages foes in close range with fire. Mana cost increases with consecutive use, direct attacks will reduct this cost."}
	return level, items, itemAmounts, description
end
}

flame_guard2 = {
on_learn = function(player)
	if (player:hasSpell("flame_guard")) then
		player:removeSpell("flame_guard")
	end
	
	player.registry["learned_flame_guard"] = 1
end,

cast = function(player)
	local aether = 40000
	local duration = 30000
	player.registry["mana_increase_fg"] = player.registry["mana_increase_fg"] + 500
	local magicCost = player.registry["mana_increase_fg"]
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("flame_guard2")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("flame_guard2", duration)
	player:setAether("flame_guard2", aether)
	player:playSound(4)
	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You cast Flame Guard II.")
end,

while_cast = function(player)
	--local aether = 3000
	--local delaytime = os.time()
	--local delay = 1
	local magicCost = 35
	local damage = math.random(5, 10) + (player.will * 6)
	local targets = {}
	local threat
	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	--if (os.time() >= delaytime + delay) then
	--local delaytime = os.time()
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end

	if (#targetsLeft == 0) then
		targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)
		
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
		targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)
		
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
		targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
		
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
		targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
		
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
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil) then
				if(targets[i].blType == BL_MOB and targets[i].protection == 1) then
					table.remove(targets, i)
				end
			end
		end
	end
	
	if (#targets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)

		--Testing x4 dividing among targets
		--damage = (damage / #targets)
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext("You are damaged by Flame Guard.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(47, 0)
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
			targets[i]:sendAnimation(46, 0)
			end
		end
	end
--end
end,

uncast = function(player)

end,

requirements = function(player)
	local level = 31
	local items = {}
	local itemAmounts = {}
	local description = {"Moderate strength elemental shield that damages foes in close range with fire. Mana cost increases with consecutive use, direct attacks will reduct this cost."}
	return level, items, itemAmounts, description
end
}

flame_guard3 = {
on_learn = function(player)
	if (player:hasSpell("flame_guard")) then
		player:removeSpell("flame_guard")
	end
	player.registry["learned_flame_guard"] = 1

	if (player:hasSpell("flame_guard2")) then
		player:removeSpell("flame_guard2")
	end
	player.registry["learned_flame_guard2"] = 1
end,

cast = function(player)
	local aether = 40000
	local duration = 30000
	player.registry["mana_increase_fg"] = player.registry["mana_increase_fg"] + 1000
	local magicCost = player.registry["mana_increase_fg"]
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("flame_guard3")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:setDuration("flame_guard3", duration)
	player:setAether("flame_guard3", aether)
	player:playSound(4)
	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You cast Flame Guard III.")
end,

while_cast = function(player)
	--local aether = 3000
	--local delaytime = os.time()
	--local delay = 1
	local magicCost = 45
	local damage = math.random(10, 15) + (player.will * 7)
	local targets = {}
	local threat
	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	--if (os.time() >= delaytime + delay) then
	--local delaytime = os.time()
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.y ~= 0) then
		player:sendAnimationXY(77, player.x, player.y -1, 0)
	end

	if (#targetsLeft == 0) then
		targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)
		
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
		targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)
		
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
		targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
		
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
		targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
		
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
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil) then
				if(targets[i].blType == BL_MOB and targets[i].protection == 1) then
					table.remove(targets, i)
				end
			end
		end
	end
	
	if (#targets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)

		--Testing x4 dividing among targets
		--damage = (damage / #targets)
		local enspellCheck = player:magicDamageMod_enspell(damage)

		damage = enspellCheck
		
		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext("You are damaged by Flame Guard.")
				targets[i]:removeHealthExtend(damage / 2, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(47, 0)
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
			targets[i]:sendAnimation(47, 0)
			end
		end
	end
--end
end,

uncast = function(player)

end,

requirements = function(player)
	local level = 95
	local items = {}
	local itemAmounts = {}
	local description = {"Strong elemental shield that damages foes in close range with fire. Mana cost increases with consecutive use, direct attacks will reduct this cost."}
	return level, items, itemAmounts, description
end
}