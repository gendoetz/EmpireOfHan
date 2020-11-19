sky_palace_doors = {
click = async(function(player, mob)
	local manuf = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.dialogType = 0
	player.npcGraphic = manuf.graphic
	player.npcColor = manuf.color

	player:dialogSeq({manuf, "Test."}, 1)
	mob:warp(mob.startM, mob.startX, mob.startY)
end),

on_attacked = function(mob, attacker)
	local test

	if (attacker.side == 0) then
		mob.side = 0
		mob:move()
	end

	if (attacker.side == 1) then
		mob.side = 1
		mob:move()
	end

	if (attacker.side == 2) then
		mob.side = 2
		mob:move()
	end

	if (attacker.side == 3) then
		mob.side = 3
		mob:move()
	end

	if (mob.protection == 1) then
		return
	end
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)
	
end,

attack=function(mob,target)
	
end
}
