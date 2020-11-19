refraction = {
cast = function(player)
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
	

		player:sendMinitext("You cast Refraction.")
		--player:setDuration("shadowshift",dura)
		--player:sendAnimation(292, 0)
		player:sendAnimation(135, 0)
		player:playSound(70)
		player:addNPC("refraction", player.m, player.x, player.y, 300, 5000, player.ID)
		npc = player:getObjectsInCell(player.m, player.x, player.y, BL_NPC)[1]
		npc.subType = 0
		npc.look = 2000
		player:sendAction(6,10)
		--player:setAether("shadowshift", aether)
	
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
	local dura = 200000
	local dura2 = 5000

	--if (counter > 20) then
	--	return
	--end

	--if (range > 9) then
	--	return
	--end

	--local damage = (((owner.level + owner.grace) *5) *2)

	--damage = damage * owner.rage

	if (range <= 0) then
		range = 1
	end

		for x = 0, npc.xmax do
			for y = 0, npc.ymax do
				if (distanceXY(npc, x, y) == range) then
				--if (distanceSquare(npc, mobBlocks[i], range)) then
					npc:sendAnimationXY(135, x, y, 0)
					npc:sendAnimationXY(103, x, y, 0)

					local hitPC = npc:getObjectsInCell(npc.m, x, y, BL_PC)[1]

					if (hitPC ~= nil) then
						hitPC:spawn(183, hitPC.x, hitPC.y, 1)	
						local D = hitPC:getObjectsInCell(hitPC.m, hitPC.x, hitPC.y, BL_MOB)
						Mob(D[1].ID):setDuration("crystal_lux",dura)
						Mob(D[1].ID):setDuration("freeze",dura2)
						Mob(D[1].ID).paralyzed = true
						Mob(D[1].ID).side = hitPC.side
						Mob(D[1].ID):sendSide()
					end
					
					npc.registry["spell_counter"] = npc.registry["spell_counter"] + 1
				end
			end
		end

	npc.registry["spell_range"] = range + 1
	--npc:talk(1,"Test "..npc.registry["spell_range"])
end,

endAction = function(npc, player)
	npc:delete()
end
}

crystal_lux = {
while_cast = function(block)
	block:sendAnimation(135, 9999)
	return
end,
}