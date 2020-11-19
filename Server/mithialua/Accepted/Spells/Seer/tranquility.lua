tranquility = {
cast = function(player, target)
	local heal = 0
	local magicCost = 90

	if (player.level < 99) then
		heal = 650
	end
	if (player.level == 99) then
		heal = 1200
	end
	
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
	
	if (target.state == 1) then
		player:sendMinitext("That cannot save them now.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Tranquility.")
	player:playSound(5)
	target:sendAnimation(63, 0)
	target.attacker = player.ID
	target:addHealthExtend(heal, 0, 0, 0, 0, 0)
	target:sendMinitext(player.name.." casts Tranquility on you.")
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Tranquility is a moderate strength healing spell that allows you to heal others. There is no cost to learning this spell."}
	return level, items, itemAmounts, description
end
}