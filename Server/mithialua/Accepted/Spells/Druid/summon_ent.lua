summon_ent = {
cast = function(player)
	local aether = 550000
	local magicCost = (.02 * player.maxMagic)
	local checkunder = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)

	local damage = (player.level * 5) + (player.will * 7)
	local enspiritCheck = player:magicDamageMod_enspirit(damage)
	damage = enspiritCheck

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.class ~= 12) then
		player:sendMinitext("Your path is not capable of this magic.")
		player:removeSpell("summon_ent")
		player.registry["learned_summon_ent"] = 0
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

	if (#checkunder > 0) then
		player:sendMinitext("You cant use this spell with an enemy under you.")
		return
	end

		player:sendAction(6, 20)
		player:setAether("summon_ent", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(1)

		player:spawn(168, player.x, player.y, 1)
		local D = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
		Mob(D[1].ID).owner = player.id
		Mob(D[1].ID).target = player.id
		Mob(D[1].ID).summon = true
		Mob(D[1].ID).side = player.side
		Mob(D[1].ID):sendSide()

		Mob(D[1].ID).minDam = damage - 100
		Mob(D[1].ID).maxDam = damage + 100
end,

requirements = function(player)
	local level = 95
	local items = {}
	local itemAmounts = {}
	local description = {"Call of the Forest brings forth a great Ent that will aid you for a short time."}
	return level, items, itemAmounts, description
end
}

sum_ent = {
on_spawn = function(mob)
	mob.registry["mob_life_timer"] = os.time()
end,

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
		target = mob:getBlock(mob.owner)
		mob.target = mob.owner
end,
	
move = function(mob, target)
	local moved = true
	local oldside = mob.side
	local checkmove = math.random(0,10)
	local targets = {}
	local owner_is
	local owner
	local life_duration = 180 --(in seconds)
	local highest_threat = 0
	local current_target
	local current_target_id
	local range = 2
	local rangeCheck = false

	--mob:talk(2,"Mob Target "..mob.state)

	if (os.time() > mob.registry["mob_life_timer"] + life_duration) then
		mob:delete()
		return
	end

	owner = mob:getBlock(mob.owner)
	if (owner == nil) then
		mob:delete()
		return
	end
	if (owner ~= nil and owner.m ~= mob.m) then
		--mob:delete()
		mob:warp(owner.m, owner.x, owner.y)
		return
	end

		local mobBlocks = {}
		local measure_threat

		local mobBlocks = mob:getObjectsInArea(BL_MOB)

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				owner_is = mob:getBlock(mob.owner)
				if (owner_is ~= nil) then
					measure_threat = mobBlocks[i]:checkThreat(mob.owner)
				end

				if (measure_threat > 0) then
					table.insert(targets, mobBlocks[i])

						if (measure_threat > highest_threat) then
							highest_threat = measure_threat
							current_target = mobBlocks[i]
							current_target_id = mobBlocks[i].ID
						end


				end
			end
		end

		if (#targets > 0) then
			target = current_target
			mob.target = current_target_id
		end

	if (owner ~= nil)then

		if (distance(mob, owner) <= range) then
			rangeCheck = true
		end

		if (mob.target == mob.owner and rangeCheck == true) then
			if (owner.side == 0) then
				moved = toXYdirect(mob, owner.x+1, owner.y)
				mob.side = owner.side
				mob:sendSide()
				return
			elseif (owner.side == 1) then
				moved = toXYdirect(mob, owner.x, owner.y+1)
				mob.side = owner.side
				mob:sendSide()
				return
			elseif (owner.side == 2) then
				moved = toXYdirect(mob, owner.x-1, owner.y)
				mob.side = owner.side
				mob:sendSide()
				return
			elseif (owner.side == 3) then
				moved = toXYdirect(mob, owner.x, owner.y-1)
				mob.side = owner.side
				mob:sendSide()
				return
			end
		end
	end

	--mob:talk(2,"Mob Target "..mob.state)

		if (target ~= nil) then
			if (target.blType == 1) then
				local threaten = mob:checkThreat(target.id)
				target:setThreat(mob.ID, 0)

				mob.target = mob.owner
			end
			if (target.blType == 2) then
				if (target.summon == true) then
					mob.target = mob.owner
					target = owner
				end
			end
		end

		if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
			if(checkmove >= 4) then
				mob.side=math.random(0,3)
				mob:sendSide()
				if(mob.side == oldside) then
					moved=mob:move()
				end
			else
				moved=mob:move()
			end
		else
			owner = mob:getBlock(mob.owner)
			
			if (target == nil and owner ~= nil) then
				target = mob:getBlock(mob.owner)
				mob.target = mob.owner
			end
			
			if (target ~= nil) then
				--Don't target summons
				if (mob.target == 0) then
					target = mob:getBlock(mob.owner)
					mob.target = mob.owner
				end

				moved=SummonFindCoords(mob,target)
				--mob:talk(2,"Mob Target "..mob.state)
				if((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner and target.blType ~= 1) then

						mob:attack(target.ID)
						mob.state = MOB_HIT
				elseif ((moved or mob:moveIntent(target.ID) == 1) and mob.target == mob.owner and target.blType == 1) then
						mob.state = MOB_HIT
				end
			end
		end
end,

attack=function(mob,target)
	local moved
	local owner
	local life_duration = 180 --(in seconds)
	local aethers = 10
	local targets = {}
	local owner_is
	local measure_threat
	local mobBlocks
	local highest_threat = 0
	local current_target
	local current_target_id

	owner = mob:getBlock(mob.owner)
	if (owner == nil) then
		mob:delete()
		return
	end
	if (owner ~= nil and owner.m ~= mob.m) then
		mob:warp(owner.m, owner.x, owner.y)
		return
	end

	if (os.time() > mob.registry["mob_life_timer"] + life_duration) then
		mob:delete()
		return
	end

	if (target ~= nil) then
		if (target.blType == 1) then
			target:setThreat(mob.ID, 0)
			mob.target = mob.owner
		end
		if (target.blType == 2) then
			if (target.summon == true) then
				mob.target = mob.owner
				target = owner
			end
		end
	end
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		sum_ent.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	

	mobBlocks = mob:getObjectsInArea(BL_MOB)

	if (#mobBlocks > 0) then
		for i = 1, #mobBlocks do
			owner_is = mob:getBlock(mob.owner)
			if (owner_is ~= nil) then
				measure_threat = mobBlocks[i]:checkThreat(mob.owner)
			end

			if (measure_threat > 0) then
				table.insert(targets, mobBlocks[i])

					if (measure_threat > highest_threat) then
						highest_threat = measure_threat
						current_target = mobBlocks[i]
						current_target_id = mobBlocks[i].ID
					end


			end
		end
	end

	if (#targets > 0) then
		target = current_target
		mob.target = current_target_id
	end


	if (target) then

		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
			if (os.time() >= mob.registry["special_cooldown"] and target ~= nil) then
				sum_ent.vine_attack(mob)
				mob.registry["special_cooldown"] = os.time() + aethers
			end

		moved=SummonFindCoords(mob,target)

		if(moved and mob.target ~= mob.owner and target.blType ~= 1) then
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,

getHighestThreatofMobtoOwner=function(mob)
		local threat_id = {}
		local threat_amount = {}
		local highest_threat = 0

		threat_id = mob:getObjectsInArea(BL_MOB)
		if(#threat_id>0) then
			for i=1 , #threat_id do
				if(threat_id[i]:checkThreat(mob.owner) ~= false) then
					threat_amount[i] = threat_id[i]:checkThreat(mob.owner)
				end
			end
		end

		if(#threat_amount>0) then
			for i=1 , #threat_amount do
				if(threat_amount[i] > highest_threat) then
					highest_threat = threat_amount[i]
				end
			end
		end
		return highest_threat
end,

vine_attack = function(mob)
		local damage = 0
		local owner = mob:getBlock(mob.owner)
		local enspiritCheck = 0

		if (owner == nil) then
			return
		else
			damage = (owner.level * 5) + (owner.will * 7)
			enspiritCheck = owner:magicDamageMod_enspirit(damage)
			damage = (enspiritCheck * 10)
		end

		local targets = getTargetsAroundDiamond(mob, BL_MOB)
		local exact_targets = {}

		if (#targets > 0) then
			for i = 1, #targets do
				if (targets[i].owner == 0 and targets[i].protection ~= 1) then
					table.insert(exact_targets, targets[i])
				end
			end
		end

		if (#exact_targets > 0) then
				for i = 1, #exact_targets do
					if(exact_targets[i].mrespawnfunc == 0) then
						owner:setThreat(exact_targets[i].ID, 0)
						exact_targets[i].attacker = mob.ID
						exact_targets[i].target = mob.ID

						exact_targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						exact_targets[i]:sendAnimationXY(196, exact_targets[i].x, exact_targets[i].y, 1)
					elseif(exact_targets[i].mrespawnfunc == 1) then
						exact_targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						exact_targets[i]:sendAnimationXY(196, exact_targets[i].x, exact_targets[i].y, 1)
					end
				end
				mob:playSound(47)
				mob:sendAction(6, 60)
		end
end

}