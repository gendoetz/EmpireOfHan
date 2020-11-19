serpent_swipe = {
cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 15000--22000
	local duration = 20000
	local damage = (player.grace * 15) + (player.might * 5)
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost ) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
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
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 1) then
			mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		elseif (player.side == 2) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 3) then
			mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		end
	end

	--local mobTarget = getTargetFacing(player, BL_MOB)
	--local pcTarget = getTargetFacing(player, BL_PC)

		--if (mobTarget == nil and pcTarget == nil) then
		--player:sendMinitext("You refuse to strike without a target in front of you.")
		--return
		--end

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

	local poisoncount = 0
	for i = 1, #mobFinalattack do
			poisoncount = poisoncount + 1
	end

	for i = 1, #pcFinalattack do
			poisoncount = poisoncount + 1
	end

	--if (poisoncount > 0) then
		--damage = damage / poisoncount
	--end

	player:sendAction(1, 35)
	player:setAether("serpent_swipe", aether)
	player:sendMinitext("You use Serpent Swipe.")
	player:playSound(84)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
			

	for i = 1, 5 do
		if (mobFinalattack[i] ~= nil) then
			mobFinalattack[i].attacker = player.ID
			threat = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobFinalattack[i].ID, threat)
			
			if (#player.group > 1) then
				mobFinalattack[i]:setGrpDmg(player.ID, threat)
			else
				mobFinalattack[i]:setIndDmg(player.ID, threat)
			end

			mobFinalattack[i]:sendAnimation(6, 0)
			if (mobFinalattack[i]:hasDurationID("poison1", player.id) == false) then
				mobFinalattack[i]:setDuration("poison1", duration, player.id)
			end
			
			mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
		if (pcFinalattack[i] ~= nil) then
			
			if (player:canPK(pcFinalattack[i])) then

			pcFinalattack[i]:sendAnimation(6, 0)
			if (pcFinalattack[i]:hasDurationID("poison1", player.id) == false) then
				pcFinalattack[i]:setDuration("poison1", 5000, player.id)
			end
				
				pcFinalattack[i].attacker = player.ID
				pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcFinalattack[i]:sendMinitext(player.name.." uses Serpent Swipe on you.")
			end
		end
	end
end,

requirements = function(player)
	local level = 15
	local items = {}
	local itemAmounts = {}
	local description = {"Serpent Swipe is an attack that targets a group in front of you and unleashes poison."}
	return level, items, itemAmounts, description
end
}

serpent_swipe2 = {
on_learn = function(player)
	if (player:hasSpell("serpent_swipe")) then
		player:removeSpell("serpent_swipe")
	end
	
	player.registry["learned_serpent_swipe"] = 1
end,

cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 15000--22000
	local duration = 20000
	local damage = (player.grace * 25) + (player.might * 15)
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost ) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
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
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 1) then
			mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		elseif (player.side == 2) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 3) then
			mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		end
	end

	--local mobTarget = getTargetFacing(player, BL_MOB)
	--local pcTarget = getTargetFacing(player, BL_PC)

		--if (mobTarget == nil and pcTarget == nil) then
		--player:sendMinitext("You refuse to strike without a target in front of you.")
		--return
		--end

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

	local poisoncount = 0
	for i = 1, #mobFinalattack do
			poisoncount = poisoncount + 1
	end

	for i = 1, #pcFinalattack do
			poisoncount = poisoncount + 1
	end

	--if (poisoncount > 0) then
	--	damage = damage / poisoncount
	--end

	player:sendAction(1, 35)
	player:setAether("serpent_swipe2", aether)
	player:sendMinitext("You use Serpent Swipe II.")
	player:playSound(84)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
			

	for i = 1, 5 do
		if (mobFinalattack[i] ~= nil) then
			mobFinalattack[i].attacker = player.ID
			threat = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobFinalattack[i].ID, threat)
			
			if (#player.group > 1) then
				mobFinalattack[i]:setGrpDmg(player.ID, threat)
			else
				mobFinalattack[i]:setIndDmg(player.ID, threat)
			end

			mobFinalattack[i]:sendAnimation(6, 0)
			if (mobFinalattack[i]:hasDurationID("poison2", player.id) == false) then
				mobFinalattack[i]:setDuration("poison2", duration, player.id)
			end
			
			mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
		if (pcFinalattack[i] ~= nil) then
			
			if (player:canPK(pcFinalattack[i])) then

			pcFinalattack[i]:sendAnimation(6, 0)
			if (pcFinalattack[i]:hasDurationID("poison2", player.id) == false) then
				pcFinalattack[i]:setDuration("poison2", 5000, player.id)
			end
				
				pcFinalattack[i].attacker = player.ID
				pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcFinalattack[i]:sendMinitext(player.name.." uses Serpent Swipe II on you.")
			end
		end
	end
end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Serpent Swipe II is an attack that targets a group in front of you and unleashes poison."}
	return level, items, itemAmounts, description
end
}

