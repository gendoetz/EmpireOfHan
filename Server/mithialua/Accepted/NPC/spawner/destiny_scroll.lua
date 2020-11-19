destiny_scroll = {
use = function(player)

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("You can't use this here.")
		return
	end

		player:sendAction(6, 20)
		player:playSound(1)
		player:removeItem("destiny_scroll",1)
		--player:spawn(168, player.x, player.y, 1)
		--local D = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		--Mob(D[1].ID).owner = player.id
		--Mob(D[1].ID).target = player.id
		--Mob(D[1].ID).summon = true
		player:addNPC("spawn_booster", player.m, player.x, player.y, 60000, 1800000, player.ID) --1800000 Timer for 30 mins
end
}

spawn_booster = {
action = function(npc)
	local owner = npc:getBlock(npc.owner)

	if (owner == nil) then
		npc:delete()
		return
	end

	if (owner.m ~= npc.m) then
		npc:delete()
		return
	end
	if (owner.m == npc.m) then
		npc:msg(4, "Enemies appear around you...", owner.ID)
		npc:sendAnimationXY(2, npc.x, npc.y, 0)
		npc:respawn(npc.m)
	end
end,

endAction = function(npc, owner)
	npc:delete()
	return
end,
}