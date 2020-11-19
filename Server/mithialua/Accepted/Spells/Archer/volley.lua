volley = {
uncast=function(player,caster)
	if (player.registry["volley_rem"] == 1) then
		player.registry["volley_rem"] = 0
	else
		player.registry["volley_charges"] = player.registry["volley_charges"] - 1
	end
end,
}

volley2 = {
uncast=function(player,caster)
	if (player.registry["volley_rem"] == 1) then
		player.registry["volley_rem"] = 0
	else
		player.registry["volley_charges"] = player.registry["volley_charges"] - 2
	end
end,
}

volley3 = {
uncast=function(player,caster)
	if (player.registry["volley_rem"] == 1) then
		player.registry["volley_rem"] = 0
	else
		player.registry["volley_charges"] = player.registry["volley_charges"] - 3
	end
end,
}

volley4 = {
uncast=function(player,caster)
	if (player.registry["volley_rem"] == 1) then
		player.registry["volley_rem"] = 0
	else
		player.registry["volley_charges"] = player.registry["volley_charges"] - 4
	end
end,
}

volley5 = {
uncast=function(player,caster)
	if (player.registry["volley_rem"] == 1) then
		player.registry["volley_rem"] = 0
	else
		player.registry["volley_charges"] = player.registry["volley_charges"] - 5
	end
end,
}

volley_attack = {
cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.will * 2)) *5) *2)
	local mobTargets = {}
	local mobTargets_Pick = {}
	local threat
	local magicCost = (.02 * player.maxMagic)
	
	damage = damage * player.rage

	local bowrange = player:getEquippedItem(EQ_WEAP)

	if (bowrange ~= nil and (bowrange.id <= 20000 or bowrange.id >= 20500)) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		return
	end

	if (bowrange == nil) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		return
	end
	
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

	if (player.registry["volley_charges"] >= 5) then
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

	mobTargets_Pick = player:getObjectsInArea(BL_MOB)

	if (#mobTargets_Pick > 0) then
		for i = 1, #mobTargets_Pick do
			local random_pick = math.random(1, #mobTargets_Pick)

			--if (mobTargets_Pick[random_pick] ~= nil) then
			--	if (mobTargets_Pick[random_pick].protection == 1) then
			--		table.remove(mobTargets_Pick, random_pick)
			--		break
			--	end
			--end

			if (mobTargets_Pick[random_pick] ~= nil) then
				--table.remove(pcTargets, i)
				if (mobTargets_Pick[random_pick].protection == 1) then
					table.remove(mobTargets_Pick, random_pick)
				else
					table.insert(mobTargets, mobTargets_Pick[random_pick])
					table.remove(mobTargets_Pick, random_pick)
				end
			end
		end
	end

	if (#mobTargets > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(361)
		player:sendAction(1, 20)
		--player:sendAction(6, 20)
		--player:sendAnimation(171, 0)
		player.registry["volley_charges"] = player.registry["volley_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("volley") and not player:hasDuration("volley2") and not player:hasDuration("volley3") and not player:hasDuration("volley4") and not player:hasDuration("volley5")) then
			player:setDuration("volley", 180000)
		elseif (player:hasDuration("volley")) then
			durationsave = player:durationAmount("volley")
			player.registry["volley_rem"] = 1
			player:setDuration("volley", 0)
			player:setDuration("volley2", durationsave)
		elseif (player:hasDuration("volley2")) then
			durationsave = player:durationAmount("volley2")
			player.registry["volley_rem"] = 1
			player:setDuration("volley2", 0)
			player:setDuration("volley3", durationsave)
		elseif (player:hasDuration("volley3")) then
			durationsave = player:durationAmount("volley3")
			player.registry["volley_rem"] = 1
			player:setDuration("volley3", 0)
			player:setDuration("volley4", durationsave)
		elseif (player:hasDuration("volley4")) then
			durationsave = player:durationAmount("volley4")
			player.registry["volley_rem"] = 1
			player:setDuration("volley4", 0)
			player:setDuration("volley5", durationsave)
		end

		for i = 1, 4 do
			if (mobTargets[i] ~= nil) then
					if (mobTargets[i].blType == BL_MOB) then
						mobTargets[i].attacker = player.ID
						threat = mobTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
						player:addThreat(mobTargets[i].ID, threat)
						if (#player.group > 1) then
							mobTargets[i]:setGrpDmg(player.ID, threat)
						else
							mobTargets[i]:setIndDmg(player.ID, threat)
						end		
						player:sendAnimationXY(203, mobTargets[i].x, mobTargets[i].y, 0)	
						mobTargets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						--mobTargets[i]:sendAnimation(172, 0)
						--player:addMagic(damage/4)
					end
			end
		end
	end
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Volley is an ability that shoots arrows into the air and strikes at four random nearby targets."}
	return level, items, itemAmounts, description
end
}