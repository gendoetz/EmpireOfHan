bards_ballad = {
cast = function(player)
	local duration = 20000
	local aether = 60000
	local magicCost = 400
	
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
	
	player:sendAction(22, 60)
	player.magic = player.magic - magicCost
	player:sendStatus()

	player.registry["bards_balladper"] = player.maxMagic / 100
	player:setDuration("bards_ballad", duration, 0, 1)
	--player:playSound(62)
	if (player.y ~= 0) then
		player:sendAnimationXY(197, player.x, player.y -1, 0)
	end
	player:sendMinitext("You sing Bard's Ballad.")
	player:calcStat()
end,

while_cast = function(player, caster)
	local durationauto = player:durationAmount("bards_ballad") + 3000
	local playsoundonce1 = 0
	local playsoundonce2 = 0

			for i = 1, #player.group do
				if (Player(player.group[i]).state ~= 1 and Player(player.group[i]).m == player.m and distance(player, Player(player.group[i])) <= 8 and not Player(player.group[i]):hasDuration("song_ballad")) then
					playsoundonce1 = 1
					Player(player.group[i]):sendAnimation(131, 0)
					Player(player.group[i]):sendAnimation(108, 0)
					--Player(player.group[i]).attacker = player.ID
					Player(player.group[i]):setDuration("song_ballad", durationauto, player.id, 1)
					Player(player.group[i]):calcStat()
					--Player(player.group[i]):addHealthExtend(heal, 0, 0, 0, 0, 0)
					Player(player.group[i]):sendMinitext("Your body and mind is restored by "..player.name.."'s song.")
				end
			end

			if (playsoundonce1 == 1) then
				player:playSound(505)
				playsoundonce1 = 0
			end
end,

--recast = function(player)
--	player.armor = player.armor + 3000
--end,

uncast = function(player)
	player:calcStat()
end,

requirements = function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Bard's Ballad restores mana and vita to the entire group for a short duration."}
	return level, items, itemAmounts, description
end
}

song_ballad = {
while_cast = function(player, caster)
	if (caster ~= nil) then
		player:addHealth2(caster.registry["bards_balladper"])
		player:addMagic(caster.registry["bards_balladper"])
		player:sendAnimation(131, 0)
	else
		player:addHealth2(100)
		player:addMagic(100)
		player:sendAnimation(131, 0)
	end
end,

uncast = function(player)
	player:sendMinitext("Your mana and vita stop regenerating.")
end,
}