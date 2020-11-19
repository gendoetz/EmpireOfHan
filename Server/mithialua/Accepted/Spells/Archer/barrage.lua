barrage = {
cast = function(player)
	local aether = 300000
	local duration = 15000
	local magicCost = 50
	local bowrange = player:getEquippedItem(EQ_WEAP)

	if (player.pvp == 1) then
		player:sendMinitext("Your honor forbids this skill in combat of this manner.")
		return
	end

	if (bowrange ~= nil and (bowrange.id <= 20000 or bowrange.id >= 20500)) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		return
	end

	if (bowrange == nil) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		return
	end
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("barrage")) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	player:sendAction(6, 20)
	player:playSound(117)
	player:setDuration("barrage", duration)
	player:setAether("barrage", aether)
	player:sendAnimation(226, 0)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("You use Barrage.")
end,

recast = function(player)
	player.attackSpeed = player.attackSpeed * .3
end,

uncast = function(player)
	player:calcStat()
end,

while_cast = function(player)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	if (bowrange ~= nil and (bowrange.id <= 20000 or bowrange.id >= 20500)) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("barrage", 0)
	end

	if (bowrange == nil) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("barrage", 0)
	end
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Barrage greatly increases your bow attack speed for a short time."}
	return level, items, itemAmounts, description
end
}