redemption = {
cast = function(player, target)
	local aether = 90000
	local duration = 30000
	local magicCost = 250
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("redemption")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType ~= BL_PC) then
		player:sendMinitext("You cannot cast this on that target.")
		return
	end
	
	player:sendAction(6, 20)
	player:playSound(77)
	target:sendAnimation(92, 1)
	player:setAether("redemption", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	target:setDuration("redemption", duration)
	player:sendMinitext("You cast Redemption.")
end,

before_death_while_cast = function(player, attacker)
	local heal = (player.maxHealth * .5)

	player:playSound(112)
	player:sendAnimationXY(338, player.x, player.y, 1)
	player:setDuration("redemption", 0)
	player.attacker = attacker.ID
	player:addHealthExtend(heal, 0, 0, 0, 0, 1)
	player:calcStat()
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Redemption gives a combatant another chance at victory when death is certain protecting their life strand and restoring health."}
	return level, items, itemAmounts, description
end
}