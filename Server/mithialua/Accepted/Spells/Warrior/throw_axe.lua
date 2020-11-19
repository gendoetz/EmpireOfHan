throw_axe = {
cast = function(player, target)
	local damage = (player.health * 0.0245) + (player.might * 11.435)
	local aether = 3000
	local duration = 5000
	local magicCost = 25
	local threat

	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player.x == target.x and player.y == target.y) then
		player:sendMinitext("It would be unwise to do that.")
		return
	end
	
	if (target:hasDuration("throw_axe")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	player:sendAction(2, 20)
	player:setAether("throw_axe", aether)
	--player:playSound(709)
	player:sendMinitext("You throw an axe!")
	
	if (target.blType == BL_MOB) then
		player:throw(target.x, target.y, 787, 0, 2)
		player.magic = player.magic - magicCost
		player:sendStatus()
		--target:setDuration("throw_axe", 20000)
		target.attacker = player.ID
		threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(target.ID, threat)
		
		if (#player.group > 1) then
			target:setGrpDmg(player.ID, threat)
		else
			target:setIndDmg(player.ID, threat)
		end
		target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--target:changeMove(1000)
		target:playSound(351)
		target:sendAnimation(327, 0)
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:throw(target.x, target.y, 787, 0, 2)
		
		if (player:canPK(target)) then
			player.magic = player.magic - magicCost
			player:sendStatus()
			--target:setDuration("throw_axe", duration)
			target.attacker = player.ID
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)

			target:sendAnimation(327, 0)
			target:playSound(351)
			--target:talk(0,"Speed: "..target.speed)
			target:sendMinitext(player.name.." throws an axe at you.")
		end
	end
end,

uncast = function(block)

end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Throw axe is a tactical move that does damage and slows a target for a short time."}
	return level, items, itemAmounts, description
end
}