serpent_swipe3 = {
on_learn = function(player)
	if (player:hasSpell("serpent_swipe")) then
		player:removeSpell("serpent_swipe")
	end
	player.registry["learned_serpent_swipe"] = 1

	if (player:hasSpell("serpent_swipe2")) then
		player:removeSpell("serpent_swipe2")
	end
	player.registry["learned_serpent_swipe2"] = 1
end,

cast = function(player)
	local mobTargets = {}
	local pcTargets = {}
	local aether = 15000--22000
	local duration = 20000
	local ragecheck
	if (player.rage > 1.5) then
		ragecheck = (player.rage - .5)
	else
		ragecheck = 1.5
	end
	local damage = (player.level * ragecheck) * 35
	local threat
	local healthCost = (player.health * .03)
	local magicCost = (.02 * player.maxMagic)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < healthCost ) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
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
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 1) then
			mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		elseif (player.side == 2) then
			mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1]}
		elseif (player.side == 3) then
			mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1]}
			pcTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
							player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1]}
		end
	end

	--local mobTarget = getTargetFacing(player, BL_MOB)
	--local pcTarget = getTargetFacing(player, BL_PC)

		--if (mobTarget == nil and pcTarget == nil) then
		--player:sendMinitext("You refuse to strike without a target in front of you.")
		--return
		--end

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

	local poisoncount = 0
	for i = 1, #mobFinalattack do
			poisoncount = poisoncount + 1
	end

	--for i = 1, #pcFinalattack do
		--	poisoncount = poisoncount + 1
	--end

	--if (poisoncount > 0) then
		--damage = damage / poisoncount
	--end

	player:sendAction(1, 35)
	player:setAether("serpent_swipe3", aether)
	player:sendMinitext("You use Serpent Swipe III.")
	player:playSound(84)
	player.health = player.health - healthCost
	player.magic = player.magic - magicCost
	player:sendStatus()
			

	for i = 1, 5 do
		if (mobFinalattack[i] ~= nil) then
			mobFinalattack[i].attacker = player.ID
			threat = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobFinalattack[i].ID, threat)
			
			if (#player.group > 1) then
				mobFinalattack[i]:setGrpDmg(player.ID, threat)
			else
				mobFinalattack[i]:setIndDmg(player.ID, threat)
			end

			mobFinalattack[i]:sendAnimation(6, 0)
			if (mobFinalattack[i]:hasDurationID("poison3", player.id) == false) then
				mobFinalattack[i]:setDuration("poison3", duration, player.id)
			end
			
			mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
		if (pcFinalattack[i] ~= nil) then
			
			if (player:canPK(pcFinalattack[i])) then

			pcFinalattack[i]:sendAnimation(6, 0)
			if (pcFinalattack[i]:hasDurationID("poison3", player.id) == false) then
				pcFinalattack[i]:setDuration("poison3", 5000, player.id)
			end
				
				pcFinalattack[i].attacker = player.ID
				pcFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				pcFinalattack[i]:sendMinitext(player.name.." uses Serpent Swipe III on you.")
			end
		end
	end
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Serpent Swipe III is an attack that targets a group in front of you and unleashes poison."}
	return level, items, itemAmounts, description
end
}

poison1 = {
while_cast = function(block, caster)
	local damage = (caster.level * 4) * 1.75
	local threat

	block.attacker = caster.ID

	if (block.m ~= caster.m) then
		block:setDuration("poison1", 0, caster.id)
	end
	
	--Check number with poison and divide
	local poisoncount = 0
	local mobBlocks = block:getObjectsInArea(BL_MOB)
	local pcBlocks = block:getObjectsInArea(BL_PC)

	for i = 1, #mobBlocks do
		if (mobBlocks[i]:hasDurationID("poison1", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	for i = 1, #pcBlocks do
		if (pcBlocks[i]:hasDurationID("poison1", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	--if (poisoncount > 0) then
	--	damage = damage / poisoncount
	--end

	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end

	block:sendAnimation(289, 0)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
end
}

poison2 = {
while_cast = function(block, caster)
	local damage = (caster.level * 5) * 1.75
	local threat

	block.attacker = caster.ID
	
	if (block.m ~= caster.m) then
		block:setDuration("poison2", 0, caster.id)
	end

	--Check number with poison and divide
	local poisoncount = 0
	local mobBlocks = block:getObjectsInArea(BL_MOB)
	local pcBlocks = block:getObjectsInArea(BL_PC)

	for i = 1, #mobBlocks do
		if (mobBlocks[i]:hasDurationID("poison2", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	for i = 1, #pcBlocks do
		if (pcBlocks[i]:hasDurationID("poison2", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	--if (poisoncount > 0) then
	--	damage = damage / poisoncount
	--end

	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end

	block:sendAnimation(289, 0)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
end
}

poison3 = {
while_cast = function(block, caster)
	local ragecheck
	if (caster.rage > 1.5) then
		ragecheck = (caster.rage - .5)
	else
		ragecheck = 1.5
	end

	local damage = (caster.level * ragecheck) * 7
	local threat

	block.attacker = caster.ID

	if (block.m ~= caster.m) then
		block:setDuration("poison3", 0, caster.id)
	end
	
	--Check number with poison and divide
	local poisoncount = 0
	local mobBlocks = block:getObjectsInArea(BL_MOB)
	local pcBlocks = block:getObjectsInArea(BL_PC)

	for i = 1, #mobBlocks do
		if (mobBlocks[i]:hasDurationID("poison3", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	for i = 1, #pcBlocks do
		if (pcBlocks[i]:hasDurationID("poison3", caster.id) == true) then
			poisoncount = poisoncount + 1
		end
	end

	--if (poisoncount > 0) then
	--	damage = damage / poisoncount
	--end

	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.ID, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.ID, threat)
		else
			block:setIndDmg(caster.ID, threat)
		end
	end

	block:sendAnimation(289, 0)
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
end
}