stoneskin = {
cast = function(player)
	local duration = 12000
	local aether = 300000
	local magicCost = 1000
	
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

	if (player:hasDuration("stoneskin")) then
		player:sendMinitext("That spell is already protecting you.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Stoneskin.")
	player:setAether("stoneskin", aether)
	player:playSound(51)

		for i = 1, #player.group do
			if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m and not Player(player.group[i]):hasDuration("stoneskin") and not Player(player.group[i]):hasDuration("harden_body")) then
				Player(player.group[i]):setDuration("stoneskin", duration)
				Player(player.group[i]):sendAnimation(418, 0)
				Player(player.group[i]):sendMinitext(player.name.." turns your skin to stone.")
			end
		end
end,

uncast = function(player)
	player:sendMinitext("Stoneskin fades from you.")
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Stoneskin turns your body and that of other party members to stone for a short time preventing all damage."}
	return level, items, itemAmounts, description
end
}