shadowshift = {
cast = function(player, target)
	local itemCellBlocks = player:getObjectsInCell(target.m, target.x, target.y, BL_ITEM)
	local players = player:getObjectsInCell(target.m, target.x, target.y, BL_PC)
	local aether = 180000
	local duration = 10000
	local magicCost = 350
	local distance = 8
	local playerX = player.x
	local playerY = player.y
	local damage = (((player.level + player.grace) *5) *2)

	damage = damage * player.rage
	
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
	
	if (target.blType == BL_MOB) then
		player:sendMinitext("Your target is not eligible for that skill.")
		return
	end

	if (target.gmLevel > 0) then
		if (player.gmLevel <= 50) then
			player:sendMinitext("Your target is not eligible for that skill.")
			return
		end
	end

	if (target.id == player.id) then
		player:sendMinitext("You cast Shadowshift.")
		--player:setDuration("shadowshift",dura)
		player:sendAnimation(292, 0)
		player:sendAnimation(177, 0)
		player:playSound(72)
		player:addNPC("shadowshift", player.m, player.x, player.y, 300, 5000, player.ID)
		npc = player:getObjectsInCell(player.m, player.x, player.y, BL_NPC)[1]
		npc.subType = 0
		npc.look = 2000
		player:sendAction(6,10)
		player:setAether("shadowshift", aether)
		return
	end

	if (player.m == 518 or player.m == 585) then
		player:sendMinitext("That doesn't work here.")
		return
	end
	
	if (distanceSquare(player, target, distance) and #players == 1 and #itemCellBlocks == 0 and (#player.group > 1 and player.groupID == target.groupID)) then
		player:sendAction(6, 20)
		player:setAether("shadowshift", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Shadowshift.")
		player:warp(target.m, target.x, target.y)
		target:warp(player.m, playerX, playerY)
		player:playSound(72)
		player:sendAnimation(177, 0)
		target:sendAnimation(177, 0)
		target:sendMinitext(player.name.." steals your shadow.")
	end
end,

while_cast = function(player)
	local manavalue = (player.maxMagic / 20)

	player.magic = player.magic + manavalue
	player:sendStatus()
	--player:addMagic(manavalue)
	--player:sendMinitext("test")
end,

action = function(npc)
	--npc:sendAnimationXY(292, npc.x, npc.y, 0)
	local owner = npc:getBlock(npc.owner)
	local range = npc.registry["spell_range"]
	local counter = npc.registry["spell_counter"]

	if (counter > 20) then
		return
	end

	if (range > 9) then
		return
	end

	local mobBlocks = npc:getObjectsInArea(BL_MOB)
	local damage = (((owner.level + owner.grace) *5) *2)

	damage = damage * owner.rage

	if (range <= 0) then
		range = 1
	end

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (distance(npc, mobBlocks[i]) == range) then
			--if (distanceSquare(npc, mobBlocks[i], range)) then
				npc:sendAnimationXY(292, mobBlocks[i].x, mobBlocks[i].y, 0)
				mobBlocks[i].attacker = mobBlocks[i].ID
				mobBlocks[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				mobBlocks[i]:playSound(math.random(40, 41))
				npc.registry["spell_counter"] = npc.registry["spell_counter"] + 1
			end
		end
	end
	npc.registry["spell_range"] = range + 1
	--npc:talk(1,"Test "..npc.registry["spell_range"])
end,

endAction = function(npc, player)
	npc:delete()
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Shadowshift allows you manipulate the shadow realm. When casted on yourself shadow damage emanates outwards from you. When casted on a group member you will swap positions."}
	return level, items, itemAmounts, description
end
}