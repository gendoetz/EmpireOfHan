escort_mob = {
click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	if ((mob.owner == 0 or mob.owner == player.id) and player.quest["rQ_KnightEscort"] == 1) then
		local choice = player:menuString3("*The little girl has tears in her eyes*\n\nI have lost my papa!!", {"Follow me, I'll help you!", "I'm busy..."})
		if (choice == "Follow me, I'll help you!") then
			mob.registry["mob_quest_timer"] = os.time() --set time start
			local D = player:getObjectsInCell(mob.m, mob.x, mob.y, BL_MOB)
			D[1].owner = player.id
			D[1].target = player.id
			D[1].summon = true
			D[1].newMove = 500
		elseif (choice == "I'm busy...") then
			local D = player:getObjectsInCell(mob.m, mob.x, mob.y, BL_MOB)
			D[1].owner = 0
			D[1].target = 0
			D[1].summon = true
			D[1].newMove = 3000
		elseif (choice == "Test") then
			mob:spawn(182, mob.x, mob.y - 1, 1)
			mob:spawn(182, mob.x, mob.y + 1, 1)
			local D = mob:getObjectsInArea(BL_MOB)
			for i = 1, #D do
				if(D[i].mobID == 182) then
					D[i].owner = mob.ID
					D[i].target = mob.ID
					--D[i]:talk(0, "My id: "..mob.ID)
				end
			end

		end
	else
		player:dialogSeq({t, "The little girl seems to be following "..Player(mob.owner).name.."."}, 1)
	end

end),

on_spawn = function(mob)
	--mob.registry["mob_life_timer"] = os.time()
	mob.newMove = 3000
	mob.registry["gob_ambush_timer"] = 0
end,

on_healed = function(mob, healer)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
	if (attacker.blType == BL_MOB) then
		mob.attacker = attacker.ID
		mob:sendHealth(attacker.damage, attacker.critChance)
		attacker.damage = 0
	else
		mob.attacker = mob.owner
		mob.target = mob.owner
	end
end,

after_death = function(mob, attacker, block)

end,
	
