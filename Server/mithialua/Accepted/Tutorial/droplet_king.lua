droplet_king = {	
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	local block = getTargetFacing(attacker, BL_MOB)
	local sword = attacker:getEquippedItem(EQ_WEAP)
	
	if (attacker.critChance == 0) then
		return
	end
	
	if (block.id == mob.id) then
		if (sword ~= nil and sword.id == 11) then
			attacker:flushDuration(1)
			mob:addHealth(-20)		
		else
			attacker:sendMinitext("Your weapon bounces off the little creature, you need a different weapon!")
		end
	end
end,

move = function(mob)
	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed == true or mob.sleep ~= 1) then
		return
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
	else
		if (mob.owner == 0 or mob.owner > 1073741823) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end
	
		if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
			if(checkmove >= 4) then
				mob.side=math.random(0,3)
				mob:sendSide()
				if(mob.side == oldside and not mob.snare and not mob.blind) then
					moved=mob:move()
				end
			elseif (not mob.snare and not mob.blind) then
				moved=mob:move()
			end
		else
			local owner = mob:getBlock(mob.owner)
			
			if (target == nil and owner ~= nil) then
				target = mob:getBlock(owner.target)
				mob.target = owner.target
			end
			
			if (target ~= nil) then
				if (not mob.snare and not mob.blind) then
					moved=FindCoords(mob,target)
				end
				
				if((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
					mob.state = MOB_HIT
				end
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	--[[local mobBlocks = mob:getObjectsInSameMap(BL_MOB)
	local ownedMobs = 0
	local maxOwnedMobs = 2
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].owner == mob.ID) then
				ownedMobs = ownedMobs + 1
			end
		end
	end
	
	if (ownedMobs < maxOwnedMobs) then
		for i = 1, 2 do
			local spawnMob = 5
			local spawnedMob
			local x
			local y
			
			repeat
				x = mob.x + math.random(0, 1)
				y = mob.y + math.random(0, 1)
			until ((x > 0 or y > 0) and getPass(mob.m, x, y) == 0 and (x < mob.xmax and y < mob.ymax))
			
			spawnedMob = mob:spawn(spawnMob, x, y, 1)[1]
			spawnedMob.owner = mob.ID
		end
	end]]--
end,

attack=function(mob,target)
	local moved
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=FindCoords(mob,target)
		if(moved and mob.target ~= mob.owner) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,

after_death = function(mob, player)
	for i = 1, #player.group do
		if (Player(player.group[i]).quest["tutorial"] == 8) then
			mob:sendAnimation(69)
			Player(player.group[i]).quest["tutorial"] = 9
		end
	end
	--if (player.quest["tutorial"] == 8) then
	--	mob:sendAnimation(69)
	--	player.quest["tutorial"] = 9
	--end
end
}