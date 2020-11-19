bloodbath = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local aether = 40000
	local duration = 4000
	local magicCost = (.01 * player.maxMagic)
	local damage = (player.maxHealth * .5) + (player.might * 2)
	local threat

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

	if (mobTarget == nil) then
		player:sendMinitext("That is not useful without a target.")
		return
	end

	if (mobTarget ~= nil) then
			if(mobTarget.protection == 1) then
				return
			end

		mobTarget:sendAnimation(281, 0)
		player:sendAnimation(232, 0)
		mobTarget.attacker = player.ID
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		player:addThreat(mobTarget.ID, threat)

		player:setDuration("bloodbath", duration)
		
		if (#player.group > 1) then
			mobTarget:setGrpDmg(player.ID, threat)
		else
			mobTarget:setIndDmg(player.ID, threat)
		end
			mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			player:sendAction(1, 20)
			player:setAether("bloodbath", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You use Bloodbath.")
			player:playSound(39)
	end
end,

while_cast = function(player)
	local heal = player.maxHealth / 5

	if(player.state==1 or player.health==0) then
			return
	end
	
	player:sendAnimation(232, 0)
	player:addHealth2(heal)
	player:sendHealth(0, 0)
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Bloodbath strikes a foe causing them great harm, in turn the Gladiator replenishes health."}
	return level, items, itemAmounts, description
end
}