move = function(mob, target)
		local found
		local moved=true
		local oldside = mob.side
		local checkmove = math.random(0,10)
		local quest_duration = 120


		if (mob.registry["gob_ambush_timer"] == 0 and (mob.x > 30 and mob.y < 67)) then
			mob:spawn(182, mob.x, mob.y - 1, 1)
			mob:spawn(182, mob.x, mob.y + 1, 1)
			local D = mob:getObjectsInArea(BL_MOB)
			if (#D > 0) then
				for i = 1, #D do
					if(D[i].mobID == 182) then
						D[i].owner = mob.ID
						D[i].target = mob.ID
					end
				end
				D[1]:talk(0, "Goblin Ambusher: Wuga-duga!")
			end
			mob.registry["gob_ambush_timer"] = 1
		end

		if (mob.registry["gob_ambush_timer"] == 1 and (mob.x < 30 and mob.y < 57)) then
			mob:spawn(182, mob.x, mob.y - 1, 1)
			mob:spawn(182, mob.x, mob.y + 1, 1)
			local D = mob:getObjectsInArea(BL_MOB)
			if (#D > 0) then
				for i = 1, #D do
					if(D[i].mobID == 182) then
						D[i].owner = mob.ID
						D[i].target = mob.ID
						--D[i]:talk(0, "My id: "..mob.ID)

					end
				end
				D[1]:talk(0, "Goblin Ambusher: Gook gookit gook!")
			end
			mob.registry["gob_ambush_timer"] = 2
		end

		--mob:talk(1,"Cycle Move")
		if (mob.registry["mob_quest_timer"] ~= 0) then
			if (os.time() > mob.registry["mob_quest_timer"] + quest_duration) then
				--mob:talk(0, "You have taken too long!")
				mob:warp(mob.startM, mob.startX, mob.startY)
				mob.registry["mob_quest_timer"] = 0
				mob.registry["gob_ambush_timer"] = 0
				mob.owner = 0
				mob.target = 0
				mob.newMove = 3000
				return
			end
		end

		if (mob.paralyzed == true or mob.sleep ~= 1) then
			return
		end

		if (mob.blind == true) then
			if (target) then
				--threat.calcHighestThreat(mob)
				--local block = mob:getBlock(mob.target)
				--if (block ~= nil) then
				--	target = block
				--end
				--moved=FindCoords(mob,target)
				--if(mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner) then
					--We are right next to them, so attack!
					--mob:attack(target.ID)
				--else
				--	return
				--end
			else
				return
			end
			return
		end
		
		if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false and target == nil) then
			--mob.newMove = 250
			--mob.newMove = mob.baseMove
			--mob.deduction = mob.deduction - 1
			mob.returning = true
		elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
			--mob.newMove = mob.baseMove
			--mob.deduction = mob.deduction + 1
			mob.returning = false
		end

		if (mob.returning == true) then
			found = toStart(mob, mob.startX, mob.startY)
			--mob:talk(1,"Cycle Move")
		else
			if (mob.owner == 0 or mob.owner > 1073741823) then
				--threat.calcHighestThreat(mob)
				
			end
			if (mob.owner ~= 0) then
				local block = mob:getBlock(mob.owner)
				if (block == nil) then
					--mob:talk(0, "My owner has disappeared!")
					mob:warp(mob.startM, mob.startX, mob.startY)
					mob.owner = 0
					mob.target = 0
					mob.registry["mob_quest_timer"] = 0
					mob.registry["gob_ambush_timer"] = 0
					mob.newMove = 3000
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
						moved=SummonFindCoords(mob,target)
					end
					
					if((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner) then
						mob.state = MOB_HIT
					end
				end
			end
		end
		
		if (found == true) then
			--mob.newMove = 0
			mob.returning = false
		end
end,

attack=function(mob,target)
	mob.state = MOB_ALIVE
	escort_mob.move(mob, target)
end,

}

escort_attacker1 = {
on_spawn = function(mob)
	--mob.registry["mob_life_timer"] = os.time()
end,

on_healed = function(mob, healer)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end
	
	mob.attacker = attacker.ID
	mob.target = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,

after_death = function(mob, attacker, block)

end,
	
move = function(mob,target)
		local found
		local moved=true
		local oldside = mob.side
		local checkmove = math.random(0,10)
		local quest_duration = 10

		--mob:talk(1,"Cycle Move")

		if (mob.paralyzed == true or mob.sleep ~= 1) then
			return
		end

		if (mob.blind == true) then
			if (target) then
				--threat.calcHighestThreat(mob)
				--local block = mob:getBlock(mob.target)
				--if (block ~= nil) then
				--	target = block
				--end
				--moved=FindCoords(mob,target)
				--if(mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner) then
					--We are right next to them, so attack!
					mob:attack(target.ID)
				--else
				--	return
				--end
			else
				return
			end
			return
		end
		
		if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false and target == nil) then
			--mob.newMove = 250
			--mob.newMove = mob.baseMove
			--mob.deduction = mob.deduction - 1
			mob.returning = true
		elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
			--mob.newMove = mob.baseMove
			--mob.deduction = mob.deduction + 1
			mob.returning = false
		end

		if (mob.returning == true) then
			found = toStart(mob, mob.startX, mob.startY)
			--mob:talk(1,"Cycle Move")
		else
			if (mob.owner == 0 or mob.owner > 1073741823) then
				--threat.calcHighestThreat(mob)
				
			end

			if (mob.owner ~= 0) then
				local block = mob:getBlock(mob.owner)
				if (block == nil) then
					--mob:talk(0, "My owner has disappeared!")
					mob.owner = 0
					mob.target = 0
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
						moved=SummonFindCoords(mob,target)
					end
					
					if((moved or mob:moveIntent(target.ID) == 1) and mob.target) then
						mob.state = MOB_HIT
					end
				end
			end
		end
		
		if (found == true) then
			--mob.newMove = 0
			mob.returning = false
		end
end,

attack=function(mob,target)
	local moved
		
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		escort_attacker1.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (target) then
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=SummonFindCoords(mob,target)
		if(moved and mob.target) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,
}