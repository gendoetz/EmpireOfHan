aegis_sancta = {
cast = function(player)
	local duration = 200000
	local magicCost = 400
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	--if (target:hasDuration("bolster") or target:hasDuration("reinforce") or target:hasDuration("divine_ballad")) then
	--	player:sendMinitext("A stronger version is already running.")
	--	return
	--end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Aegis Sancta.")
	player:setDuration("aegis_sancta", duration, 0, 1)
	--player:playSound(62)
	--target:sendAnimation(98, 0)
	player:sendMinitext(player.name.." you become enveloped in a magical protective aura.")

	player:calcStat()
end,

while_cast = function(player, caster)
	local durationauto = player:durationAmount("aegis_sancta") + 3000
	local playsoundonce1 = 0
	local playsoundonce2 = 0

			for i = 1, #player.group do
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m and distance(player, Player(player.group[i])) <= 7 and not Player(player.group[i]):hasDuration("aegis2")) then
					if (Player(player.group[i]):hasDuration("aegis")) then
						Player(player.group[i]):setDuration("aegis", 0)
					end
					if (Player(player.group[i]):hasDuration("aegis2")) then
						Player(player.group[i]):flushDuration(4017, 4017)
					end
					playsoundonce1 = 1
					Player(player.group[i]):sendAnimation(98, 0)
					--Player(player.group[i]).attacker = player.ID
					Player(player.group[i]):setDuration("aegis2", durationauto, player.id, 1)
					Player(player.group[i]):calcStat()
					--Player(player.group[i]):addHealthExtend(heal, 0, 0, 0, 0, 0)
					Player(player.group[i]):sendMinitext("You become enveloped in protective magic while near "..player.name..".")
				end
			end

			for i = 1, #player.group do
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m and distance(player, Player(player.group[i])) <= 7 and not Player(player.group[i]):hasDuration("sancta2")) then
					if (Player(player.group[i]):hasDuration("sancta")) then
						Player(player.group[i]):setDuration("sancta", 0)
					end
					if (Player(player.group[i]):hasDuration("sancta2")) then
						Player(player.group[i]):flushDuration(4019, 4019)
					end
					playsoundonce2 = 1
					Player(player.group[i]):sendAnimation(110, 0)
					--Player(player.group[i]).attacker = player.ID
					Player(player.group[i]):setDuration("sancta2", durationauto, player.id, 1)
					Player(player.group[i]):calcStat()
					--Player(player.group[i]):addHealthExtend(heal, 0, 0, 0, 0, 0)
					Player(player.group[i]):sendMinitext("You become enveloped in protective magic while near "..player.name..".")
				end
			end
			if (playsoundonce1 == 1) then
				player:playSound(62)
				playsoundonce1 = 0
			end
			if (playsoundonce2 == 1) then
				player:playSound(92)
				playsoundonce2 = 0
			end
end,

--recast = function(player)
--	player.armor = player.armor + 3000
--end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Aegis Sancta protects an ally with increased armor and damage reduction. To learn this spell you must sacrifice (5) Crystaline Fox Hide and (1) Rough Kyanite."}
	return level, items, itemAmounts, description
end
}

aegis2 = {
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
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Aegis II.")
	target:setDuration("aegis2", duration, player.id, 1)
	player:playSound(62)
	target:sendAnimation(98, 0)
	
	if (target.blType == BL_PC) then
		target:sendMinitext(player.name.." increases your armor with Aegis II.")
	end
	
	target:calcStat()
end,

while_cast = function(player, caster)
	if (#player.group == 1 and not player:hasDuration("aegis_sancta")) then
		if (player:hasDurationID("aegis2", caster.id)) then
			player:setDuration("aegis2", 0, caster.id)
		end
	end
	if (not caster:hasDuration("aegis_sancta")) then
		if (player:hasDurationID("aegis2", caster.id)) then
			player:setDuration("aegis2", 0, caster.id)
		end
	end
end,

recast = function(block)
	block.armor = block.armor + 3000
end,

uncast = function(block)
	block:calcStat()
end,

requirements = function(player)
	local level = 55
	local items = {56,55}
	local itemAmounts = {5,5}
	local description = {"Aegis protects an ally with minor increased armor. To learn this spell you must sacrifice (5) Crystaline Fox Hide and (1) Rough Kyanite."}
	return level, items, itemAmounts, description
end
}

sancta2 = {
cast = function(player, target)
	local duration = 240000
	local magicCost = 60
	
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
	
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Sancta II.")
	target:setDuration("sancta2", duration, player.id, 1)
	player:playSound(92)
	target:sendAnimation(110, 0)
	
	if (target.blType == BL_MOB) then
		target.deduction = target.deduction - .15
	elseif (target.blType == BL_PC) then
		target:calcStat()
		target:sendMinitext(player.name.." guards you with Sancta II.")
	end
end,

while_cast = function(player, caster)
	if (#player.group == 1 and not player:hasDuration("aegis_sancta")) then
		if (player:hasDurationID("sancta2",caster.id)) then
			player:setDuration("sancta2", 0, caster.id)
		end
	end
	if (not caster:hasDuration("aegis_sancta")) then
		if (player:hasDurationID("sancta2",caster.id)) then
			player:setDuration("sancta2", 0, caster.id)
		end
	end
end,

recast = function(player)
	player.deduction = player.deduction - .15
end,

uncast = function(block)
	if (block.blType == BL_MOB) then
		block.deduction = block.deduction + .15
	elseif (block.blType == BL_PC) then
		block:calcStat()
	end
end,

requirements = function(player)
	local level = 55
	local items = {}
	local itemAmounts = {}
	local description = {"Sancta reduces minor damage done by enemies. To learn this spell you must sacrifice (5) Bewitched Stone Fragment and 100 gold coins."}
	return level, items, itemAmounts, description
end
}