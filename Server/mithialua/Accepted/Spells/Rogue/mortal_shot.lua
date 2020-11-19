mortal_shot = {
cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 12000--16000
	local damage = (player.health) + (player.magic)
	local threat
	local healthCost = (player.health * .5)
	local magicCost = player.magic
	local minHealth = 100
	local minMagic = 500
	local bowrange = player:getEquippedItem(EQ_WEAP)

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
					shadow_decoy_mob.mortal_shot(cloneBlocks[i])
				end

			end
		end
		--

	for i = 1, 1 do
		if (mobFinalattack[i] ~= nil) then
		player:sendAction(1, 35)
		player:setAether("mortal_shot", aether)
		player:sendMinitext("You use Mortal Shot.")
		if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
			player:playSound(100)
		else
			player:playSound(100)
		end
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

				if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
					mobFinalattack[i]:sendAnimation(303, 0)
				else
					mobFinalattack[i]:sendAnimation(69, 0)
				end
				mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		elseif (pcFinalattack[i] ~= nil) then
			if (player:canPK(pcFinalattack[i])) then
		player:sendAction(1, 35)
		player:setAether("mortal_shot", aether)
		player:sendMinitext("You use Mortal Shot.")
		if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
			player:playSound(100)
		else
			player:playSound(100)
		end
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()

				if (bowrange ~= nil and bowrange.id >= 20000 and bowrange.id <= 20200) then
					pcFinalattack[i]:sendAnimation(303, 0)
				else
					pcFinalattack[i]:sendAnimation(69, 0)
				end
				pcFinalattack[i].attacker = player.ID
				pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcFinalattack[i]:sendMinitext(player.name.." strikes you with Mortal Shot.")
			end
		end
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Mortal Shot is and attack that hits with force and skill damaging an enemy greatly."}
	return level, items, itemAmounts, description
end
}