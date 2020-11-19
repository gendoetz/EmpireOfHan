frenzy = {
cast = function(player)
	local duration = 40000
	local damage = (((player.level + (player.might * 2)) *5) *2)
	local magicCost = 750
	local targets = getTargetsAroundDiamond(player, BL_MOB)
	local threat
	local aether = 300000

	damage = damage * player.rage
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.pvp == 1) then
		player:sendMinitext("Your honor forbids this skill in combat of this manner.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("frenzy")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (#targets == 0) then
		player:sendMinitext("You dont have any enemy targets.")
		return
	end
	
	player:sendAction(1, 35)
	player:setDuration("frenzy", duration)
	player:setAether("frenzy", aether)
	player:sendAnimation(11, 0)
	player:playSound(7)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Frenzy.")

	local targetsFinal = {}
	
	if (#targets > 0) then
		for i = 1, #targets do
			if (targets[i] ~= nil) then
				if (targets[i].protection ~= 1) then
					table.insert(targetsFinal, targets[i])
				end
			end
		end
	end

	if (#targetsFinal > 0) then
		for i = 1, #targetsFinal do
			if (targetsFinal[i].blType == BL_MOB) then
				targetsFinal[i].attacker = player.ID
				threat = targetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(targetsFinal[i].ID, threat)
				if (#player.group > 1) then
					targetsFinal[i]:setGrpDmg(player.ID, threat)
				else
					targetsFinal[i]:setIndDmg(player.ID, threat)
				end			
				targetsFinal[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				targetsFinal[i]:sendAnimation(257, 0)
				player:addMagic(damage/4)
			end
		end

	end
end,

recast = function(player)
	player.extendHit = true
end,

uncast = function(player)
	player.extendHit = false
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Frenzy is a powerful strike that hits enemies around you and enhances strikes of rampage causing your weapon to damage more foes."}
	return level, items, itemAmounts, description
end
}