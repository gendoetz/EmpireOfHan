tree_maple = {
on_healed = function(mob, healer)
end,

on_attacked = function(mob, player)
	local block = getTargetFacing(player, BL_MOB)
	local pick = player:getEquippedItem(EQ_WEAP)
	local spoilchance = 0
	
if (player.critChance == 0) then
	return
end

if (block.id == mob.id) then
	if (pick ~= nil and (pick.id == 40310)) then
		player.damage = 0
		local npcA = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
		local rQ_Druid = player.quest["rQ_Druid"]
		local TREE = {}
			TREE[1] = "Elm Tree"
			TREE[2] = "Birch Tree"
			TREE[3] = "Maple Tree"
			TREE[4] = "Cherry Tree"
			TREE[5] = "Oak Tree"
			TREE[6] = "Druid"

		if (rQ_Druid == 3) then
			player:sendAnimation(18, 1) --sends a spell animation
			mob:talk(0, "The "..mob.name.." begins to shake in "..player.name.."'s direction.")
			player.quest["rQ_Druid"] = player.quest["rQ_Druid"] + 1
			player:dialogSeq({npcA, ""..mob.name.." notices your blessing.\n\nThe "..TREE[(tonumber(rQ_Druid+1))].." awaits."}, 1)

		elseif (rQ_Druid >= 4) then
			player:dialogSeq({npcA, "You've already been noticed by the "..mob.name..".\n\n\nThe "..TREE[(tonumber(rQ_Druid))].." awaits."}, 1)			
		end			
	else
		if (pick ~= nil and (pick.id == 40094 or pick.id == 40095 or pick.id == 40096 or pick.id == 40097)) then
			--player:flushDuration(1)
			--Calculate spoils based on mining skill 840
			if (player.registry["forester"] < 2200) then
				spoilchance = 0
				player:sendMinitext("Your skill with foresting is too low to gather this branch.")
			elseif (player.registry["forester"] >= 2200 and player.registry["forester"] < 6400) then
				spoilchance = math.random(5)
				mob:addHealth(-10)
			elseif (player.registry["forester"] >= 6400 and player.registry["forester"] < 18000) then
				spoilchance = math.random(5)
				mob:addHealth(-10)
			elseif (player.registry["forester"] >= 18000 and player.registry["forester"] < 50000) then
				spoilchance = math.random(3)
				mob:addHealth(-10)
			elseif (player.registry["forester"] >= 50000) then
				spoilchance = math.random(2)
				mob:addHealth(-10)
			end
			if (spoilchance == 1) then
				player:addItem("branch_maple", 1)
				player:playSound(353)	
			end			
		else
			player:sendMinitext("You cannot chop trees without the proper tools!.")
			end

		end
	end
end,

move = function(mob,target)
end,

attack = function(mob,target)
end,

on_spawn = function(mob)
local newX = math.random(-3, 3)
local newY = math.random(-3, 3)
local passCheck = getPass(mob.m, mob.startX + newX, mob.startY + newY)
local tileCheck = getTile(mob.m, mob.startX + newX, mob.startY + newY)
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

	if (passCheck == 0 and #mobCheck == 0 and (tileCheck == 30447 or tileCheck == 43 or tileCheck == 21 or tileCheck == 9953)) then
		mob:warp(mob.m, mob.startX + newX, mob.startY + newY)
	end
end,
	
after_death = function(mob, player)
	local rand = math.random(100)
	local gem = math.random(100)
	local skillAdded = math.random(2, 3)
	local skillAddChance = math.random(4)
	local bonus = math.random(0, player.registry["forester"] + 1) / (player.registry["forester"] + 1)
	local improveChance = ((player.registry["forester"] / 30) + 50)
	local craftlevel = "Beginner"
	
-- 	if(not player:hasEquipped({"pickaxe_i or pickaxe_ii or pickaxe_iii or pickaxe_iv"})) then
-- 		player:sendMinitext("You can not mine without proper mining tools.")
-- 		return
--	end

	player:addItem("branch_maple", 1)
	player:playSound(354)

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
			player.registry["forester"] = player.registry["forester"] + (skillAdded * 2)
		end
		
		if (player.registry["forester"] < 25) then
			craftlevel = "Aptitude I"
		elseif (player.registry["forester"] >= 25 and player.registry["forester"] < 220) then
			craftlevel = "Aptitude II"
		elseif (player.registry["forester"] >= 220 and player.registry["forester"] < 840) then
			craftlevel = "Aptitude III"
		elseif (player.registry["forester"] >= 840 and player.registry["forester"] < 2200) then
			craftlevel = "Aptitude IV"
		elseif (player.registry["forester"] >= 2200 and player.registry["forester"] < 6400) then
			craftlevel = "Aptitude V"
		elseif (player.registry["forester"] >= 6400 and player.registry["forester"] < 18000) then
			craftlevel = "Aptitude VI"
		elseif (player.registry["forester"] >= 18000 and player.registry["forester"] < 50000) then
			craftlevel = "Aptitude VII"
		elseif (player.registry["forester"] >= 50000 and player.registry["forester"] < 124000) then
			craftlevel = "Aptitude VIII"
		elseif (player.registry["forester"] >= 124000 and player.registry["forester"] < 237000) then
			craftlevel = "Aptitude IX"
		elseif (player.registry["forester"] >= 237000 and player.registry["forester"] < 400000) then
			craftlevel = "Aptitude X"
		elseif (player.registry["forester"] >= 400000 and player.registry["forester"] < 680000) then
			craftlevel = "Aptitude XI"
		elseif (player.registry["forester"] >= 680000) then
			craftlevel = "Master"
		end

		if (player.registry["forester"] < 680000) then
			player:removeLegendbyName("forester")
			player:addLegend("Foresting: "..craftlevel, "forester", 7, 128)
		elseif (player.registry["forester"] >= 680000) then
			player:removeLegendbyName("forester")
			player:addLegend(craftlevel.." Forester", "forester", 41, 128)
		end
	end
end
}
