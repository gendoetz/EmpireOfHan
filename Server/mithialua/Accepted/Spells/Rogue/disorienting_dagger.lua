disorienting_dagger = {
cast = function(player)
	local aether = 25000
	local duration = 5000
	local damage = (((player.level + (player.might * 2)) *5) *2)
	local attackTargets = {}
	local get_mobs = {}
	local get_pc = {}
	local threat
	local magicCost = (.02 * player.maxMagic)

	damage = damage * player.rage
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (player.side == 0) then
		get_mobs = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 2, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 3, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 4, BL_MOB)[1]}
		get_pc =	{player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 2, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 3, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 4, BL_PC)[1]}
	elseif (player.side == 1) then
		get_mobs = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 2, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 3, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 4, player.y, BL_MOB)[1]}
		get_pc = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 2, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 3, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x + 4, player.y, BL_PC)[1]}
	elseif (player.side == 2) then
		get_mobs = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 2, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 3, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 4, BL_MOB)[1]}
		get_pc = {player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 2, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 3, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 4, BL_PC)[1]}
	elseif (player.side == 3) then
		get_mobs = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 2, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 3, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x - 4, player.y, BL_MOB)[1]}
		get_pc = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 2, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 3, player.y, BL_PC)[1],
						player:getObjectsInCell(player.m, player.x - 4, player.y, BL_PC)[1]}
	end

	if (get_mobs[1] ~= nil) then
		table.insert(attackTargets, get_mobs[1])
	end
	if (get_mobs[2] ~= nil) then
		table.insert(attackTargets, get_mobs[2])
	end
	if (get_mobs[3] ~= nil) then
		table.insert(attackTargets, get_mobs[3])
	end
	if (get_mobs[4] ~= nil) then
		table.insert(attackTargets, get_mobs[4])
	end

	if (get_pc[1] ~= nil) then
		table.insert(attackTargets, get_pc[1])
	end
	if (get_pc[2] ~= nil) then
		table.insert(attackTargets, get_pc[2])
	end
	if (get_pc[3] ~= nil) then
		table.insert(attackTargets, get_pc[3])
	end
	if (get_pc[4] ~= nil) then
		table.insert(attackTargets, get_pc[4])
	end


	if (#attackTargets > 0) then

	if (attackTargets[1] ~= nil) then
		if (attackTargets[1]:hasDuration("disorienting_dagger")) then
			player:sendMinitext("This skill has already been used on target.")
			return
		end
		if (attackTargets[1].blType == BL_MOB) then
			if(attackTargets[1].protection == 1) then
				return
			end
		end
		if (attackTargets[1].blType == BL_PC and not player:canPK(attackTargets[1])) then
			player:sendMinitext("You cant attack that target.")
			return
		end
	end
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(351)
		player:sendAction(2, 20)
		player:setAether("disorienting_dagger", aether)

			if (attackTargets[1] ~= nil) then
					if (attackTargets[1].blType == BL_MOB) then

						attackTargets[1].attacker = player.ID
						threat = attackTargets[1]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
						player:addThreat(attackTargets[1].ID, threat)
						if (#player.group > 1) then
							attackTargets[1]:setGrpDmg(player.ID, threat)
						else
							attackTargets[1]:setIndDmg(player.ID, threat)
						end			
						attackTargets[1]:sendAnimation(89, 0)
						attackTargets[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)

						if (attackTargets[1].aiType ~= 0) then
							player:sendMinitext("This enemy is too powerful to disorient!")
							return
						end

						attackTargets[1]:setDuration("disorienting_dagger", duration, player.id)
						attackTargets[1].sleep = attackTargets[1].sleep + .3

						--attackTargets[i]:sendAnimation(172, 0)
						--player:addMagic(damage/4)
					end
					if (attackTargets[1].blType == BL_PC and player:canPK(attackTargets[1])) then
						attackTargets[1]:sendAnimation(89, 0)
						attackTargets[1].attacker = player.ID

						attackTargets[1].drunk = 255
						attackTargets[1].confused = true
						attackTargets[1]:sendStatus()
						attackTargets[1]:updateState()
						attackTargets[1]:setDuration("disorienting_dagger", 5000, player.id, 1)

						attackTargets[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						attackTargets[1]:sendMinitext(player.name.." uses Disorienting Dagger on you.")
					end
			end

	end
end,

while_cast = function(block, caster)
	if (block.sleep == 1 and block.blType == BL_MOB) then
		block:setDuration("disorienting_dagger", 0, caster.id)
		return
	end
	block:sendAnimation(318, 0)
end,

uncast = function(block)
	if(block.blType==BL_PC) then
		block:sendMinitext("Your balance has returned.")
		block.drunk = 0
		block.confused = false
		block:sendStatus()
		block:updateState()
	end
	if (block.blType == BL_MOB) then
		if (block.sleep - .3 < 1) then
			block.sleep = 1
		else
			block.sleep = block.sleep - .3
		end
	end
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Disorienting Dagger throws a nerve-poison laced dagger a short distance ahead of you striking a foe and causing them disorientation and damage."}
	return level, items, itemAmounts, description
end
}