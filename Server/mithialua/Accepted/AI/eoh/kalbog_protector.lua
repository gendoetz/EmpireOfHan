kalbog_protector = {
on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	if (mob:hasDuration("mark_of_death")) then
		attacker.damage = attacker.damage * 2
	end
	
	if (attacker.blType == BL_PC) then
		if (attacker.registry["dps_potion"] > 0) then
			attacker.dmgDealt = attacker.dmgDealt + attacker.damage
		end
	end

	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end
	
	mob.attacker = attacker.ID
	--mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)
	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)
	local grounditem = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_ITEM)

	if (mob.paralyzed == true or mob.sleep ~= 1) then
			if (mob:hasDuration("fae_dustf")) then
				return
			end
			mob:sendAnimation(10)
			mob.paralyzed = false
			mob.sleep = 1
	end

	for i = 1, #grounditem do
		if (grounditem[i].id == 165) then
			grounditem[i]:delete()
			mob.paralyzed = true
			mob:sendAnimation(58, 0)
			mob:setDuration("fae_dustf", 20000, 0, 1)
			mob:talk(0,"Kalbog Forest Golem: Urrg! *The golem seems to be dazed and confused*")
			return
		end
	end

	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false and target == nil) then
		--mob.newMove = 250
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
		--mob:talk(1,"Cycle Move")
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
end
}

fae_dustf = {
cast = function(block)
	
end,

recast = function(block)
	block.paralyzed = true
end,

uncast = function(block)
	block.paralyzed = false
end,
}

faerie_kbf = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob,attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,
	
move = function(mob,target)
	mob_ai_basic.move(mob, target)
end,

attack=function(mob,target)
	mob_ai_basic.attack(mob, target)
end,

after_death=function(mob, player)
	mob:sendAnimationXY(204, mob.x, mob.y, 1)
end
}