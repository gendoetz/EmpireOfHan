taowood_tree = { 
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	local block = getTargetFacing(attacker, BL_MOB)
	local axe = attacker:getEquippedItem(EQ_WEAP)
	
	if (attacker.critChance == 0) then
		return
	end
	
	if (block.id == mob.id) then
		if (axe ~= nil and axe.id == 10) then
			attacker:flushDuration(1)
			mob:addHealth(-10)
			
			if (math.random(3) == 1) then
				attacker:addItem("taowood_log", 1)
				attacker:playSound(355)	
			end					
		else
			attacker:sendMinitext("Your efforts result in nothing.")
		end
	end
end,

move = function(mob,target)

end,

attack=function(mob,target)

end,

on_spawn = function(mob)
	local hasMoved = false
	
	if(mob.m == 1) then
		repeat
			local newX = math.random(3, 13)
			local newY = math.random(30, 47)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
			local mobCheck = mob:getObjectsInCell(mob.m, newX, newY, BL_MOB)		
			
			if (passCheck == 0 and #mobCheck == 0 and tileCheck == 43) then
				mob:warp(mob.m, newX, newY)
				hasMoved = true
			end
		until hasMoved
	end	
end,
	
after_death = function(mob, player)

	if(not player:hasEquipped({"simple_axe"})) then
		player:sendMinitext("You cannot cut wood without proper wood cutting tools.")
		return
	end
		player:addItem("ash_log", 1)
		player:playSound(45)
end
}
