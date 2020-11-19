decimate = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local aether = 12000--30000
	local threat
	local damage = player.health * 1.25
	local healthCost = (player.health * .33)
	local magicCost = (player.magic * .05)
	local minHealth = 100
	local minMagic = 500
	local recoilgraphic = 0

	if (player.registry["recoil_damagestored"] > 1) then
		damage = damage + player.registry["recoil_damagestored"]
		recoilgraphic = 246
	end
	
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

	if (mobTarget ~= nil) then
		if(mobTarget.protection == 1) then
			return
		end
	end

	if (pcTarget ~= nil) then
		if (not player:canPK(pcTarget)) then
			return
		end
	end
	
	if (mobTarget ~= nil) then
	player:sendAction(1, 20)
	player:setAether("decimate", aether)
	player:sendMinitext("You use Decimate.")
	player:playSound(94)
	player.registry["recoil_damagestored"] = 1
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		if (recoilgraphic == 246) then
			mobTarget:sendAnimation(246, 0)
		end
		mobTarget:sendAnimation(68, 0)
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)
		
		if (#player.group > 1) then
			mobTarget:setGrpDmg(player.ID, threat)
		else
			mobTarget:setIndDmg(player.ID, threat)
		end
		
		mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	elseif (pcTarget ~= nil) then
		if (player:canPK(pcTarget)) then
			if (recoilgraphic == 246) then
				pcTarget:sendAnimation(246, 0)
			end
			pcTarget:sendAnimation(68, 0)
	player:sendAction(1, 20)
	player:setAether("decimate", aether)
	player:sendMinitext("You use Decimate.")
	player:playSound(94)
	player.registry["recoil_damagestored"] = 1

			player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			pcTarget.attacker = player.ID
			pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			pcTarget:sendMinitext(player.name.." uses Decimate on you.")
		end
	end
end,

requirements = function(player)
	local level = 65
	local items = {}
	local itemAmounts = {}
	local description = {"Decimate is a strong desperate attack that hits a foe at the cost of vitality."}
	return level, items, itemAmounts, description
end
}