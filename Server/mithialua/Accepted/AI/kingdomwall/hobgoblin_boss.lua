hobgoblin_boss = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
local drop_per = math.random(1, 100)

if (drop_per <= 10) then
	mob:dropItemXY(40010, 1, mob.m, mob.x, mob.y, attacker.id)
end
if (drop_per >= 90) then
	mob:dropItemXY(40011, 1, mob.m, mob.x, mob.y, attacker.id)
end
end,

on_spawn = function(mob)
	mob.side = 2
	mob:sendSide()
end,

on_attacked = function(mob, attacker)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local rangeCheck = false
	
	if (not mob.paralyzed and mob.sleep == 1) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].owner == 0 or mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)) then
					rangeCheck = true
					break
				end
			end
		end
		
		if (attacker.critChance ~= 0 and ((attacker.x == mob.x and (attacker.y == mob.y + 1 or attacker.y == mob.y - 1))
		or (attacker.y == mob.y and (attacker.x == mob.x + 1 or attacker.x == mob.x - 1))) and not rangeCheck) then
			RunAway(mob, attacker)
		end
	end
	
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	local found
	local moved = false
	local oldside = mob.side
	local checkmove = math.random(0,10)

	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end

	hobgoblin_boss.unpara(mob)
	hobgoblin_boss.a_trap(mob, target)

	if(math.random(0,3) == 1) then
		hobgoblin_boss.heal(mob)
	end
	
	if (target.m == mob.m) then
		moved = hobgoblin_boss.zap(mob, target)
	end
	
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
		
	else
		if (mob.target > 0) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
			end
		end
	
		if (mob.state ~= MOB_HIT and mob.owner == 0 and not moved) then
			if (checkmove >= 4) then
				mob.side = math.random(0, 3)
				mob:sendSide()
				if (mob.side == oldside) then
					mob:move()
				end
			else
				mob:move()
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.returning = false
	end
end,

attack = function(mob, target)
	mob.state = MOB_ALIVE
	hobgoblin_boss.move(mob, target)
end,

