smoke_trap = {
cast = function(player)
	local aether = 10000
	local magicCost = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	player:sendAction(6, 20)
	player:setAether("smoke_trap", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:addNPC("smoke_trap", player.m, player.x, player.y, 0, 90000, player.ID)
	player:sendMinitext("You set a Smoke Trap.")
	addSpotTrap(player, player.m, player.x, player.y)
	--player:selfAnimationXY(player.id, 280, player.x, player.y, 60)
end,

click = function(block, npc)
	local damage = 20
	local duration = 20000
	local owner = npc:getBlock(npc.owner)
	
	if (owner == nil or block:hasDuration("smoke_trap")) then
		return
	end

	if (owner.id == block.id) then
		return
	end

	if (block.blType == BL_MOB and block.protection == 1) then
		return
	end
	
	damage = damage * owner.level
	
	if (block.blType == BL_MOB) then
		if (block.owner > 0) then
			return
		end
		block:playSound(38)
		block:sendAnimation(16, 0)
		block.attacker = owner.ID
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		block:setDuration("smoke_trap", duration)
		block.blind = true
		removeTrap(npc)
	elseif (block.blType == BL_PC and owner:canPK(block) and block.state ~= 1) then
		block:playSound(38)
		block:sendAnimation(16, 0)
		block.attacker = owner.ID
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		block:setDuration("smoke_trap", 2000, owner.id, 1)
		block.blind = true
		block:calcStat()
		block:sendMinitext("Smoke has blinded you.")
		removeTrap(npc)
	end
end,

endAction = function(npc, owner)
	removeTrap(npc)
end,

recast = function(block)
	block.blind = true
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		block.blind = false
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Sets a trap that will blind your foes"}
	return level, items, itemAmounts, description
end
}