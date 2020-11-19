elemental_amplification = {
cast = function(player, target)
	local dura = 20000
	local aether = 300000
	local magicCost = (.1 * player.maxMagic)

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

	player:sendAction(6,35)
	player:playSound(78)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:setAether("elemental_amplification",aether)
	player:setDuration("elemental_amplification",dura)
	player:sendAnimation(297)--56 66 90 98 110 251 295 323
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Empowers your elemental omnistrike to target additional enemies."}
	return level, items, itemAmounts, description
end
}
