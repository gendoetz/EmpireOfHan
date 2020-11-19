throw_dagger = {
uncast=function(player,caster)
	if (player.registry["throw_dagger_rem"] == 1) then
		player.registry["throw_dagger_rem"] = 0
	else
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] - 1
	end
end,
}

throw_dagger2 = {
uncast=function(player,caster)
	if (player.registry["throw_dagger_rem"] == 1) then
		player.registry["throw_dagger_rem"] = 0
	else
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] - 2
	end
end,
}

throw_dagger3 = {
uncast=function(player,caster)
	if (player.registry["throw_dagger_rem"] == 1) then
		player.registry["throw_dagger_rem"] = 0
	else
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] - 3
	end
end,
}

throw_dagger4 = {
uncast=function(player,caster)
	if (player.registry["throw_dagger_rem"] == 1) then
		player.registry["throw_dagger_rem"] = 0
	else
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] - 4
	end
end,
}

throw_dagger5 = {
uncast=function(player,caster)
	if (player.registry["throw_dagger_rem"] == 1) then
		player.registry["throw_dagger_rem"] = 0
	else
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] - 5
	end
end,
}

throw_dagger_attack = {
cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.might * 2)) *5) *2)
	local mobTargets = {}
	local get_mobs = {}
	local threat
	local magicCost = (.02 * player.maxMagic)

	damage = damage * player.rage
	
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

	if (player.registry["throw_dagger_charges"] >= 5) then
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

	if (player.side == 0) then
		get_mobs = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1]}
	player:throw(player.x, player.y - 3, 3389, 2, 2)
	elseif (player.side == 1) then
		get_mobs = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1]}
	player:throw(player.x + 3, player.y-1, 3389, 2, 2)
	elseif (player.side == 2) then
		get_mobs = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1]}
	player:throw(player.x, player.y + 3, 3389, 2, 2)
	elseif (player.side == 3) then
		get_mobs = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1]}
	player:throw(player.x - 3, player.y-1, 3389, 2, 2)
	end

	if (get_mobs[1] ~= nil) then
		table.insert(mobTargets, get_mobs[1])
	end
	if (get_mobs[2] ~= nil) then
		table.insert(mobTargets, get_mobs[2])
	end
	if (get_mobs[3] ~= nil) then
		table.insert(mobTargets, get_mobs[3])
	end

	local mobTargetsFinal = {}

	for i = 1, #mobTargets do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end


	if (#mobTargetsFinal > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(332)
		--player:sendAction(6, 20)
		--player:sendAnimation(171, 0)
		player.registry["throw_dagger_charges"] = player.registry["throw_dagger_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("throw_dagger") and not player:hasDuration("throw_dagger2") and not player:hasDuration("throw_dagger3") and not player:hasDuration("throw_dagger4") and not player:hasDuration("throw_dagger5")) then
			player:setDuration("throw_dagger", 60000)
		elseif (player:hasDuration("throw_dagger")) then
			durationsave = player:durationAmount("throw_dagger")
			player.registry["throw_dagger_rem"] = 1
			player:setDuration("throw_dagger", 0)
			player:setDuration("throw_dagger2", durationsave)
		elseif (player:hasDuration("throw_dagger2")) then
			durationsave = player:durationAmount("throw_dagger2")
			player.registry["throw_dagger_rem"] = 1
			player:setDuration("throw_dagger2", 0)
			player:setDuration("throw_dagger3", durationsave)
		elseif (player:hasDuration("throw_dagger3")) then
			durationsave = player:durationAmount("throw_dagger3")
			player.registry["throw_dagger_rem"] = 1
			player:setDuration("throw_dagger3", 0)
			player:setDuration("throw_dagger4", durationsave)
		elseif (player:hasDuration("throw_dagger4")) then
			durationsave = player:durationAmount("throw_dagger4")
			player.registry["throw_dagger_rem"] = 1
			player:setDuration("throw_dagger4", 0)
			player:setDuration("throw_dagger5", durationsave)
		end

		for i = 1, 3 do
			if (mobTargetsFinal[i] ~= nil) then
					if (mobTargetsFinal[i].blType == BL_MOB) then
						mobTargetsFinal[i].attacker = player.ID
						threat = mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
						player:addThreat(mobTargetsFinal[i].ID, threat)
						if (#player.group > 1) then
							mobTargetsFinal[i]:setGrpDmg(player.ID, threat)
						else
							mobTargetsFinal[i]:setIndDmg(player.ID, threat)
						end			
						mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						--mobTargets[i]:sendAnimation(172, 0)
						--player:addMagic(damage/4)
					end
			end
		end
	end
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Throw Dagger allows you to strike nearby foes with a ranged attack repeatedly."}
	return level, items, itemAmounts, description
end
}