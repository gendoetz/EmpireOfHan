frigid_blast = {
cast = function(player)
	local mobTargets = {}
	local aether = 60000
	local duration = 10000
	local damage = (((player.level + (player.will * 2)) *5) *2)
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
	
	if (player.side == 0) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1]}
	elseif (player.side == 1) then
		mobTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
	elseif (player.side == 2) then
		mobTargets = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1]}
	elseif (player.side == 3) then
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	end

	if (#mobTargets == 0) then
		player:sendMinitext("You cannot use this spell without a target in front of you.")
		return
	end

	local mobFinalattack = {}

	if (#mobTargets ~= 0) then
		for i = 1, #mobTargets do
			if (mobTargets[i] ~= nil) then
				if (mobTargets[i].protection ~= 1) then
					table.insert(mobFinalattack, mobTargets[i])
				end
			end
		end
	end
	
	if (#mobFinalattack > 0) then
		player:sendAction(1, 20)
		player:setAether("frigid_blast", aether)
		player:sendMinitext("You cast Frigid Blast.")
		player:playSound(10)
		player.magic = player.magic - magicCost
		player:sendStatus()
	end

	for i = 1, #mobFinalattack do
		if (mobFinalattack[i] ~= nil) then
			mobFinalattack[i].attacker = player.ID
			threat = mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobFinalattack[i].ID, threat)
			
			if (#player.group > 1) then
				mobFinalattack[i]:setGrpDmg(player.ID, threat)
			else
				mobFinalattack[i]:setIndDmg(player.ID, threat)
			end
			mobFinalattack[i]:sendAnimation(169, 0)
			mobFinalattack[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				if (mobFinalattack[i]:hasDuration("frigid_blast") == false and mobFinalattack[i]:hasDuration("slumber") == false) then
					mobFinalattack[i]:setDuration("frigid_blast", duration)
					mobFinalattack[i].sleep = mobFinalattack[i].sleep + .3
					--mobTargets[i].snare = true
				end
		end
	end
end,

while_cast = function(block)
	if (block.sleep == 1) then
		block:setDuration("frigid_blast", 0)
	else
		block:sendAnimation(22, 0)
	end
end,

recast = function(block)
	block.sleep = block.sleep + .3
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		if (block.sleep - .3 < 1) then
			block.sleep = 1
		else
			block.sleep = block.sleep - .3
		end
	end
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Frigid Blast bombards foes in front of you with freezing wind stopping them and causing them to take extra damage for a short time."}
	return level, items, itemAmounts, description
end
}