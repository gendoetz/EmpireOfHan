enspirit = {
cast = function(player)
	local aether = 120000
	local duration = 960000
	local healthCost = (player.health * .1)
	local minHealth = 100
	local magicCost = 4500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.health < minHealth) then
		player:sendMinitext("Not enough vita.")
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	
	if (player:hasDuration("enspirit")) then
		if (player:durationAmount("enspirit") > 0) then
			--local currentduration = player:durationAmount("enspirit"
				if (player.registry["enspirit"] == 1) then
					magicCost = 15500
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enspirit"] = player.registry["enspirit"] + 1
				elseif (player.registry["enspirit"] == 2) then
					magicCost = 25000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enspirit"] = player.registry["enspirit"] + 1
				elseif (player.registry["enspirit"] == 3) then
					magicCost = 55000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enspirit"] = player.registry["enspirit"] + 1
				elseif (player.registry["enspirit"] == 4) then
					magicCost = 85000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enspirit"] = player.registry["enspirit"] + 1
				elseif (player.registry["enspirit"] == 5) then
					magicCost = 145000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enspirit"] = player.registry["enspirit"] + 1
				elseif (player.registry["enspirit"] >= 6) then
					player:sendMinitext("You are at current maximum Enspirit.")
					return
				end

				player:setAether("enspirit", aether)
				player:playSound(31)
				player:sendAnimation(80, 0)
				player:sendAnimation(117, 0)
				player.health = player.health - healthCost
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Enpirit.")
				player:calcStat()

		end
		--player:sendMinitext("That spell is already cast.")
		--return
	else
		player:setAether("enspirit", aether)
		player:playSound(31)
		player:sendAnimation(80, 0)
		player:sendAnimation(117, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setDuration("enspirit", duration)
		player.registry["enspirit"] = 1
		player:sendMinitext("You cast Enspirit.")
		player:calcStat()
	end
end,

recast = function(player)
	if (player.registry["enspirit"] == 1) then
		player.registry["magicDamageMod"] = 2

	elseif (player.registry["enspirit"] == 2) then
		player.registry["magicDamageMod"] = 3

	elseif (player.registry["enspirit"] == 3) then
		player.registry["magicDamageMod"] = 4

	elseif (player.registry["enspirit"] == 4) then
		player.registry["magicDamageMod"] = 5

	elseif (player.registry["enspirit"] == 5) then
		player.registry["magicDamageMod"] = 6

	elseif (player.registry["enspirit"] == 6) then
		player.registry["magicDamageMod"] = 7

	end
end,

uncast = function(player)
	player.registry["enspirit"] = 0
	player.registry["magicDamageMod"] = 1
	player:setAether("enspirit", 0)
	player:calcStat()
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Enspirit is a powerful magic enhancement that strengthens your spells and grows in power as you do."}
	return level, items, itemAmounts, description
end
}

function Player.magicDamageMod_enspirit(player, damage)

		if (player.registry["magicDamageMod"] >= 2) then
			if (player.registry["magicDamageMod"] == 2) then
				damage = damage * 1.55
			elseif (player.registry["magicDamageMod"] == 3) then
				damage = damage * 2.35
			elseif (player.registry["magicDamageMod"] == 4) then
				damage = damage * 2.90
			elseif (player.registry["magicDamageMod"] == 5) then
				damage = damage * 5.30
			elseif (player.registry["magicDamageMod"] == 6) then
				damage = damage * 7.95
			elseif (player.registry["magicDamageMod"] == 7) then
				damage = damage * 22.75
			end
		end

	return damage
end