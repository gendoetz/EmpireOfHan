statue_puz1 = {
on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.dialogType = 0
	player.npcGraphic = t.graphic
	player.npcColor = t.color

	player:dialogSeq({t, "You may use the powerful magic of the enchanted pillar to go back in time. Doing so will alter the room's passageway doors and other pillars."}, 1)
	local choice = player:menuString("Are you certain you wish to alter time?", {"Yes", "No"})
	if (choice == "Yes") then
		local findPillars = mob:getObjectsInSameMap(BL_MOB)

			for i = 1, #findPillars do
				if(findPillars[i].mobID == 223) then
					local pressurePlate = getTile(findPillars[i].m, findPillars[i].x, findPillars[i].y)
						if(pressurePlate == 38065) then
							local obj = getObject(findPillars[i].m, findPillars[i].x+2, findPillars[i].y-1)
							if(obj == 6451) then
								setObject(findPillars[i].m, findPillars[i].x+1, findPillars[i].y-1, 6448)
								setObject(findPillars[i].m, findPillars[i].x+2, findPillars[i].y-1, 6449)
							end
						end
						if(pressurePlate == 38051) then
							local obj2 = getObject(findPillars[i].m, findPillars[i].x-2, findPillars[i].y-1)
							if(obj2 == 6450) then
								setObject(findPillars[i].m, findPillars[i].x-1, findPillars[i].y-1, 6449)
								setObject(findPillars[i].m, findPillars[i].x-2, findPillars[i].y-1, 6448)
							end
						end
		
					findPillars[i]:warp(findPillars[i].startM, findPillars[i].startX, findPillars[i].startY)
				end
			end
		
	else
		player:dialogSeq({t, "You have chosen not to alter time."}, 1)
	end
end),

on_attacked = function(mob, attacker)

	if(not attacker:hasDuration("pillars_blessing")) then
		attacker:sendAnimation(71)
		attacker:playSound(77)
		attacker:setDuration("pillars_blessing",15000)
	end

	local pressurePlate = getTile(mob.m, mob.x, mob.y)

	if(pressurePlate == 38065) then
		local obj = getObject(mob.m, mob.x+2, mob.y-1)
		if(obj == 6451) then
			setObject(mob.m, mob.x+1, mob.y-1, 6448)
			setObject(mob.m, mob.x+2, mob.y-1, 6449)
		end
	end

	if(pressurePlate == 38051) then
		local obj2 = getObject(mob.m, mob.x-2, mob.y-1)
		if(obj2 == 6450) then
			setObject(mob.m, mob.x-1, mob.y-1, 6449)
			setObject(mob.m, mob.x-2, mob.y-1, 6448)
		end
	end

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


	local pressurePlate = getTile(mob.m, mob.x, mob.y)
		if(pressurePlate == 38065) then
			mob:sendAnimation(2, 0)
			local pressurePlate2 = mob:getObjectsInCell(mob.m, mob.x+3, mob.y, BL_MOB)
				if(pressurePlate2[1].mobID == 223) then
					setObject(mob.m, mob.x+1, mob.y-1, 6450)
					setObject(mob.m, mob.x+2, mob.y-1, 6451)
				end
		end

		if(pressurePlate == 38051) then
			mob:sendAnimation(2, 0)
			local pressurePlate2 = mob:getObjectsInCell(mob.m, mob.x-3, mob.y, BL_MOB)
				if(pressurePlate2[1].mobID == 223) then
					setObject(mob.m, mob.x-1, mob.y-1, 6451)
					setObject(mob.m, mob.x-2, mob.y-1, 6450)
				end
		end


	if (mob.protection == 1) then
		return
	end
end,
	
move = function(mob,target)
	
end,

attack=function(mob,target)
	
end
}

pillars_blessing = {
cast = function(player,target)
		
end,


while_cast = function(player, caster)
		if(player.state==1 or player.health==0) then
			player:setDuration("pillars_blessing",0)
			return
		end
		player:addHealth2(500)
		--player:sendHealth(0, 0)
end,

uncast = function(player,caster)
		if(player.health > 0) then
				player:sendAnimation(10)
				player:playSound(34)
			player:sendMinitext("Pillar's Blessing has faded.")
		else
			player:sendMinitext("Pillar's Blessing has faded.")
		end
end,    
}