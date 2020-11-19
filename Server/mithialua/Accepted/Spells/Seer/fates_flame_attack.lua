fates_flame = {
uncast=function(player,caster)
	if (player.registry["fflame_manualrem"] == 1) then
		player.registry["fflame_manualrem"] = 0
	else
		player.registry["fflame_charges"] = player.registry["fflame_charges"] - 1
	end
end,
}

fates_flame2 = {
uncast=function(player,caster)
	if (player.registry["fflame_manualrem"] == 1) then
		player.registry["fflame_manualrem"] = 0
	else
		player.registry["fflame_charges"] = player.registry["fflame_charges"] - 2
	end
end,
}

fates_flame3 = {
uncast=function(player,caster)
	if (player.registry["fflame_manualrem"] == 1) then
		player.registry["fflame_manualrem"] = 0
	else
		player.registry["fflame_charges"] = player.registry["fflame_charges"] - 3
	end
end,
}

fates_flame4 = {
uncast=function(player,caster)
	if (player.registry["fflame_manualrem"] == 1) then
		player.registry["fflame_manualrem"] = 0
	else
		player.registry["fflame_charges"] = player.registry["fflame_charges"] - 4
	end
end,
}

fates_flame5 = {
uncast=function(player,caster)
	if (player.registry["fflame_manualrem"] == 1) then
		player.registry["fflame_manualrem"] = 0
	else
		player.registry["fflame_charges"] = player.registry["fflame_charges"] - 5
	end
end,
}

fates_flame_attack = {
cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.will * 2)) *5) *2)
	local targets = {}
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("Your honor forbids this skill in combat of this manner.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.registry["fflame_charges"] >= 2) then
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
	if (player.registry["fflame_charges"] == 0) then

		local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
		local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
		local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
		local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

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
	end

	if (player.registry["fflame_charges"] == 1) then
		targets = getTargetsAroundDiamond(player, BL_MOB)
	end

		local enspellCheck = player:magicDamageMod_enspell(damage)

		damage = enspellCheck

	if (#targets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(370)
		player:sendAction(6, 20)
		player:sendAnimation(171, 0)
		player.registry["fflame_charges"] = player.registry["fflame_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("fates_flame") and not player:hasDuration("fates_flame2") and not player:hasDuration("fates_flame3") and not player:hasDuration("fates_flame4") and not player:hasDuration("fates_flame5")) then
			player:setDuration("fates_flame", 180000)
		elseif (player:hasDuration("fates_flame")) then
			durationsave = player:durationAmount("fates_flame")
			player.registry["fflame_manualrem"] = 1
			player:setDuration("fates_flame", 0)
			player:setDuration("fates_flame2", durationsave)
		elseif (player:hasDuration("fates_flame2")) then
			durationsave = player:durationAmount("fates_flame2")
			player.registry["fflame_manualrem"] = 1
			player:setDuration("fates_flame2", 0)
			player:setDuration("fates_flame3", durationsave)
		elseif (player:hasDuration("fates_flame3")) then
			durationsave = player:durationAmount("fates_flame3")
			player.registry["fflame_manualrem"] = 1
			player:setDuration("fates_flame3", 0)
			player:setDuration("fates_flame4", durationsave)
		elseif (player:hasDuration("fates_flame4")) then
			durationsave = player:durationAmount("fates_flame4")
			player.registry["fflame_manualrem"] = 1
			player:setDuration("fates_flame4", 0)
			player:setDuration("fates_flame5", durationsave)
		end

		for i = 1, #targets do
			if (targets[i].blType == BL_MOB) then
				targets[i].attacker = player.ID
				threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targets[i].ID, threat)
				if (#player.group > 1) then
					targets[i]:setGrpDmg(player.ID, threat)
				else
					targets[i]:setIndDmg(player.ID, threat)
				end			
				targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targets[i]:sendAnimation(172, 0)
				player:addMagic(damage/4)
			end
		end
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Fate's Flame is a spell that damages foes around you, converting damage into mana."}
	return level, items, itemAmounts, description
end
}