zap = function(mob, target)
	local mobBlocks = mob:getObjectsInArea(BL_PC)
	local rangeCheck = false
	local damage = math.random(250, 500)
	local aethers = math.random(2, 3)
	local range = 20
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = true
					break
				end
			end
		end
		if (rangeCheck and target ~= nil and distance(mob, target) <= range
			and os.time() >= mob.registry["zapCastTime"] + aethers) then
			mob:sendAction(1, 20)
			mob:playSound(118)
			target:sendAnimation(146, 0)
			target.attacker = mob.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			FindCoords(mob, target)
			mob.registry["zapCastTime"] = os.time()
			return true
		elseif (rangeCheck) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= range) then
					rangeCheck = false
					break
				end
			end
			
			if (rangeCheck) then
				FindCoords(mob, mobBlocks[math.random(#mobBlocks)])
				return true
			end
		end

end,

a_trap = function(mob, target)
	local aethers = math.random(2, 4)

	local replacemsg = {"Chutac Kikini: Me get you, you go SQUISH!",
	"Chutac Kikini: You no brave, you stupid!",
	"Chutac Kikini: You die faster!!"}

	local rmess = math.random(#replacemsg)
	--local xrange = math.random(1, 15)
	--local yrange = math.random(4, 11)
	if (target ~= nil and os.time() >= mob.registry["hobgoblintrapcast"] + aethers) then
			if(math.random(0,6) == 0) then
			mob:talk(0,""..replacemsg[rmess])
			end
		if (mob.side == 1) then
			local newX = mob.x + math.random(2, 4)
			local newY = mob.y
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 1567 and (newX >= 0 and newX <= 23) and (newY >= 36 and newY <= 59)) then
					mob:addNPC("hobgoblin_trap", mob.m, newX, newY, 0, 80000, 0)
					--mob:dropItemXY(428, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 3) then
			local newX = mob.x - math.random(2, 4)
			local newY = mob.y
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 1567 and (newX >= 0 and newX <= 23) and (newY >= 36 and newY <= 59)) then
					mob:addNPC("hobgoblin_trap", mob.m, newX, newY, 0, 80000, 0)
					--mob:dropItemXY(428, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 0) then
			local newX = mob.x
			local newY = mob.y - math.random(2, 4)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 1567 and (newX >= 0 and newX <= 23) and (newY >= 36 and newY <= 59)) then
					mob:addNPC("hobgoblin_trap", mob.m, newX, newY, 0, 80000, 0)
					--mob:dropItemXY(428, 1, mob.m, newX, newY, 1)
				end
		elseif (mob.side == 2) then
			local newX = mob.x
			local newY = mob.y + math.random(2, 4)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
				if (passCheck == 0 and tileCheck == 1567 and (newX >= 0 and newX <= 23) and (newY >= 36 and newY <= 59)) then
					mob:addNPC("hobgoblin_trap", mob.m, newX, newY, 0, 80000, 0)
					--mob:dropItemXY(428, 1, mob.m, newX, newY, 1)
				end
		end
		mob.registry["hobgoblintrapcast"] = os.time()
		--addSpotTrap(mob, mob.m, mob.x, mob.y)
	end
end,

heal = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local healTargets = {} 
	local target = mob
	local heal = math.random(2000, 3500)
	
	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 117 or mobBlocks[i].mobID == 118)
			and mobBlocks[i].health ~= mobBlocks[i].maxHealth) then
				table.insert(healTargets, mobBlocks[i])
			end
		end
	end
	
	if (#healTargets > 0) then
		for i = 1, #healTargets do
			if (healTargets[i].health / healTargets[i].maxHealth < target.health / target.maxHealth) then
				target = healTargets[i]
			end
		end
	end
	
	if(mob.registry["sequence"] < 0) then
		target.attacker = mob.ID
		mob:sendAction(6, 40)
		target:sendAnimation(5)
		mob:playSound(708)
		target:addHealthExtend(heal, 0, 0, 0, 0, 0)
		mob.registry["sequence"] = mob.registry["sequence"] + 1
		
		if(target.health >= (target.maxHealth - 200)) then
			mob.registry["sequence"] = 0
		end
	end
	
	if (target.health <= (target.maxHealth - target.maxHealth/3)) then
		mob.registry["sequence"] = -math.random(1,2)
	end

end,


unpara = function(mob)
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local target = mob
	local aethers = math.random(2,5)
	
	if(os.time() >= mob.registry["zapCastTime"] + aethers) then
		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if (mobBlocks[i].ID ~= mob.ID and distance(mob, mobBlocks[i]) <= 10 and (mobBlocks[i].mobID == 158 or mobBlocks[i].mobID == 159)
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

hobgoblin_trap = {
cast = function(mob)
	local aether = math.random(5, 8)

	if (target ~= nil and os.time() >= mob.registry["hobgoblintrapcast"] + aethers) then
		mob:sendAction(6, 20)
		mob:addNPC("hobgoblin_trap", mob.m, mob.x, mob.y, 0, 3600000, mob.mobID)
		mob.registry["hobgoblintrapcast"] = os.time()
		addSpotTrap(mob, mob.m, mobr.x, mob.y)
	end
end,

click = function(block, npc)
	local damage = 800
	--local apple = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_ITEM)
	local trapstacks = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_NPC)
	--local duration = 10000
	local owner = npc:getBlock(npc.owner)
	
	--if (owner == nil or block:hasDuration("hobgoblin_trap")) then
	--	return
	--end
	
	--damage = damage * owner.level

	if (block.blType == BL_PC) then
		if (block.state ~= 1) then
		--block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--for i = 1, #apple do
		--	if (apple[i].id == 428) then
		--		apple[i]:delete()
		--	end
		--end
		block:playSound(710)
		block:sendAnimation(127, 0)
		--block:talk(0,"I just deleted 1 trap"..#trapstacks..".")
		damage = damage * #trapstacks
		block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		if (#trapstacks > 0) then
		for i = 1, #trapstacks do
			if (trapstacks[i].yname == "hobgoblin_trap") then
				trapstacks[i]:delete()
			end
		end
		end
		block:sendMinitext("You are damaged by a hobgoblin trap!")
		--block.attacker = owner.id
		--block:setDuration("hobgoblin_trap", duration)
		--ERRORS for some reason block:calcStat()
		--block:sendMinitext("A wicked apple has exploaded on you.")
		--removeTrap(npc)
		end
	end
end,

endAction = function(npc, owner)
	--local apple = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_ITEM)
	--for i = 1, #apple do
	--		if (apple[i].id == 428) then
	--			apple[i]:delete()
	--		end
	--end
	removeTrap(npc)
end,

recast = function(block)

end,

uncast = function(block)

end
}