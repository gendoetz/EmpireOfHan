polearm_strike1 = {
on_hit = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local damage = (player.level * 6)
	local duration = 5000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
		
	if (mobTarget == nil) then
		player:sendMinitext("That is not useful without a target.")
		return
	end
	
	if (mobTarget ~= nil) then
		if(mobTarget.protection == 1) then
			player:sendMinitext("You may not use a polearm on this target.")
			return
		end
		if(mobTarget.mrespawnfunc == 1) then
			player:sendMinitext("This target would break your polearm in half if you tried...")
			return
		end
	end

	if (player.pvp == 1) then
		player:sendMinitext("This cannot be used here.")
		return
	end
	
	if (mobTarget ~= nil) then
		player:playSound(353)
		canPush_itemno(player, mobTarget)
		mobTarget:sendAnimation(302, 0)
		mobTarget.attacker = player.ID
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)

		mobTarget:setDuration("polearm_strike1", duration, 0, 1)

		mobTarget:sendAnimation(248, 0)
		mobTarget.paralyzed = true
	end
end,

uncast = function(block)
	if (block:hasDuration("freeze") or block:hasDuration("paralysis") or block:hasDuration("gm_stopmonsters")) then
		return
	else
		block.paralyzed = false
	end
end
}

polearm_strike1_po = {
on_hit = function(player)
	polearm_strike1.on_hit(player)
end
}

polearm_strike2 = {
on_hit = function(player)

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("This cannot be used here.")
		return
	end

	local mobTargets = {}
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]}


	local damage = (player.level * 6)
	local duration = 5000

	local mobTargetsFinal = {}

	for i = 1, 4 do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end

	if (#mobTargetsFinal == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end
	
	for i = 1, 3 do
		if (mobTargetsFinal[i] ~= nil) then
			if(mobTargetsFinal[i].protection == 1) then
				player:sendMinitext("You may not use a polearm on this target.")
				break
			end
			if(mobTargetsFinal[i].mrespawnfunc == 1) then
				player:sendMinitext("This target would break your polearm in half if you tried...")
				break
			end
			player:playSound(353)
			fourPush_itemno(player, BL_MOB)
			mobTargetsFinal[i]:sendAnimation(302, 0)
			mobTargetsFinal[i].attacker = player.ID
			mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)

			mobTargetsFinal[i]:setDuration("polearm_strike1", duration, 0, 1)

			mobTargetsFinal[i]:sendAnimation(248, 0)
			mobTargetsFinal[i].paralyzed = true
		end
	end
end,

uncast = function(block)
	if (block:hasDuration("freeze") or block:hasDuration("paralysis") or block:hasDuration("gm_stopmonsters")) then
		return
	else
		block.paralyzed = false
	end
end
}

polearm_strike2_po = {
on_hit = function(player)
	polearm_strike2.on_hit(player)
end
}

polearm_strike3 = {
on_hit = function(player)

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("This cannot be used here.")
		return
	end

	local mobTargets = {}
		mobTargets = {player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
						player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1]}


	local damage = (player.level * 6)
	local duration = 10000

	local mobTargetsFinal = {}

	for i = 1, 4 do
		if (mobTargets[i] ~= nil) then
			if(mobTargets[i].protection ~= 1) then
				table.insert(mobTargetsFinal, mobTargets[i])
			end
		end
	end

	if (#mobTargetsFinal == 0) then
		player:sendMinitext("You cannot use this attack without a target in front of you.")
		return
	end
	
	for i = 1, 3 do
		if (mobTargetsFinal[i] ~= nil) then
			if(mobTargetsFinal[i].protection == 1) then
				player:sendMinitext("You may not use a polearm on this target.")
				break
			end
			if(mobTargetsFinal[i].mrespawnfunc == 1) then
				player:sendMinitext("This target would break your polearm in half if you tried...")
				break
			end
			player:playSound(353)
			fourPush_itemno(player, BL_MOB)
			mobTargetsFinal[i]:sendAnimation(302, 0)
			mobTargetsFinal[i].attacker = player.ID
			mobTargetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)

			mobTargetsFinal[i]:setDuration("polearm_strike1", duration, 0, 1)

			mobTargetsFinal[i]:sendAnimation(248, 0)
			mobTargetsFinal[i].paralyzed = true
		end
	end
end,

uncast = function(block)
	if (block:hasDuration("freeze") or block:hasDuration("paralysis") or block:hasDuration("gm_stopmonsters")) then
		return
	else
		block.paralyzed = false
	end
end
}

polearm_strike3_po = {
on_hit = function(player)
	polearm_strike3.on_hit(player)
end
}
