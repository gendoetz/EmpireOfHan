summon_event_enemy = {
cast = function(player)
	local aether = 5000
	local magicCost = 50
	local plusx
	local pluxy
	local x
	local y
	local mobCheck
	local pcCheck

	if (not player:canCast(1, 1, 0)) then
		return
	end

		player:sendAction(6, 20)
		player:setAether("summon_event_enemy", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()

		player:talk(1,"*Tsugua summons energy from the dark void*")

		for i = 1, 10 do

			plusx = math.random(-8, 8)
			plusy = math.random(-8, 8)

			if((player.x + plusx) < 0 )then
				plusx = 0
			end
			if((player.x + plusx) > player.xmax) then
				plusx = 0
			end

			if((player.y + plusy) < 0) then
				plusy = 0
			end
			if((player.y + plusy) > player.ymax) then
				plusy = 0
			end
				x = (player.x + plusx)
				y = (player.y + plusy)
				mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
				pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)

			if (getPass(player.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) then
				player:spawn(202, player.x + plusx, player.y + plusy, 1)
			end

		end
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Event Mob Spawn."}
	return level, items, itemAmounts, description
end
}

grasp_of_darkness = {
cast = function(player, target)
	local aether = 1000
	local damage = (target.maxHealth * .25)
	local threat
	local healthCost = 5
	local magicCost = 5
	local minHealth = 10
	local minMagic = 10
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth or player.health - healthCost <= 0) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < minMagic) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("grasp_of_darkness", aether)
		player:playSound(39)

		target:sendAnimation(354, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Grasp of Darkness")
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		
		if (#player.group > 1) then
			target:setGrpDmg(player.ID, threat)
		else
			target:setIndDmg(player.ID, threat)
		end
		
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player:setAether("grasp_of_darkness", aether)
		player:playSound(39)

		target:sendAnimation(354, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You cast Grasp of Darkness.")
		target.attacker = player.ID
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		target:sendMinitext(player.name.." casts Grasp of Darkness on you.")
	end
end,

requirements = function(player)
	local level = 95
	local items = {}
	local itemAmounts = {}
	local description = {"Grasp of Darkness is an event spell."}
	return level, items, itemAmounts, description
end
}