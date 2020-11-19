lib_mobboss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)

	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end

	if (mob.registry["mob_phase"] == 1) then
		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	elseif (mob.registry["mob_phase"] >= 2 and mob.registry["mob_phase"] <= 4) then
		mob.attacker = attacker.ID
		attacker.damage = 0
	elseif (mob.registry["mob_phase"] == 5) then
		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	elseif (mob.registry["mob_phase"] >= 6 and mob.registry["mob_phase"] <= 8) then
		mob.attacker = attacker.ID
		attacker.damage = 0
	elseif (mob.registry["mob_phase"] == 9) then
		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	end
end,

on_spawn = function(mob)
	mob.registry["mob_phase"] = 1
end,

move = function(mob, target)
	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)

	--mob:talk(2,"Phase: "..mob.registry["mob_phase"])
	--mob:talk(1,"Cycle Move")
	if (target) then
		lib_mobboss.zap(mob, target)
	end

	if (mob.blind == true) then
		if (target) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
			--moved=FindCoords(mob,target)
			if(mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner) then
				--We are right next to them, so attack!
				mob:attack(target.ID)
			else
				return
			end
		else
			return
		end
		return
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false and target == nil) then
		--mob.newMove = 250
		mob.newMove = mob.baseMove + math.random(0, 1000)
		--mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove + math.random(0, 1000)
		--mob.deduction = mob.deduction + 1
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
		mob.returning = false
	end
end,

attack = function(mob, target)
	local moved
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		thunderjel_boss.move(mob, target)
		return
	end
	
	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
			if(mob.registry["mob_phase"] == 1 and mob.health <= 1016000) then
				lib_mobboss.spawn_phantom(mob)
				mob.registry["mob_phase"] = 2
			end

			if(mob.registry["mob_phase"] == 5 and mob.health <= 516000) then
				lib_mobboss.spawn_phantom(mob)
				mob.registry["mob_phase"] = 6
			end

			lib_mobboss.zap(mob, target)
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

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local inrange = {}
	local damage = math.random(10000, 15500)
	local aethers = math.random(6, 10)
	local range = 20
	local zaptarget

	if (mob.registry["mob_phase"] == 3) then
		damage = damage * 1.5
	elseif(mob.registry["mob_phase"] == 4) then
		damage = damage * 2
	elseif (mob.registry["mob_phase"] == 7) then
		damage = damage * 1.5
	elseif(mob.registry["mob_phase"] == 8) then
		damage = damage * 2
	end
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range and mobBlocks[i].state ~= 1) then
					table.insert(inrange, mobBlocks[i])
				end
			end
		end

			if (#inrange > 0) then
				rangeCheck = true
				target = mobBlocks[math.random(#inrange)]
			end


		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= (mob.registry["zapCastTime"] + aethers) and target.state ~= 1) then
			mob:playSound(727)
			target:sendAnimation(17, 0)
			mob:sendAction(1, 35)
			target:sendMinitext("Head Archivist casts Rip Earth on you.")
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			mob.registry["zapCastTime"] = os.time()
			--return true
		end

end,

spawn_phantom = function(mob)

	mob:talk(2,"**The Head Archivist becomes enraged**")
	broadcast(mob.m, "The Head Archivist summons dark phantoms from beyond the void!")

	mob:addNPC("phantom_portal", mob.m, 6, 6, 500, 0, 0)
	mob:addNPC("phantom_portal", mob.m, 11, 14, 500, 0, 0)
	mob:addNPC("phantom_portal", mob.m, 17, 7, 500, 0, 0)

	mob:spawn(256, 6, 6, 1)
	mob:spawn(256, 17, 9, 1)
	mob:spawn(256, 6, 15, 1)

end
}

phantom_portal = {
click = function(block, npc)
	local damage = block.maxHealth + 1
	if (block.blType == BL_MOB) then
		if (block.mobID == 256) then
			block:playSound(60)
			npc:delete()
			block:sendAnimationXY(393, block.x, block.y)
			local update_boss = block:getObjectsInMap(block.m, BL_MOB)
			if (#update_boss > 0) then
				for i = 1, #update_boss do
					if (update_boss[i].mobID == 255) then
						update_boss[i].registry["mob_phase"] = update_boss[i].registry["mob_phase"] + 1
					end
				end
			end
			block:delete()
		end
	end
end,

action = function(npc)
	local players = npc:getObjectsInMap(npc.m, BL_PC)

	if (#players > 0) then
		npc:sendAnimationXY(377, npc.x, npc.y, 2)
	else
		npc:delete()
	end
end,
}

lib_mobboss_sent = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	if(attacker.blType == BL_PC) then
		mob.attacker = attacker.ID
		attacker.damage = 0
	else
		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	end
end,

on_spawn = function(mob)
	local newX = math.random(-3, 3)
	local newY = math.random(-3, 3)
	local passCheck = getPass(mob.m, mob.startX + newX, mob.startY + newY)
	local mobCheck = mob:getObjectsInCell(mob.m, mob.startX + newX, mob.startY + newY, BL_MOB)

	if ((mob.startX + newX) > mob.xmax) then
		newX = 0
	end
	if ((mob.startY + newY) > mob.ymax) then
		newY = 0
	end

	if ((mob.startX + newX) < 0) then
		newX = 0
	end

	if ((mob.startY + newY) < 0) then
		newY = 0
	end

	if (passCheck == 0 and #mobCheck == 0) then
		mob:warp(mob.m, mob.startX + newX, mob.startY + newY)
	end
end,

move = function(mob, target)

	if (mob.paralyzed or mob.sleep ~= 1) then
		mob.paralyzed = false
		mob.sleep = 1
	end
	
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	mob_ai_basic.attack(mob, target)
end,
}