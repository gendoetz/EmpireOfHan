quake = {
cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.will * 1.25)) *5) *2)
	local halfdamagemod = 0

	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.registry["quake_charges"] >= 5) then
		player:sendMinitext("You must wait until your charges return.")
		return
	end
	--[[local passCheck = getPass(player.m, player.x, player.y - 1)

	passCheck = getPass(player.m, player.x, player.y - 1)
	if (player.y ~= 0 and passCheck == 0) then
		player:sendAnimationXY(400, player.x, player.y - 1, 0)
	end
	passCheck = getPass(player.m, player.x - 1, player.y)
	if (player.x ~= 0 and passCheck == 0) then
		player:sendAnimationXY(400, player.x - 1, player.y, 0)
	end
	passCheck = getPass(player.m, player.x + 1, player.y)
	if (player.x ~= player.xmax and passCheck == 0) then
		player:sendAnimationXY(400, player.x + 1, player.y, 0)
	end
	passCheck = getPass(player.m, player.x, player.y + 1)
	if (player.y ~= player.ymax and passCheck == 0) then
		player:sendAnimationXY(400, player.x, player.y + 1, 0)
	end]]--

	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	local targets = {}

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
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(46)
		player:sendAction(6, 20)
		player.registry["quake_charges"] = player.registry["quake_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("inner_earth") and not player:hasDuration("inner_earth2") and not player:hasDuration("inner_earth3") and not player:hasDuration("inner_earth4") and not player:hasDuration("inner_earth5")) then
			player:setDuration("inner_earth", 30000)
		elseif (player:hasDuration("inner_earth")) then
			durationsave = player:durationAmount("inner_earth")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth", 0)
			player:setDuration("inner_earth2", durationsave)
		elseif (player:hasDuration("inner_earth2")) then
			durationsave = player:durationAmount("inner_earth2")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth2", 0)
			player:setDuration("inner_earth3", durationsave)
		elseif (player:hasDuration("inner_earth3")) then
			durationsave = player:durationAmount("inner_earth3")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth3", 0)
			player:setDuration("inner_earth4", durationsave)
		elseif (player:hasDuration("inner_earth4")) then
			durationsave = player:durationAmount("inner_earth4")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth4", 0)
			player:setDuration("inner_earth5", durationsave)
		end

		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext("You are damaged by Quake.")
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(17, 0)
			else
				--if (targets[i].blType == BL_PC) then
					--player:setAether("earth_guard", aether)
				--end
				--if (checkProtection(player, targets[i], 750)) then
					--targets[i]:talk(0, "deflect")
					--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
				--else
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				if (#player.group > 1) then
					targets[i]:setGrpDmg(player.ID, threat)
				else
					targets[i]:setIndDmg(player.ID, threat)
				end			
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(17, 0)
			end
		end
	end
end,

requirements = function(player)
	local level = 30
	local items = {}
	local itemAmounts = {}
	local description = {"Quake is a moderate attack that hits targets around you with quick succession."}
	return level, items, itemAmounts, description
end
}

inner_earth = {
uncast=function(player,caster)
	if (player.registry["quake_manualrem"] == 1) then
		player.registry["quake_manualrem"] = 0
	else
		player.registry["quake_charges"] = player.registry["quake_charges"] - 1
	end
end,
}

inner_earth2 = {
uncast=function(player,caster)
	if (player.registry["quake_manualrem"] == 1) then
		player.registry["quake_manualrem"] = 0
	else
		player.registry["quake_charges"] = player.registry["quake_charges"] - 2
	end
end,
}

inner_earth3 = {
uncast=function(player,caster)
	if (player.registry["quake_manualrem"] == 1) then
		player.registry["quake_manualrem"] = 0
	else
		player.registry["quake_charges"] = player.registry["quake_charges"] - 3
	end
end,
}

inner_earth4 = {
uncast=function(player,caster)
	if (player.registry["quake_manualrem"] == 1) then
		player.registry["quake_manualrem"] = 0
	else
		player.registry["quake_charges"] = player.registry["quake_charges"] - 4
	end
end,
}

inner_earth5 = {
uncast=function(player,caster)
	if (player.registry["quake_manualrem"] == 1) then
		player.registry["quake_manualrem"] = 0
	else
		player.registry["quake_charges"] = player.registry["quake_charges"] - 5
	end
end,
}

quake2 = {
on_learn = function(player)
	if (player:hasSpell("quake")) then
		player:removeSpell("quake")
	end
	
	player.registry["quake"] = 1
end,

cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.will * 2)) *5) *2)
	local halfdamagemod = 0
	
	
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.registry["quake_charges"] >= 5) then
		player:sendMinitext("You must wait until your charges return.")
		return
	end
	--[[local passCheck = getPass(player.m, player.x, player.y - 1)

	passCheck = getPass(player.m, player.x, player.y - 1)
	if (player.y ~= 0 and passCheck == 0) then
		player:sendAnimationXY(400, player.x, player.y - 1, 0)
	end
	passCheck = getPass(player.m, player.x - 1, player.y)
	if (player.x ~= 0 and passCheck == 0) then
		player:sendAnimationXY(400, player.x - 1, player.y, 0)
	end
	passCheck = getPass(player.m, player.x + 1, player.y)
	if (player.x ~= player.xmax and passCheck == 0) then
		player:sendAnimationXY(400, player.x + 1, player.y, 0)
	end
	passCheck = getPass(player.m, player.x, player.y + 1)
	if (player.y ~= player.ymax and passCheck == 0) then
		player:sendAnimationXY(400, player.x, player.y + 1, 0)
	end]]--

	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	local targets = {}

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

		local enspiritCheck = player:magicDamageMod_enspirit(damage)

		damage = enspiritCheck

	if (#targets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(48)
		player:sendAction(6, 20)
		player.registry["quake_charges"] = player.registry["quake_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("inner_earth") and not player:hasDuration("inner_earth2") and not player:hasDuration("inner_earth3") and not player:hasDuration("inner_earth4") and not player:hasDuration("inner_earth5")) then
			player:setDuration("inner_earth", 30000)
		elseif (player:hasDuration("inner_earth")) then
			durationsave = player:durationAmount("inner_earth")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth", 0)
			player:setDuration("inner_earth2", durationsave)
		elseif (player:hasDuration("inner_earth2")) then
			durationsave = player:durationAmount("inner_earth2")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth2", 0)
			player:setDuration("inner_earth3", durationsave)
		elseif (player:hasDuration("inner_earth3")) then
			durationsave = player:durationAmount("inner_earth3")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth3", 0)
			player:setDuration("inner_earth4", durationsave)
		elseif (player:hasDuration("inner_earth4")) then
			durationsave = player:durationAmount("inner_earth4")
			player.registry["quake_manualrem"] = 1
			player:setDuration("inner_earth4", 0)
			player:setDuration("inner_earth5", durationsave)
		end

		for i = 1, #targets do
			if (targets[i].blType == BL_PC and player:canPK(targets[i])) then
				targets[i].attacker = player.ID
				targets[i]:sendMinitext("You are damaged by Quake.")
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(400, 0)
			else
				--if (targets[i].blType == BL_PC) then
					--player:setAether("earth_guard", aether)
				--end
				--if (checkProtection(player, targets[i], 750)) then
					--targets[i]:talk(0, "deflect")
					--DOES NOT APPLY, MOBS DON'T HAVE STATUS BOX
				--else
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				if (#player.group > 1) then
					targets[i]:setGrpDmg(player.ID, threat)
				else
					targets[i]:setIndDmg(player.ID, threat)
				end			
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(400, 0)
			end
		end
	end
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Quake II is a strong attack that hits targets around you with quick succession."}
	return level, items, itemAmounts, description
end
}