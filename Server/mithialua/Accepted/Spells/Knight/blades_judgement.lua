blades_judgement = {
uncast=function(player,caster)
	if (player.registry["b_judgement_manualrem"] == 1) then
		player.registry["b_judgement_manualrem"] = 0
	else
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] - 1
	end
end,
}

blades_judgement2 = {
uncast=function(player,caster)
	if (player.registry["b_judgement_manualrem"] == 1) then
		player.registry["b_judgement_manualrem"] = 0
	else
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] - 2
	end
end,
}

blades_judgement3 = {
uncast=function(player,caster)
	if (player.registry["b_judgement_manualrem"] == 1) then
		player.registry["b_judgement_manualrem"] = 0
	else
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] - 3
	end
end,
}

blades_judgement4 = {
uncast=function(player,caster)
	if (player.registry["b_judgement_manualrem"] == 1) then
		player.registry["b_judgement_manualrem"] = 0
	else
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] - 4
	end
end,
}

blades_judgement5 = {
uncast=function(player,caster)
	if (player.registry["b_judgement_manualrem"] == 1) then
		player.registry["b_judgement_manualrem"] = 0
	else
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] - 5
	end
end,
}

blades_judgement_attack = {
cast = function(player)
	local aether = 1000
	local damage = (((player.level + (player.might * 2)) *5) *2)
	local targets = {}
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

	if (player.registry["b_judgement_charges"] >= 4) then
		player:sendMinitext("You must wait until your charges return.")
		return
	end


		if (player.side == 0) then
			local mobUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
			local mobUpExtend = player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)
			local mobUpLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)
			local mobUpRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)

			if (#mobUp > 0) then
				table.insert(targets, mobUp[1])
			end
			
			if (#mobUpExtend > 0) then
				table.insert(targets, mobUpExtend[1])
			end
			
			if (#mobUpLeftExtend > 0) then
				table.insert(targets, mobUpLeftExtend[1])
			end
			
			if (#mobUpRightExtend > 0) then
				table.insert(targets, mobUpRightExtend[1])
			end

		elseif (player.side == 1) then
			local mobRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
			local mobRightExtend = player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)
			local mobUpRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)
			local mobDownRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)

			if (#mobRight > 0) then
				table.insert(targets, mobRight[1])
			end
			
			if (#mobRightExtend > 0) then
				table.insert(targets, mobRightExtend[1])
			end
			
			if (#mobUpRightExtend > 0) then
				table.insert(targets, mobUpRightExtend[1])
			end
			
			if (#mobDownRightExtend > 0) then
				table.insert(targets, mobDownRightExtend[1])
			end

		elseif (player.side == 2) then
			local mobDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
			local mobDownLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)
			local mobDownRightExtend = player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)
			local mobDownExtend = player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)

			if (#mobDown > 0) then
				table.insert(targets, mobDown[1])
			end
			
			if (#mobDownLeftExtend > 0) then
				table.insert(targets, mobDownLeftExtend[1])
			end
			
			if (#mobDownRightExtend > 0) then
				table.insert(targets, mobDownRightExtend[1])
			end
			
			if (#mobDownExtend > 0) then
				table.insert(targets, mobDownExtend[1])
			end

		elseif (player.side == 3) then
			local mobLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
			local mobLeftExtend = player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)
			local mobUpLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)
			local mobDownLeftExtend = player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)

			if (#mobLeft > 0) then
				table.insert(targets, mobLeft[1])
			end
			
			if (#mobLeftExtend > 0) then
				table.insert(targets, mobLeftExtend[1])
			end
			
			if (#mobUpLeftExtend > 0) then
				table.insert(targets, mobUpLeftExtend[1])
			end
			
			if (#mobDownLeftExtend > 0) then
				table.insert(targets, mobDownLeftExtend[1])
			end

		end
		
		local targetsFinal = {}

		for i = 1, #targets do
			if (targets[i] ~= nil) then
				if (targets[i].blType == BL_MOB and targets[i].protection ~= 1) then
				--table.remove(mobTargets, i)
					table.insert(targetsFinal, targets[i])
				end
			end
		end

	if (#targetsFinal > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(347)
		player:sendAction(1, 20)
		--player:sendAnimation(171, 0)
		player.registry["b_judgement_charges"] = player.registry["b_judgement_charges"] + 1
		--player:setAether("flare3", aether)
		local durationsave
		if (not player:hasDuration("blades_judgement") and not player:hasDuration("blades_judgement2") and not player:hasDuration("blades_judgement3") and not player:hasDuration("blades_judgement4") and not player:hasDuration("blades_judgement5")) then
			player:setDuration("blades_judgement", 60000)
		elseif (player:hasDuration("blades_judgement")) then
			durationsave = player:durationAmount("blades_judgement")
			player.registry["b_judgement_manualrem"] = 1
			player:setDuration("blades_judgement", 0)
			player:setDuration("blades_judgement2", durationsave)
		elseif (player:hasDuration("blades_judgement2")) then
			durationsave = player:durationAmount("blades_judgement2")
			player.registry["b_judgement_manualrem"] = 1
			player:setDuration("blades_judgement2", 0)
			player:setDuration("blades_judgement3", durationsave)
		elseif (player:hasDuration("blades_judgement3")) then
			durationsave = player:durationAmount("blades_judgement3")
			player.registry["b_judgement_manualrem"] = 1
			player:setDuration("blades_judgement3", 0)
			player:setDuration("blades_judgement4", durationsave)
		elseif (player:hasDuration("blades_judgement4")) then
			durationsave = player:durationAmount("blades_judgement4")
			player.registry["b_judgement_manualrem"] = 1
			player:setDuration("blades_judgement4", 0)
			player:setDuration("blades_judgement5", durationsave)
		end

		for i = 1, #targetsFinal do
			if (targetsFinal[i].blType == BL_MOB) then
				targetsFinal[i].attacker = player.ID
				threat = targetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targetsFinal[i].ID, threat)
				if (#player.group > 1) then
					targetsFinal[i]:setGrpDmg(player.ID, threat)
				else
					targetsFinal[i]:setIndDmg(player.ID, threat)
				end			
				targetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targetsFinal[i]:sendAnimation(411, 0)
			end
		end
		local heal = damage
		local healr_group = 1

		for i = 1, #player.group do
			if (Player(player.group[i]) ~= nil) then
				if (Player(player.group[i]).health <= Player(player.group[i]).maxHealth*.75) then
					healr_group = i
					break
				else
					healr_group = math.random(1, #player.group)
				end
			end
		end

		--for i = 1, #player.group do
		if (Player(player.group[healr_group]) ~= nil) then
			if (Player(player.group[healr_group]).state ~= 1 and Player(player.group[healr_group]).m == player.m) then
				Player(player.group[healr_group]):playSound(708)
				Player(player.group[healr_group]):sendAnimation(58, 0)
				Player(player.group[healr_group]).attacker = player.ID
				Player(player.group[healr_group]):addHealthExtend(heal, 0, 0, 0, 0, 0)
				Player(player.group[healr_group]):sendMinitext(player.name.." judges your soul pure.")
			end
		end
		--end


	end
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Blade's Judgement is a spell that damages foes before you, converting damage into healing on a nearby party member or yourself."}
	return level, items, itemAmounts, description
end
}