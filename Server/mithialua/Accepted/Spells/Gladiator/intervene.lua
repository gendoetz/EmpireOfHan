intervene = {
cast = function(player, target)
	local aether = 180000
	local duration = 20000
	local magicCost = (player.maxMagic * .025)
	
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

	if (target.id == player.id) then
		player:sendMinitext("You cannot use that on yourself.")
		return
	end
	
	if (target:hasDuration("intervene")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	if (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player:setAether("intervene", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:sendMinitext("You use Intervene.")
		target:setDuration("intervene", duration, player.ID)
		player:playSound(74)
		target:sendAnimation(173, 0)
		target:sendMinitext(player.name.." is taking damage for you.")
	end
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Intervene protects an ally from damage causing the Gladiator to take damage instead."}
	return level, items, itemAmounts, description
end
}