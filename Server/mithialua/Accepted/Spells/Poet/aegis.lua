aegis = {
cast = function(player, target)
	local duration = 240000
	local magicCost = 40
	
	if (not player:canCast(1, 1, 0)) then
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
	
	if (target:hasDuration("aegis2") or target:hasDuration("reinforce") or target:hasDuration("divine_ballad")) then
		player:sendMinitext("A stronger version is already running.")
		return
	end

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Aegis.")
	target:setDuration("aegis", duration, 0, 1)
	player:playSound(62)
	target:sendAnimation(98, 0)
	
	if (target.blType == BL_PC) then
		target:sendMinitext(player.name.." increases your armor with Aegis.")
	end
	
	target:calcStat()
end,

recast = function(block)
	block.armor = block.armor + 3000
end,

uncast = function(block)
	block:calcStat()
end,

requirements = function(player)
	local level = 10
	local items = {}
	local itemAmounts = {}
	local description = {"Aegis protects an ally with minor increased armor. To learn this spell you must sacrifice (5) Crystaline Fox Hide and (1) Rough Kyanite."}
	return level, items, itemAmounts, description
end
}