enfocus = {
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

	if (player:hasDuration("tigers_cunning")) then
		player:setDuration("tigers_cunning", 0)
	end

	if (player:hasDuration("tigers_cunning2")) then
		player:setDuration("tigers_cunning2", 0)
	end

	if (player:hasDuration("tigers_cunning3")) then
		player:setDuration("tigers_cunning3", 0)
	end

	if (player:hasDuration("tigers_cunning4")) then
		player:setDuration("tigers_cunning4", 0)
	end
	
	if (player:hasDuration("enfocus")) then
		if (player:durationAmount("enfocus") > 0) then
			--local currentduration = player:durationAmount("enfocus"
				if (player.registry["enfocus"] == 1) then
					magicCost = 8500
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enfocus"] = player.registry["enfocus"] + 1
				elseif (player.registry["enfocus"] == 2) then
					magicCost = 15500
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enfocus"] = player.registry["enfocus"] + 1
				elseif (player.registry["enfocus"] == 3) then
					magicCost = 45000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enfocus"] = player.registry["enfocus"] + 1
				elseif (player.registry["enfocus"] == 4) then
					magicCost = 75000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enfocus"] = player.registry["enfocus"] + 1
				elseif (player.registry["enfocus"] == 5) then
					magicCost = 135000
						if (player.magic < magicCost) then
							player:sendMinitext("Not enough mana.")
							return
						end
					player.registry["enfocus"] = player.registry["enfocus"] + 1
				elseif (player.registry["enfocus"] >= 6) then
					player:sendMinitext("You are at current maximum rage.")
					return
				end

				player:setAether("enfocus", aether)
				player:playSound(31)
				player:sendAnimation(82, 0)
				player:sendAnimation(117, 0)
				player.health = player.health - healthCost
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendMinitext("You cast Enfocus.")
				player:calcStat()

		end
		--player:sendMinitext("That spell is already cast.")
		--return
	else
		player:setAether("enfocus", aether)
		player:playSound(31)
		player:sendAnimation(82, 0)
		player:sendAnimation(117, 0)
		player.health = player.health - healthCost
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:setDuration("enfocus", duration)
		player.registry["enfocus"] = 1
		player:sendMinitext("You cast Enfocus.")
		player:calcStat()
	end
end,

recast = function(player)
	if (player.registry["enfocus"] == 1) then
		player.rage = player.rage + 1.5--3
	elseif (player.registry["enfocus"] == 2) then
		player.rage = player.rage + 3--6
	elseif (player.registry["enfocus"] == 3) then
		player.rage = player.rage + 4--8
		player.armor = player.armor - 5000
	elseif (player.registry["enfocus"] == 4) then
		player.rage = player.rage + 5.5--11
		player.armor = player.armor - 13000
	elseif (player.registry["enfocus"] == 5) then
		player.rage = player.rage + 7.5--15
		player.armor = player.armor - 30000
	elseif (player.registry["enfocus"] == 6) then
		player.rage = player.rage + 16.25--32.5
		player.armor = player.armor - 50000
	end
end,

uncast = function(player)
	if (player.registry["enfocus"] == 1) then
		if ((player.health - player.maxHealth * .20) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .20
		end
		player:sendStatus()
	elseif (player.registry["enfocus"] == 2) then
		if ((player.health - player.maxHealth * .20) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .20
		end
		player:sendStatus()
	elseif (player.registry["enfocus"] == 3) then
		if ((player.health - player.maxHealth * .20) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .20
		end
		player:sendStatus()
	elseif (player.registry["enfocus"] == 4) then
		if ((player.health - player.maxHealth * .40) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .40
		end
		player:sendStatus()
	elseif (player.registry["enfocus"] == 5) then
		if ((player.health - player.maxHealth * .60) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .60
		end
		player:sendStatus()
	elseif (player.registry["enfocus"] == 6) then
		if ((player.health - player.maxHealth * .90) <= 100) then
			player.health = 100
		else
			player.health = player.maxHealth - player.maxHealth * .90
		end
		player:sendStatus()
	end
	player.registry["enfocus"] = 0
	player:setAether("enfocus", 0)
	player:calcStat()
end,

requirements = function(player)
	local level = 99
	local items = {}
	local itemAmounts = {}
	local description = {"Enfocus is a powerful attack boost that multiplies your damage and grows in power as you do."}
	return level, items, itemAmounts, description
end
}