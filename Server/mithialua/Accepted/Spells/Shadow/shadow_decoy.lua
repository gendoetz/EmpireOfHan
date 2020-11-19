shadow_decoy = {
cast = function(player)
	local aether = 300000
	local magicCost = (.02 * player.maxMagic)
	local checkunder = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
	local item

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

	if (#checkunder > 0) then
		player:sendMinitext("You cant use this spell with an enemy under you.")
		return
	end

	player:sendAction(6, 20)
	player:setAether("shadow_decoy", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	--player:playSound(1)

	player:spawn(180, player.x, player.y, 1)
	
	local D = player:getObjectsInCell(player.m, player.x, player.y, BL_MOB)
	Mob(D[1].ID).owner = player.id
	Mob(D[1].ID).target = player.id
	Mob(D[1].ID).summon = true
	Mob(D[1].ID).side = player.side
	Mob(D[1].ID):sendSide()

					Mob(D[1].ID).maxHealth = player.maxHealth
					Mob(D[1].ID).health = Mob(D[1].ID).maxHealth
					Mob(D[1].ID).maxMagic = player.maxMagic
					Mob(D[1].ID).magic = Mob(D[1].ID).maxMagic

				if (player:getEquippedItem(EQ_WEAP) ~= nil) then
					item = player:getEquippedItem(EQ_WEAP)
					Mob(D[1].ID).gfxWeap = item.look
					Mob(D[1].ID).gfxWeapC = item.lookC
					Mob(D[1].ID).sound = item.sound
					Mob(D[1].ID).minDam = player.minDam
					Mob(D[1].ID).maxDam = player.maxDam
					Mob(D[1].ID).invis = player.rage
				else 
					Mob(D[1].ID).gfxWeap = 65535
				end
				
				if (player:getEquippedItem(EQ_ARMOR) ~= nil) then
					item = player:getEquippedItem(EQ_ARMOR)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC

					if(item.allowDye == 1 and player:getEquippedItem(EQ_COAT) == nil) then
						if (item.lookC < 0) then
							Mob(D[1].ID).gfxDye = item.lookC+player.armorColor
						else
							Mob(D[1].ID).gfxDye = player.armorColor
						end
					else
						Mob(D[1].ID).gfxDye = 0
					end
				else
					if (player.sex == 1) then
						Mob(D[1].ID).gfxArmor = 58
						Mob(D[1].ID).gfxArmorC = 29
					else
						Mob(D[1].ID).gfxArmor = 57
						Mob(D[1].ID).gfxArmorC = 29
					end

				end
				
				if (player:getEquippedItem(EQ_COAT) ~= nil) then
					item = player:getEquippedItem(EQ_COAT)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC

					if(item.allowDye == 1) then
						if (item.lookC < 0) then
							Mob(D[1].ID).gfxDye = item.lookC+player.armorColor
						else
							Mob(D[1].ID).gfxDye = player.armorColor
						end
					else
						Mob(D[1].ID).gfxDye = 0
					end
				end
				
				if (player:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = player:getEquippedItem(EQ_SHIELD)
					Mob(D[1].ID).gfxShield = item.look
					Mob(D[1].ID).gfxShieldC = item.lookC
				else
					Mob(D[1].ID).gfxShield = 65535
				end

				
				if (player:getEquippedItem(EQ_HELM) ~= nil and (player.settings - (player.settings % 8192)) / 8192 == 1) then
					item = player:getEquippedItem(EQ_HELM)
					Mob(D[1].ID).gfxHelm = item.look
					Mob(D[1].ID).gfxHelmC = item.lookC
				else
					Mob(D[1].ID).gfxHelm = 255
				end
				
				if (player:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = player:getEquippedItem(EQ_FACEACC)
					Mob(D[1].ID).gfxFaceA = item.look
					Mob(D[1].ID).gfxFaceAC = item.lookC
				else
					Mob(D[1].ID).gfxFaceA = 65535
				end
				
				Mob(D[1].ID).gfxFaceAT = 65535
				
				if (player:getEquippedItem(EQ_CROWN) ~= nil) then
					item = player:getEquippedItem(EQ_CROWN)
					Mob(D[1].ID).gfxCrown = item.look
					Mob(D[1].ID).gfxCrownC = item.lookC

					if(item.allowDye == 1) then
						Mob(D[1].ID).gfxCrownC = item.lookC+player.hairColor
					else
						Mob(D[1].ID).gfxCrownC = item.lookC
					end
				else
					Mob(D[1].ID).gfxCrown = 65535
				end
				
				if (player:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = player:getEquippedItem(EQ_MANTLE)
					Mob(D[1].ID).gfxCape = item.look
					Mob(D[1].ID).gfxCapeC = item.lookC
				else
					Mob(D[1].ID).gfxCape = 65535
				end
				
				if (player:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = player:getEquippedItem(EQ_NECKLACE)
					Mob(D[1].ID).gfxNeck = item.look
					Mob(D[1].ID).gfxNeckC = item.lookC
				else
					Mob(D[1].ID).gfxNeck = 65535
				end
				
				if (player:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = player:getEquippedItem(EQ_BOOTS)
					Mob(D[1].ID).gfxBoots = item.look
					Mob(D[1].ID).gfxBootsC = item.lookC
				else
					Mob(D[1].ID).gfxBoots = player.sex
				end
				
				Mob(D[1].ID).gfxFace = player.face
				Mob(D[1].ID).gfxHair = player.hair
				Mob(D[1].ID).gfxHairC = player.hairColor
				Mob(D[1].ID).gfxFaceC = player.faceColor
				Mob(D[1].ID).gfxSkinC = player.skinColor

				
				Mob(D[1].ID).gfxName = player.name
				Mob(D[1].ID).gfxClone = 1

				Mob(D[1].ID).might = player.might
				Mob(D[1].ID).will = player.will
				Mob(D[1].ID).grace = player.grace

				local blockPC = player:getObjectsInArea(BL_PC)
				if (#blockPC > 0) then
					for i = 1, #blockPC do
						blockPC[i]:refresh()
					end
				end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Shadow Self creates a shadow clone that will attack monsters you have attacked and will duplicate your vita attacks."}
	return level, items, itemAmounts, description
end
}

shadow_decoy_gm = {
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
			player:setAether("shadow_decoy", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(1)

			player:spawn(180, target.x, target.y, 1)
			local item
			local D = player:getObjectsInCell(target.m, target.x, target.y, BL_MOB)
			Mob(D[1].ID).owner = target.id
			Mob(D[1].ID).target = target.id
			Mob(D[1].ID).summon = true
			Mob(D[1].ID).side = target.side
			Mob(D[1].ID):sendSide()

					Mob(D[1].ID).maxHealth = target.maxHealth
					Mob(D[1].ID).health = Mob(D[1].ID).maxHealth
					Mob(D[1].ID).maxMagic = target.maxMagic
					Mob(D[1].ID).magic = Mob(D[1].ID).maxMagic

				if (target:getEquippedItem(EQ_WEAP) ~= nil) then
					item = target:getEquippedItem(EQ_WEAP)
					Mob(D[1].ID).gfxWeap = item.look
					Mob(D[1].ID).gfxWeapC = item.lookC
					Mob(D[1].ID).sound = item.sound
					Mob(D[1].ID).minDam = target.minDam
					Mob(D[1].ID).maxDam = target.maxDam
					Mob(D[1].ID).invis = target.rage
				else 
					Mob(D[1].ID).gfxWeap = 65535
				end
				
				if (target:getEquippedItem(EQ_ARMOR) ~= nil) then
					item = target:getEquippedItem(EQ_ARMOR)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC

					if(item.allowDye == 1 and target:getEquippedItem(EQ_COAT) == nil) then
						Mob(D[1].ID).gfxDye = target.armorColor
					else
						Mob(D[1].ID).gfxDye = 0
					end
				else
					Mob(D[1].ID).gfxArmor = target.sex
				end
				
				if (target:getEquippedItem(EQ_COAT) ~= nil) then
					item = target:getEquippedItem(EQ_COAT)
					Mob(D[1].ID).gfxArmor = item.look
					Mob(D[1].ID).gfxArmorC = item.lookC
					
					if(item.allowDye == 1) then
						Mob(D[1].ID).gfxDye = target.armorColor
					else
						Mob(D[1].ID).gfxDye = 0
					end
				end
				
				if (target:getEquippedItem(EQ_SHIELD) ~= nil) then
					item = target:getEquippedItem(EQ_SHIELD)
					Mob(D[1].ID).gfxShield = item.look
					Mob(D[1].ID).gfxShieldC = item.lookC
				else
					Mob(D[1].ID).gfxShield = 65535
				end
				
				if (target:getEquippedItem(EQ_HELM) ~= nil and (target.settings - (target.settings % 8192)) / 8192 == 1) then
					item = target:getEquippedItem(EQ_HELM)
					Mob(D[1].ID).gfxHelm = item.look
					Mob(D[1].ID).gfxHelmC = item.lookC
				else
					Mob(D[1].ID).gfxHelm = 255
				end
				
				if (target:getEquippedItem(EQ_FACEACC) ~= nil) then
					item = target:getEquippedItem(EQ_FACEACC)
					Mob(D[1].ID).gfxFaceA = item.look
					Mob(D[1].ID).gfxFaceAC = item.lookC
				else
					Mob(D[1].ID).gfxFaceA = 65535
				end
				
				Mob(D[1].ID).gfxFaceAT = 65535
				
				if (target:getEquippedItem(EQ_CROWN) ~= nil) then
					item = target:getEquippedItem(EQ_CROWN)
					Mob(D[1].ID).gfxCrown = item.look
					Mob(D[1].ID).gfxCrownC = item.lookC
				else
					Mob(D[1].ID).gfxCrown = 65535
				end
				
				if (target:getEquippedItem(EQ_MANTLE) ~= nil) then
					item = target:getEquippedItem(EQ_MANTLE)
					Mob(D[1].ID).gfxCape = item.look
					Mob(D[1].ID).gfxCapeC = item.lookC
				else
					Mob(D[1].ID).gfxCape = 65535
				end
				
				if (target:getEquippedItem(EQ_NECKLACE) ~= nil) then
					item = target:getEquippedItem(EQ_NECKLACE)
					Mob(D[1].ID).gfxNeck = item.look
					Mob(D[1].ID).gfxNeckC = item.lookC
				else
					Mob(D[1].ID).gfxNeck = 65535
				end
				
				if (target:getEquippedItem(EQ_BOOTS) ~= nil) then
					item = target:getEquippedItem(EQ_BOOTS)
					Mob(D[1].ID).gfxBoots = item.look
					Mob(D[1].ID).gfxBootsC = item.lookC
				else
					Mob(D[1].ID).gfxBoots = target.sex
				end
				
				Mob(D[1].ID).gfxFace = target.face
				Mob(D[1].ID).gfxHair = target.hair
				Mob(D[1].ID).gfxHairC = target.hairColor
				Mob(D[1].ID).gfxFaceC = target.faceColor
				Mob(D[1].ID).gfxSkinC = target.skinColor

				if (target:getEquippedItem(EQ_COAT) == nil) then
					Mob(D[1].ID).gfxDye = target.armorColor
				end

				Mob(D[1].ID).gfxName = target.name
				Mob(D[1].ID).gfxClone = 1

				Mob(D[1].ID).might = target.might
				Mob(D[1].ID).will = target.will
				Mob(D[1].ID).grace = target.grace

				local blockPC = player:getObjectsInArea(BL_PC)
				if (#blockPC > 0) then
					for i = 1, #blockPC do
						blockPC[i]:refresh()
					end
				end
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

shadow_decoy_mob = {
on_spawn = function(mob)
	mob.registry["mob_life_timer"] = os.time()
end,

on_healed = function(mob, healer)
	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	--mob.attacker = attacker.ID
	--mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,

after_death = function(mob, attacker, block)
	Player(mob.owner).registry["has_shadow_self"] = 0
	--Player(mob.owner):talk(0,"Action: "..Player(mob.owner).registry["has_shadow_self"])
end,
	
move = function(mob,target)
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

	if (os.time() > mob.registry["mob_life_timer"] + life_duration) then
		mob:delete()
		return
	end

	owner = mob:getBlock(mob.owner)
	if (owner ~= nil) then
		if (Player(mob.owner).registry["has_shadow_self"] == 0) then
			Player(mob.owner).registry["has_shadow_self"] = 1
		end
	end
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

	--mob:talk(2,"Mob Target "..mob.target)

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
		mob_ai_basic.move(mob, target)
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
				shadow_decoy_mob.dagger_attack(mob)
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

dagger_attack = function(mob)
		local damage = 0
		local owner = mob:getBlock(mob.owner)
		local enfocusCheck = 0

		if (owner == nil) then
			return
		else
			damage = (owner.level * 5) + (owner.grace * 7)
			enfocusCheck = damage * owner.rage
			damage = (enfocusCheck * 5)
		end

		local targets = getTargetsAround(mob, BL_MOB)
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
						exact_targets[i]:sendAnimationXY(44, exact_targets[i].x, exact_targets[i].y, 1)
					elseif(exact_targets[i].mrespawnfunc == 1) then
						exact_targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						exact_targets[i]:sendAnimationXY(44, exact_targets[i].x, exact_targets[i].y, 1)
					end
				end
				mob:playSound(38)
				mob:sendAction(6, 60)
		end
end,

mortal_shot = function(mob)
	local moved
	local damage = (mob.health) + (mob.magic)
	--local healthCost = (mob.health * .5)
	--local magicCost = mob.magic

		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
	if (target) then
		--threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=SummonFindCoords(mob,target)
		if (moved and mob.target ~= mob.owner and target.blType ~= 1) then
			--mob.health = mob.health - healthCost
			--mob.magic = mob.magic - magicCost

			mob:sendAction(1, 35)
			mob:playSound(100)

			target:sendAnimation(69, 0)
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end,

bloodletter = function(mob)
	local moved
	local damage = (mob.health * 0.5) + (mob.magic * 2.5)
	--local healthCost = (mob.health * .5)

		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
	if (target) then
		--threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
		moved=SummonFindCoords(mob,target)
		if (moved and mob.target ~= mob.owner and target.blType ~= 1) then
			--mob.health = mob.health - healthCost

			mob:sendAction(1, 35)
			mob:playSound(35)

			target:sendAnimation(423, 0)
			target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		end
	end
end
}