devastate = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 30000--30000
	local threat
	local damage = player.health * 1.75
	local healthCost = (player.health * .9)
	local magicCost = (player.magic * .05)
	local minHealth = 100
	local minMagic = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < minMagic) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (mobTarget ~= nil) then
		if(mobTarget.protection == 1) then
			return
		end
	end

	if (pcTarget ~= nil) then
		if (not player:canPK(pcTarget)) then
			return
		end
	end
	
	if (mobTarget ~= nil) then
		player:sendAction(1, 20)
		player:setAether("devastate", aether)
		player:sendMinitext("You use Devastate.")
		player:playSound(99)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		mobTarget:sendAnimation(67, 0)
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		
		if (#player.group > 1) then
			mobTarget:setGrpDmg(player.ID, threat)
		else
			mobTarget:setIndDmg(player.ID, threat)
		end

		local overflowcalc = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		local mobhealth = mobTarget.health - overflowcalc
		local savemobhealth = mobTarget.health
		local mobTargets = {}
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			if (mobhealth < 0) then
				local damageoverflow = overflowcalc - savemobhealth
				if (player.side == 0) then
					mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
				elseif (player.side == 1) then
					mobTargets = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
				elseif (player.side == 2) then
					mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
				elseif (player.side == 3) then
					mobTargets = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
									player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
				end

						local mob_overkill = {}
						for i = 1, 3 do
							if (mobTargets[i] ~= nil) then
								if (mobTargets[i].protection ~= 1) then
								--table.remove(mobTargets, i)
									table.insert(mob_overkill, mobTargets[i])
								end
							end
						end


				for i = 1, #mob_overkill do
					if (mob_overkill[i] ~= nil) then
						mob_overkill[i]:sendAnimation(67, 0)
						mob_overkill[i].attacker = player.ID
						threat = mob_overkill[i]:removeHealthExtend((damageoverflow / #mob_overkill), 1, 1, 1, 1, 2)
						player:addThreat(mob_overkill[i].ID, threat)
						
						if (#player.group > 1) then
							mob_overkill[i]:setGrpDmg(player.ID, threat)
						else
							mob_overkill[i]:setIndDmg(player.ID, threat)
						end
						
						mob_overkill[i]:removeHealthExtend((damageoverflow / #mob_overkill), 1, 1, 1, 1, 0)
					end
				end
			end

	elseif (pcTarget ~= nil) then
		
		
		if (player:canPK(pcTarget)) then
	pcTarget:sendAnimation(67, 0)
	player:sendAction(1, 20)
	player:setAether("devastate", aether)
	player:sendMinitext("You use Devastate.")
	player:playSound(99)

			player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			pcTarget.attacker = player.ID
			pcTarget:sendMinitext(player.name.." uses Devastate on you.")

			local overflowcalc = pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			local pchealth = pcTarget.health - overflowcalc
			local savepchealth = pcTarget.health
			local pcTargets = {}
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				if (pchealth < 0) then
					local damageoverflow = overflowcalc - savepchealth
					if (player.side == 0) then
						pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]}
					elseif (player.side == 1) then
						pcTargets = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
					elseif (player.side == 2) then
						pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
					elseif (player.side == 3) then
						pcTargets = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}
					end

						local pc_overkill = {}
						for i = 1, 3 do
							if (pcTargets[i] ~= nil) then
								--table.remove(mobTargets, i)
								table.insert(pc_overkill, pcTargets[i])
							end
						end

					for i = 1, #pc_overkill do
						if (pc_overkill[i] ~= nil and player:canPK(pc_overkill[i])) then
							pc_overkill[i]:sendAnimation(67, 0)
							pc_overkill[i].attacker = player.ID
							
							pc_overkill[i]:removeHealthExtend((damageoverflow / #pc_overkill), 1, 1, 1, 1, 0)
						end
					end
				end
		end
	end
end,

requirements = function(player)
	local level = 95
	local items = {}
	local itemAmounts = {}
	local description = {"Devastate is a strong final attack that puts all of your power in a large blow."}
	return level, items, itemAmounts, description
end
}