steel_jaw_trap = {
cast = function(player)
	local aether = 10000
	local magicCost = (player.maxMagic * .05)
	local numtraps = 3
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	player:sendAction(6, 20)
	player:setAether("steel_jaw_trap", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()

	repeat
	local randx = player.x + math.random(-1, 1)
	local randy = player.y + math.random(-1, 1)
	local passCheck = getPass(player.m, randx, randy)
	--player:talk(0,"Test")
		if (passCheck == 0 and randx < player.xmax and randy < player.ymax) then
			player:addNPC("steel_jaw_trap", player.m, randx, randy, 0, 90000, player.ID)
			addSpotTrap(player, player.m, randx, randy)
		end
		numtraps = numtraps - 1
	until (numtraps == 0)
	player:sendMinitext("You scatter some Steel-jaw traps.")
end,

click = function(block, npc)
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

	local damage = (owner.level * 3) + (owner.grace * 40)
	
	if (block.blType == BL_MOB) then
		if (block.owner > 0) then
			return
		end
		block:playSound(38)
		block:sendAnimation(44, 0)
		block.attacker = owner.ID
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--block:setDuration("smoke_trap", duration)
		--block.blind = true
		removeTrap(npc)
	elseif (block.blType == BL_PC and owner:canPK(block) and block.state ~= 1) then
		block:playSound(38)
		block:sendAnimation(44, 0)
		block.attacker = owner.id
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		block:calcStat()
		block:sendMinitext("You are injured by a Steel-jaw trap.")
		removeTrap(npc)
	end
end,

endAction = function(npc, owner)
	removeTrap(npc)
end,

--recast = function(block)
--	block.blind = true
--end,

--uncast = function(block)
--	if (block.blType == BL_MOB) then
--		block.blind = false
--	elseif (block.blType == BL_PC) then
--		block:calcStat()
--	end
--end,

requirements = function(player)
	local level = 30
	local items = {}
	local itemAmounts = {}
	local description = {"Steel Jaw Trap places 3 traps that cause considerable damage to enemies that happen upon them in the area around you."}
	return level, items, itemAmounts, description
end
}