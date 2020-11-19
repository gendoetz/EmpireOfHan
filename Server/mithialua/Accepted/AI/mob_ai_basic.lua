mob_ai_basic = {

on_spawn = function(mob)
	mob.side = math.random(0, 3)
end,

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

	if (mob.mobID == 72 or mob.mobID == 73) then
		--Dont allow damage by arrows
		return
	end

	--mob:talk(1,"Test: "..mob.protection)
	if (mob.protection == 1) then
		return
	end

	if (mob.mobID == 70 or mob.mobID == 71) then
		if (mob.mobID == 70 and attacker.armorColor == 63) then
			attacker.damage = 20
		end

		if (mob.mobID == 71 and attacker.armorColor == 65) then
			attacker.damage = 20
		end

		if (mob.mobID == 70 and attacker.armorColor ~= 63) then
			attacker:sendMinitext("Are you trying to help the other team?")
			return
		end

		if (mob.mobID == 71 and attacker.armorColor ~= 65) then
			attacker:sendMinitext("Are you trying to help the other team?")
			return
		end
	end
	
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)
	if not (mob:hasDuration("fear")) then
		local found
		local moved=true
		local oldside = mob.side
		local checkmove = math.random(0,10)

		--mob:talk(1,"Cycle Move")

		if (mob.paralyzed == true or mob.sleep ~= 1) then
			return
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
	end
end,

fear = function(mob,target)
	if (mob.paralyzed == true or mob.sleep ~= 1) then
		return
	end
	
	local oldside = mob.side
	local checkmove = math.random(0,10)

	--if (math.abs(mob.x - mob.startX) >= 2 or math.abs(mob.y - mob.startY) >= 2) then
	--	mob:warp(mob.startM, mob.startX, mob.startY)
	--end

	if ((mob.x - mob.startX) >= 2) then
		mob.side=3
		mob:sendSide()
		mob:move()
		return
	end
	if ((mob.x - mob.startX) <= -2) then
		mob.side=1
		mob:sendSide()
		mob:move()
		return
	end
	if ((mob.y - mob.startY) >= 2) then
		mob.side=0
		mob:sendSide()
		mob:move()
		return
	end
	if ((mob.y - mob.startY) <= -2) then
		mob.side=2
		mob:sendSide()
		mob:move()
		return
	end

	if(checkmove >= 4) then
		mob.side=math.random(0,3)
		mob:sendSide()
		if(mob.side == oldside) then
			mob:move()
		end
	else
		mob:move()
	end
end,
	--[[on_hit=function(mob,target)
		
		if target then
				
				
				local moved=FindCoords(mob,target,1)
				if(moved) then
					--We are right next to them, so attack!	
					mob:attackIT(target,mob.might,mob.might/2)
				end
				-- mob:spawn(1,mob.x+1,mob.y,1,5)	
				
			
		end
		
	end,]]--
attack=function(mob,target)
	if not (mob:hasDuration("fear")) then
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
end
}
