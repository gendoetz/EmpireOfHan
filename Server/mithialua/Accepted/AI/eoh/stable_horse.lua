stable_horse = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob,attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,
	
move = function(mob,target)
	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	--if (math.abs(mob.x - mob.startX) >= 15 or math.abs(mob.y - mob.startY) >= 15) then
		--mob:warp(mob.startM, mob.startX, mob.startY)
	--end
		if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false and target == nil) then
			--mob.newMove = 250
			--mob.newMove = mob.baseMove + math.random(0, 1000)
			--mob.deduction = mob.deduction - 1
			mob.returning = true
		elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
			--mob.newMove = mob.baseMove + math.random(0, 1000)
			--mob.deduction = mob.deduction + 1
			mob.returning = false
		end

		if(distanceXY(mob, mob.startX, mob.startY) >= 10) then
			mob.returning = false
		end

		if (mob.returning == true) then
			found = toStart(mob, mob.startX, mob.startY)
			--mob:talk(1,"Cycle Move")
		else

		if(checkmove >= 4) then
			mob.side=math.random(0,3)
			mob:sendSide()
			if(mob.side == oldside) then
				mob:move()
			end
		else
			mob:move()
		end

	end
end,

attack=function(mob,target)
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	local amt = mob.maxHealth / math.random(40, 75)

	if (mob.health < mob.maxHealth) then
		if (mob.health + amt >= mob.maxHealth) then
			mob.health = mob.maxHealth
		else
			mob.health = mob.health + amt
		end
	end

end,

on_mount = function(player, mob)
	if (mob.lookColor == 5) then
		player.disguise = 28
	end
	--elseif (mob.lookColor == 4) then
		--player.disguise = 27
	--elseif (mob.lookColor == 9) then
		--player.disguise = 32
	--end
	
	--mob:removeHealthWithoutDamageNumbers(2000, 1)
	--mob:addHealth(-10)
	--mob.last_death = curTime()
	--mob.health = 0
	--mob.state = 1
	mob:warp(5000, 0, 2)
	--local players_around = player:getObjectsInArea(BL_PC)
	--for i = 1, #players_around do
	--	players_around[i]:refresh()
	--end
	player.registry["mount_type"] = 1
	player.registry["store_mount_id"] = mob.ID
	player.state = 3
	player.speed= 45
	player:updateState()
	player:sendStatus()
	--player:sendStatus()
	--player:updateState()
end
}
