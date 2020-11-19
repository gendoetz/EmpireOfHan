summon_elemental = {
cast = function(player, target)
	local aether = 1000
	local magicCost = (.02 * player.maxMagic)

	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	if (target.blType == BL_PC) then
		player:sendAction(6, 20)
		player:setAether("summon_elemental", aether)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(1)

		player:spawn(168, target.x, target.y, 1)
		local D = player:getObjectsInCell(target.m, target.x, target.y, BL_MOB)
		Mob(D[1].ID).owner = target.id
		Mob(D[1].ID).target = target.id
		Mob(D[1].ID).summon = true
	else
		player:sendMinitext("You may only cast this on players.")
	end

end,

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"Summon."}
	return level, items, itemAmounts, description
end
}

sum_moltenbeast = {
click = async(function(player, mob)
	if (player.id == mob.owner) then
		local mobG = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
		player.npcGraphic = mobG.graphic
		player.npcColor = mobG.color
		local options = {"Attack: Anything I attack (Threat)", "Attack: Special Ability", "Return: Attack Off & Return"}
		local blockPC = mob:getObjectsInArea(BL_PC)
		
		local menuOpt = player:menu("The Great Ent awaits your command.", options)
		if (menuOpt == 1) then
			--mob.target = player.attacker
			mob.registry["attack_on"] = 1
			--mob.target = player.attacker
			--mob:move()
			--if (mob.look ~= 19) then
				--mob.look = 19
				--[[mob.lookColor = 1
				if (#blockPC > 0) then
					for i = 1, #blockPC do
						blockPC[i]:refresh()
					end
				end]]
			--end
		elseif (menuOpt == 2) then
			--if (target ~= nil) then
				local aethers = 60
				if (os.time() >= mob.registry["special_cooldown"] + aethers) then
					--mob:talk(2,"Special"..target.id)
					sum_moltenbeast.vine_attack(mob)
					mob.registry["special_cooldown"] = os.time()
				else
					player:sendMinitext("That ability is not ready yet.")
				end
			--end
			--mob.registry["attack_on"] = 1
			--local mobTarget = getTargetFacing(player, BL_MOB)
			--sum_moltenbeast.move(mob, mobTarget)
			--local checkblock = player:getBlock(mobTarget.id)
			--player.attacker = mobTarget.ID
			--mob.target = player.attacker
			--player:talk(0,"Mob "..mobTarget.id)
		elseif (menuOpt == 3) then
			mob.registry["attack_on"] = 2
			mob.target = mob.owner
			--sum_moltenbeast.move(mob, player)
			--if (mob.look ~= 20) then
				--mob.look = 20
				--[[mob.lookColor = 0
				if (#blockPC > 0) then
					for i = 1, #blockPC do
						blockPC[i]:refresh()
					end
				end]]
			--end
		end
	end
end),

on_spawn = function(mob)
	mob.registry["attack_on"] = 1
	mob.registry["mob_life_timer"] = os.time()
end,

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)
	local moved = true
	local oldside = mob.side
	local checkmove = math.random(0,10)
	local targets = {}
	local owner_is
	local owner
	local life_duration = 18000 --(in seconds)
	local highest_threat = 0
	local current_target
	local current_target_id

	if (os.time() > mob.registry["mob_life_timer"] + life_duration) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end

--Look at all the monsters and attack ones that have threat for owner.
--local mobTarget = getTargetFacing(player, BL_MOB)
--checkThreat([num]playerID)owner_is = mob:getBlock(mob.owner)
	owner = mob:getBlock(mob.owner)
	if (owner == nil) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end
	if (owner ~= nil and owner.m ~= mob.m) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end

		--local mobBlocks = player:getObjectsInArea(BL_MOB)
	--mob:checkThreat(target.id)
	if (target ~= nil) then
		if (target.blType == 1) then
			local threaten = mob:checkThreat(target.id)
			target:setThreat(mob.ID, 0)

			--mob:talk(2,"Mob Target "..threaten)
			mob.target = mob.owner
		end
	end

	if (mob.registry["attack_on"] == 1) then
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

					--mob:talk(2,"Mob Threat "..measure_threat)
					--added
						if (measure_threat > highest_threat) then
							highest_threat = measure_threat
							current_target = mobBlocks[i]
							current_target_id = mobBlocks[i].ID
							--mob.state = MOB_HIT
						end
					--added

				end
			end
		end

		if (#targets > 0) then
			target = current_target
			mob.target = current_target_id
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

				--mob:talk(2,"Mob Target "..mob.target)
				moved=SummonFindCoords(mob,target)

				if((moved or mob:moveIntent(target.ID) == 1) and mob.target ~= mob.owner and target.blType ~= 1) then
						mob:attack(target.ID)
						mob.state = MOB_HIT
				end
			end
		end
end,

attack=function(mob,target)
	local moved
	local owner

	owner = mob:getBlock(mob.owner)
	if (owner == nil) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end
	if (owner ~= nil and owner.m ~= mob.m) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end
	--mob:talk(2,"Stuck? "..mob.target)

	if (target ~= nil) then
		if (target.blType == 1) then
			target:setThreat(mob.ID, 0)
			mob.target = mob.owner
		end
	end
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (target) then
		--threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=SummonFindCoords(mob,target)
		if(moved and mob.target ~= mob.owner and target.blType ~= 1) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,

vine_attack = function(mob)
		local damage = 9999

		local targets = getTargetsAroundDiamond(mob, BL_MOB)
		local exact_targets = {}

		if (#targets > 0) then
			for i = 1, #targets do
				if (targets[i].owner == 0) then
					table.insert(exact_targets, targets[i])
				end
			end
		end

		if (#exact_targets > 0) then
				for i = 1, #exact_targets do
						exact_targets[i].attacker = mob.ID
						exact_targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						exact_targets[i]:sendAnimationXY(196, exact_targets[i].x, exact_targets[i].y, 1)
				end
				mob:playSound(47)
				mob:sendAction(6, 60)
			--end
		end
end

}