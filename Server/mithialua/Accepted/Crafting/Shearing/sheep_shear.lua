sheep_shear_old = { 
on_healed = function(mob, healer)

end,

on_attacked = function(mob, player)
	local block = getTargetFacing(player, BL_MOB)
	local shears = player:getEquippedItem(EQ_WEAP)
	local spoilchance = 0
	
	if (player.critChance == 0) then
		return
	end

	if (block.id == mob.id) then
		if (shears ~= nil and shears.id == 188) then
			--player:flushDuration(1)
				mob:addHealth(-10)
			--Calculate spoils based on mining skill 840
				if (player.registry["shearer"] < 25) then
					spoilchance = math.random(5)
				elseif (player.registry["shearer"] >= 25 and player.registry["shearer"] < 220) then
					spoilchance = math.random(5)
				elseif (player.registry["shearer"] >= 220 and player.registry["shearer"] < 840) then
					spoilchance = math.random(3)
				elseif (player.registry["shearer"] >= 840) then
					spoilchance = math.random(2)
				end
				if (spoilchance == 1) then
					player:addItem("wool", 1)
					player:playSound(709)	
				end			
		else
			player:sendMinitext("You can not gather wool without the proper tools.")
		end
	end
end,

move = function(mob,target)
	mob_ai_basic.move(mob, healer)
end,

attack=function(mob,target)
mob_ai_basic.move(mob, healer)
end,

on_spawn = function(mob)
	--[[local hasMoved = false
		repeat
			local newX = math.random(0, mob.xmax)
			local newY = math.random(0, mob.ymax)
			local passCheck = getPass(mob.m, newX, newY)
			local tileCheck = getTile(mob.m, newX, newY)
			local mobCheck = mob:getObjectsInCell(mob.m, newX, newY, BL_MOB)		
			
			if (passCheck == 0 and #mobCheck == 0 and tileCheck == 36301) then
				mob:warp(mob.m, newX, newY)
				hasMoved = true
			end
		until hasMoved]]--
end,
	
after_death = function(mob, player)
	local rand = math.random(100)
	local gem = math.random(100)
	local skillAdded = math.random(2, 3)
	local skillAddChance = math.random(4)
	local bonus = math.random(0, player.registry["shearer"] + 1) / (player.registry["shearer"] + 1)
	local improveChance = ((player.registry["shearer"] / 30) + 50)
	local craftlevel = "Beginner"
	
	if(not player:hasEquipped({"shears_g1"})) then
		player:sendMinitext("You can not gather wool without the proper tools.")
		return
	end

	player:addItem("wool", 1)
	player:playSound(709)

	if (improveChance > 85) then 
		improveChance = 85
	end

	if (improveChance > rand) then
		if (bonus > 0.85) then
			bonus = 3
		elseif (bonus > 0.66) then
			bonus = 2
		elseif (bonus > 0.33) then
			bonus = 1
		end
		
		skillAdded = skillAdded + bonus

		if (skillAddChance > 1) then
			player.registry["shearer"] = player.registry["shearer"] + (skillAdded * 2)
		end
		
		if (player.registry["shearer"] < 25) then
			craftlevel = "Aptitude I"
		elseif (player.registry["shearer"] >= 25 and player.registry["shearer"] < 220) then
			craftlevel = "Aptitude II"
		elseif (player.registry["shearer"] >= 220 and player.registry["shearer"] < 840) then
			craftlevel = "Aptitude III"
		elseif (player.registry["shearer"] >= 840 and player.registry["shearer"] < 2200) then
			craftlevel = "Aptitude IV"
		elseif (player.registry["shearer"] >= 2200 and player.registry["shearer"] < 6400) then
			craftlevel = "Aptitude V"
		elseif (player.registry["shearer"] >= 6400 and player.registry["shearer"] < 18000) then
			craftlevel = "Aptitude VI"
		elseif (player.registry["shearer"] >= 18000 and player.registry["shearer"] < 50000) then
			craftlevel = "Aptitude VII"
		elseif (player.registry["shearer"] >= 50000 and player.registry["shearer"] < 124000) then
			craftlevel = "Aptitude VIII"
		elseif (player.registry["shearer"] >= 124000 and player.registry["shearer"] < 237000) then
			craftlevel = "Aptitude IX"
		elseif (player.registry["shearer"] >= 237000 and player.registry["shearer"] < 400000) then
			craftlevel = "Aptitude X"
		elseif (player.registry["shearer"] >= 400000 and player.registry["shearer"] < 680000) then
			craftlevel = "Aptitude XI"
		elseif (player.registry["shearer"] >= 680000) then
			craftlevel = "Master"
		end

		if (player.registry["shearer"] < 680000) then
			player:removeLegendbyName("shearer")
			player:addLegend("Shearing: "..craftlevel, "shearer", 7, 128)
		elseif (player.registry["shearer"] >= 680000) then
			player:removeLegendbyName("shearer")
			player:addLegend(craftlevel.." Shearer", "shearer", 191, 128)
		end

	end
end
}