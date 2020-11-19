thunderjel_boss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local found
	local moved=true
	local oldside = mob.side
	local checkmove = math.random(0,10)

	--mob:talk(1,"Cycle Move")
	if (target) then
		thunderjel_boss.unpara(mob)
		thunderjel_boss.zap(mob, target)
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
		thunderjel_boss.zap(mob, target)
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
	local damage = math.random(3200, 3550)
	local aethers = math.random(10, 20)
	local range = 20
	local zaptarget
	local duration = 15000
	
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
			mob:playSound(737)
			target:sendAnimation(143, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			if (not target:hasDuration("electronize") and target.state ~= 1) then
				target:setDuration("electronize", duration)
			end
			mob.registry["zapCastTime"] = os.time()
			--return true
		end

end,

unpara = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local target = mob
	local aethers = math.random(2,5)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 214 or mobBlocks[i].mobID == 215)
				and mobBlocks[i].paralyzed == true) then
					target = mobBlocks[i]
					target:sendAnimation(10)
					target.paralyzed = false
					return
				end
			end
		end

	end
end
}

electronize = {
while_cast = function(block)

	if (block.state == 1) then
		block:setDuration("electronize", 0)
		return
	end

	local damage = math.random(2200, 2500)

	--block:talk(2,"test")

	--block:talk(2,"Zippy Zap from:"..caster.ID)
	block:playSound(737)

	block:sendAnimation(143, 2)
	block.attacker = block.ID
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)

end,
}