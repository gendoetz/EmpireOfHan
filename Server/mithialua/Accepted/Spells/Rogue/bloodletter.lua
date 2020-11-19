bloodletter = {
cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 30000--32000
	local damage = (player.health * 0.5) + (player.magic * 2.5)
	local threat
	local healthCost = (player.health * .5)
	local magicCost = 1000
	local minHealth = 100
	local minMagic = 1100
	local bowrange = player:getEquippedItem(EQ_WEAP)
	local overflowcalc
	local mobhealth
	local savemobhealth
	local pchealth
	local savepchealth

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

	if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
		if (player.side == 0) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 4, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 5, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 6, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 7, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 8, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 3, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 4, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 5, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 6, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 7, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 8, BL_PC)[1]}
		elseif (player.side == 1) then
			mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 4, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 5, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 6, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 7, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 8, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 3, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 4, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 5, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 6, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 7, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 8, player.y, BL_PC)[1]}
		elseif (player.side == 2) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x , player.y + 4, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 5, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 6, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 7, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 8, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 3, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 4, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 5, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 6, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 7, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 8, BL_PC)[1]}
		elseif (player.side == 3) then
			mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 4, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 5, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 6, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 7, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 8, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 3, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 4, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 5, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 6, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 7, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 8, player.y, BL_PC)[1]}
		end
	else
		if (player.side == 0) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1]}
		elseif (player.side == 1) then
			mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 2) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		elseif (player.side == 3) then
			mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1]}
		end
	end
		
	--local mobTarget = getTargetFacing(player, BL_MOB)
	--local pcTarget = getTargetFacing(player, BL_PC)
	
	local mobFinalattack = {}
	local pcFinalattack = {}

	for i = 1, 8 do
		if (mobTargets[i] ~= nil) then
			if (mobTargets[i].protection ~= 1) then
				table.insert(mobFinalattack, mobTargets[i])
			end
		end
	end

	for i = 1, 8 do
		if (pcTargets[i] ~= nil) then
			if (player:canPK(pcTargets[i])) then
				table.insert(pcFinalattack, pcTargets[i])
			end
		end
	end

	if (#mobFinalattack == 0 and #pcFinalattack == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end

				--Clone does same
		local cloneBlocks = player:getObjectsInArea(BL_MOB)
		if (#cloneBlocks > 0) then
			for i = 1, #cloneBlocks do
				if (cloneBlocks[i].owner == player.id) then
					shadow_decoy_mob.bloodletter(cloneBlocks[i])
				end

			end
		end
	--

	for i = 1, 1 do
		if (mobFinalattack[i] ~= nil) then
		player:sendAction(1, 20)
		player:setAether("bloodletter", aether)
		player:sendMinitext("You use Bloodletter.")
		player:playSound(35)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
			mobFinalattack[i].attacker = player.ID
			threat = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobFinalattack[i].ID, threat)
			
			if (#player.group > 1) then
				mobFinalattack[i]:setGrpDmg(player.ID, threat)
			else
				mobFinalattack[i]:setIndDmg(player.ID, threat)
			end

			mobFinalattack[i]:sendAnimation(423, 0)
			--mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)

			overflowcalc = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			mobhealth = mobFinalattack[i].health - overflowcalc
			savemobhealth = mobFinalattack[i].health
			mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		elseif (pcFinalattack[i] ~= nil) then
			
			if (player:canPK(pcFinalattack[i])) then
		player:sendAction(1, 20)
		player:setAether("bloodletter", aether)
		player:sendMinitext("You use Bloodletter.")
		player:playSound(35)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()

				pcFinalattack[i]:sendAnimation(423, 0)
				pcFinalattack[i].attacker = player.ID
				pcFinalattack[i]:sendMinitext(player.name.." strikes you with Bloodletter.")

				overflowcalc = pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				pchealth = pcFinalattack[i].health - overflowcalc
				savepchealth = pcFinalattack[i].health
				pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			end
		end
		--Section is for Monsters for long range weapon
		if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
			if (mobFinalattack[i] ~= nil) then
				local mobFinalattack_over = {}
				if (mobhealth < 0) then
					local damageoverflow = overflowcalc - savemobhealth
					if (player.side == 0) then
						mobFinalattack_over = {player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y - 1, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y - 2, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y - 3, BL_MOB)[1]}
					elseif (player.side == 1) then
						mobFinalattack_over = {player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x + 1, mobFinalattack[i].y, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x + 2, mobFinalattack[i].y, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x + 3, mobFinalattack[i].y, BL_MOB)[1]}
					elseif (player.side == 2) then
						mobFinalattack_over = {player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y + 1, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y + 2, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x, mobFinalattack[i].y + 3, BL_MOB)[1]}
					elseif (player.side == 3) then
						mobFinalattack_over = {player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x - 1, mobFinalattack[i].y, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x - 2, mobFinalattack[i].y, BL_MOB)[1],
										player:getObjectsInCell(mobFinalattack[i].m, mobFinalattack[i].x - 3, mobFinalattack[i].y, BL_MOB)[1]}
					end

						local mob_overkill = {}
						for i = 1, 3 do
							if (mobFinalattack_over[i] ~= nil) then
								if (mobFinalattack_over[i].protection ~= 1) then
								--table.remove(mobTargets, i)
								table.insert(mob_overkill, mobFinalattack_over[i])
								end
							end
						end

					for i = 1, #mob_overkill do
						if (mob_overkill[i] ~= nil) then
							mob_overkill[i]:sendAnimation(423, 0)
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
			elseif (pcFinalattack[i] ~= nil) then

				local pcFinalattack_over = {}
				if (pchealth < 0) then
					local damageoverflow = overflowcalc - savepchealth
					if (player.side == 0) then
						pcFinalattack_over = {player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y - 1, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y - 2, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y - 3, BL_PC)[1]}
					elseif (player.side == 1) then
						pcFinalattack_over = {player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x + 1, pcFinalattack[i].y, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x + 2, pcFinalattack[i].y, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x + 3, pcFinalattack[i].y, BL_PC)[1]}
					elseif (player.side == 2) then
						pcFinalattack_over = {player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y + 1, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y + 2, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x, pcFinalattack[i].y + 3, BL_PC)[1]}
					elseif (player.side == 3) then
						pcFinalattack_over = {player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x - 1, pcFinalattack[i].y, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x - 2, pcFinalattack[i].y, BL_PC)[1],
										player:getObjectsInCell(pcFinalattack[i].m, pcFinalattack[i].x - 3, pcFinalattack[i].y, BL_PC)[1]}
					end

						local pc_overkill = {}
						for i = 1, 3 do
							if (pcFinalattack_over[i] ~= nil) then
								--table.remove(mobTargets, i)
								table.insert(pc_overkill, pcFinalattack_over[i])
							end
						end

					for i = 1, #pc_overkill do
						if (pc_overkill[i] ~= nil and player:canPK(pc_overkill[i])) then
							pc_overkill[i]:sendAnimation(423, 0)
							pc_overkill[i].attacker = player.ID
							
							pc_overkill[i]:removeHealthExtend((damageoverflow / #pc_overkill), 1, 1, 1, 1, 0)
						end
					end
				end
			end
		else
		--Section is for Monsters in close range weapon
			if (mobFinalattack[i] ~= nil) then
				local mobFinalattack_over = {}
				if (mobhealth < 0) then
					local damageoverflow = overflowcalc - savemobhealth
					if (player.side == 0) then
						mobFinalattack_over = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
					elseif (player.side == 1) then
						mobFinalattack_over = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
					elseif (player.side == 2) then
						mobFinalattack_over = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
					elseif (player.side == 3) then
						mobFinalattack_over = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
					end

						local mob_overkill = {}
						for i = 1, 3 do
							if (mobFinalattack_over[i] ~= nil) then
								if (mobFinalattack_over[i].protection ~= 1) then
								--table.remove(mobTargets, i)
								table.insert(mob_overkill, mobFinalattack_over[i])
								end
							end
						end

					for i = 1, #mob_overkill do
						if (mob_overkill[i] ~= nil) then
							mob_overkill[i]:sendAnimation(423, 0)
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
			elseif (pcFinalattack[i] ~= nil) then

				local pcFinalattack_over = {}
				if (pchealth < 0) then
					local damageoverflow = overflowcalc - savepchealth
					if (player.side == 0) then
						pcFinalattack_over = {player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1]}
					elseif (player.side == 1) then
						pcFinalattack_over = {player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
					elseif (player.side == 2) then
						pcFinalattack_over = {player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1]}
					elseif (player.side == 3) then
						pcFinalattack_over = {player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
										player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}
					end

						local pc_overkill = {}
						for i = 1, 3 do
							if (pcFinalattack_over[i] ~= nil) then
								--table.remove(mobTargets, i)
								table.insert(pc_overkill, pcFinalattack_over[i])
							end
						end

					for i = 1, #pc_overkill do
						if (pc_overkill[i] ~= nil and player:canPK(pc_overkill[i])) then
							pc_overkill[i]:sendAnimation(423, 0)
							pc_overkill[i].attacker = player.ID
							
							pc_overkill[i]:removeHealthExtend((damageoverflow / #pc_overkill), 1, 1, 1, 1, 0)
						end
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
	local description = {"Bloodletter is a massive attack that combines power from both your health and magic to devastate a foe."}
	return level, items, itemAmounts, description
end
}