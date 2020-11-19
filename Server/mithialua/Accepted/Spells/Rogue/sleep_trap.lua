sleep_trap = {
cast = function(player)
	local aether = 20000
	local magicCost = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	player:sendAction(6, 20)
	player:setAether("sleep_trap", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:addNPC("sleep_trap", player.m, player.x, player.y, 0, 90000, player.ID)
	player:sendMinitext("You set a Sleep Trap.")
	addSpotTrap(player, player.m, player.x, player.y)
end,

click = function(block, npc)

	local duration = 15000
	local owner = npc:getBlock(npc.owner)

	if (owner == nil) then
		return
	end

	if (owner.id == block.id) then
		return
	end

	if (block.blType == BL_MOB and block.protection == 1) then
		return
	end
	
			if (block.blType == BL_MOB) then
					if (block.owner > 0) then
						return
					end
				--block:sendAnimation(2, 0)
				block:playSound(86)
				block.attacker = owner.ID
				block:setDuration("sleep_trap", duration)
				block.sleep = block.sleep + .3
				removeTrap(npc)
			end
			if (block.blType == BL_PC and owner:canPK(block) and block.state ~= 1) then
				block:playSound(86)
				block.attacker = owner.ID
				block:setDuration("sleep_trap", duration, owner.id, 1)
				block:calcStat()
				removeTrap(npc)
			end
end,

endAction = function(npc, owner)
	removeTrap(npc)
end,

while_cast = function(block, caster)
	if (block.sleep == 1) then
		block:setDuration("sleep_trap", 0, caster.id)
	else
		block:sendAnimation(2, 0)
	end
end,

recast = function(player)
	player.sleep = player.sleep + .3
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		if (block.sleep - .3 < 1) then
			block.sleep = 1
		else
			block.sleep = block.sleep - .3
		end
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Sleep trap causes an enemy to fall into a slumber. The next attack will cause them to take more damage."}
	return level, items, itemAmounts, description
end
}