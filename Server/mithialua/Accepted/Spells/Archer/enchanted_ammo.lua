enchanted_ammo = {
cast = function(player)
player:freeAsync()
enchanted_ammo.popup(player)
end,

popup = async(function(player)
	local ammo = {graphic = convertGraphic(930, "monster"), color = 0}
	local aether = 60000
	local menuOptions = {}
	local magicCost = 1000
	
	table.insert(menuOptions, "Ice")
	table.insert(menuOptions, "Fire")

	local bowrange = player:getEquippedItem(EQ_WEAP)

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

	if (player.pvp == 1) then
		player:sendMinitext("Your honor forbids this skill in combat of this manner.")
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	player.npcGraphic = ammo.graphic
	player.npcColor = ammo.color
	player.dialogType = 0
		local choice = player:menuString("Which ammunition enchantment?", menuOptions)
		if(choice == "Ice") then
			--player:setAether("enchanted_ammo", aether)
			--player:setDuration("enchanted_ammo_ice", 60000)
			enchanted_ammo_ice.cast(player)
		elseif(choice == "Fire") then
			--player:setAether("enchanted_ammo", aether)
			enchanted_ammo_fire.cast(player)
		end
		player:setAether("enchanted_ammo", aether)
end),

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Enchanted Ammo allows you to enspell your ammunition with additional benefits for a duration."}
	return level, items, itemAmounts, description
end
}

enchanted_ammo_ice = {
cast = function(player)
	local aether = 5000--90000
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

	if (player:hasDuration("enchanted_ammo_ice") or player:hasDuration("enchanted_ammo_fire")) then
		player:sendMinitext("You must wait to use this ability.")
		return
	end

	player.magic = player.magic - magicCost
	player:sendStatus()

	player:playSound(60)
	player:sendAnimation(263, 0)
	player:setDuration("enchanted_ammo_ice", 30000)
	player:setAether("enchanted_ammo_ice", aether)

end,

on_hit_while_cast = function(player, target)
	local duration = 10000
	local perchance = math.random(1,4)

	if (perchance == 1) then
		if (target:hasDuration("freeze")) then
			return
		end
		
		if (target.blType == BL_MOB and target.paralyzed ~= true) then
			player:playSound(73)
			target:sendAnimation(52, 0)
			target:setDuration("freeze", duration, 0, 1)
			target.paralyzed = true
		end
	end
end,

while_cast = function(player)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	if (bowrange ~= nil and (bowrange.id <= 20000 or bowrange.id >= 20500)) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("enchanted_ammo_ice", 0)
	end

	if (bowrange == nil) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("enchanted_ammo_ice", 0)
	end
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Barrage greatly increases your bow attack speed for a duration."}
	return level, items, itemAmounts, description
end
}

enchanted_ammo_fire = {
cast = function(player)
	local aether = 5000--90000
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

	if (player:hasDuration("enchanted_ammo_ice") or player:hasDuration("enchanted_ammo_fire")) then
		player:sendMinitext("You must wait to use this ability.")
		return
	end

	player.magic = player.magic - magicCost
	player:sendStatus()

	player:playSound(60)
	player:sendAnimation(264, 0)
	player:setDuration("enchanted_ammo_fire", 30000)
	player:setAether("enchanted_ammo_fire", aether)
end,

on_hit_while_cast = function(player, target)
	local duration = 10000
	local perchance = math.random(1,4)

	if (perchance == 1) then
		if (target:hasDuration("burn2")) then
			return
		end
		
		if (target.blType == BL_MOB) then
			player:playSound(735)
			target:sendAnimation(47, 0)
			target:setDuration("burn2", duration, player.id)
		end
	end
end,

while_cast = function(player)
	local bowrange = player:getEquippedItem(EQ_WEAP)
	if (bowrange ~= nil and (bowrange.id <= 20000 or bowrange.id >= 20500)) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("enchanted_ammo_fire", 0)
	end

	if (bowrange == nil) then
		player:sendMinitext("You need a bow equipped to use this ability.")
		player:setDuration("enchanted_ammo_fire", 0)
	end
end,

requirements = function(player)
	local level = 8
	local items = {}
	local itemAmounts = {}
	local description = {"Barrage greatly increases your bow attack speed for a duration."}
	return level, items, itemAmounts, description
end
}