masked_greenBandit = {
on_spawn = function(mob)
	mob.side = math.random(0, 3)
end,

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob, target)
	local oldside = mob.side
	local checkmove = math.random(0,10)
	--local targetItem
	--local itemFound
	local bomb = 0
	local moved = false
	local npc
	--mob.newMove = 700

	if (mob.target ~= 0) then
		--mob:talk(2,"Returning: "..target.name)
	end

	if (mob.target == 0) then
		mob.returning = false
	end
	--mob:talk(2,"Returning: "..mob.attacker)

	if (mob.returning == false) then
		local itemsFound = mob:getObjectsInArea(BL_ITEM)

		if (#itemsFound > 0) then
			for i = 1, #itemsFound do
				if (itemsFound[i].id == 160) then
					mob.target = itemsFound[1].ID

					local block = mob:getBlock(mob.target)
					if (block ~= nil) then
						target = block
					end
					--mob:talk(2,"Found Item: "..target.name)
					local attackerm = mob:getObjectsInCell(mob.m, target.x, target.y, BL_PC)
					if (#attackerm ~= 0) then
						mob.attacker = attackerm[1].ID
					end
					--mob.target = itemsFound[1].ID

					--local block = mob:getBlock(mob.target)
					--if (block ~= nil) then
					--	target = block
				--	end
					--itemFound == true
					mob.returning = true --returning = going to the item
					moved = toXYdirect(mob, target.x, target.y)
				end
			end
		else
			mob.returning = false
		end
	end

	if (mob.returning == true) then
		if (mob.x == target.x and mob.y == target.y) then
			local itemcell = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_ITEM)

				if (itemcell[2] ~= nil) then
					if (itemcell[2].id == 2) then
						mob:sendAnimationXY(103, mob.x, mob.y, 1)
						mob:playSound(370)
						bomb = 1
					end
				end

					if (bomb == 1) then
						mob:dropItem(345, 1, 2)
						mob:addNPC("ded_bandito", mob.m, mob.x, mob.y, 500, 4000)
						local npc2 = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_NPC)[1]
						local blockPC = mob:getObjectsInArea(BL_PC)

							if (#blockPC > 0) then
									npc2.subType = 0
									npc2.look = 2000
									for i = 1, #blockPC do
										blockPC[i]:refresh()
									end
							end
						npc2:talk(1,"Bandit: Ack! An acorn bomb, nooo! Mgwaaaahh..")
						mob:removeHealthWithoutDamageNumbers(mob.health)
						--mob:removeHealthExtend(mob.health, 1, 1, 1, 1, 0)
					end

				if (itemcell[1] ~= nil) then
					if (itemcell[1].id == 160 and bomb == 0) then
						--mob:talk(2,"Item!")
						mob:sendAction(4, 20)
						itemcell[1]:delete()
					end
				end

		else
			--mob.newMove = 1000
			--if player is in front of me, use repelling arrow
			local pcTarget = getTargetFacing(mob, BL_PC)
			local itemTarget = getTargetFacing(mob, BL_ITEM)
			if (pcTarget ~= nil and itemTarget ~= nil) then
				mob:sendAction(1, 20)
				mob:playSound(354)
				canPush_itemno(mob, pcTarget)
				return
			end
			if (moved == false) then
				moved = toXYdirect(mob, target.x, target.y)
			end
		end
	end

	if (mob.returning == false) then

			if ((mob.x - mob.startX) >= 5) then
				mob.side=3
				mob:sendSide()
				mob:move()
				return
			end
			if ((mob.x - mob.startX) <= -5) then
				mob.side=1
				mob:sendSide()
				mob:move()
				return
			end
			if ((mob.y - mob.startY) >= 5) then
				mob.side=0
				mob:sendSide()
				mob:move()
				return
			end
			if ((mob.y - mob.startY) <= -5) then
				mob.side=2
				mob:sendSide()
				mob:move()
				return
			end

			if(checkmove >= 4) then
				mob.side=math.random(0,3)
				mob:sendSide()
				if(npc.side == oldside) then
					mob:move()
				end
			else
				mob:move()
			end
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

ded_bandito = {
action = function(npc)

end,

endAction = function(npc)
	local itemcell = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_ITEM)
		for i = 1, #itemcell do
			if (itemcell[i].id == 160 or itemcell[i].id == 2 or itemcell[i].id == 345) then
				if (itemcell[i] ~= nil) then
					itemcell[i]:delete()
				end
			end
		end
	npc:delete()
end,
}