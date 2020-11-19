omnistrike = {
cast = function(player, target)
	local aether = 1000
	player.registry["mana_increase_fg"] = 15
	local element = player.registry["omnistrike_element"]
	local damagemod = (player.level * 2) + (player.will * 5)
	local anim = 40

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end

	if (element == 0) then
		if (player.registry["omnistrike_config"] == 1) then
			anim = 188
			damagemod = (player.level * 4) + (player.will * 5)
		else
			anim = 40
			if (player:hasDuration("inner_flame")) then
			anim = 41
			damagemod = (player.level * 3) + (player.will * 5)
			elseif (player:hasDuration("inner_flame2")) then
			anim = 42
			damagemod = (player.level * 5) + (player.will * 5)
			elseif (player:hasDuration("inner_flame3")) then
			anim = 43
			damagemod = (player.level * 7) + (player.will * 5)
			elseif (player:hasDuration("inner_flame4")) then
			anim = 43
			damagemod = (player.level * 9) + (player.will * 6)
			end
		end
	elseif (element == 1) then
		if (player.registry["omnistrike_config"] == 1) then
			anim = 392
			damagemod = (player.level * 4) + (player.will * 5)
		else
			anim = 23
			if (player:hasDuration("inner_frost")) then
			anim = 24
			damagemod = (player.level * 3) + (player.will * 5)
			elseif (player:hasDuration("inner_frost2")) then
			anim = 25
			damagemod = (player.level * 5) + (player.will * 5)
			elseif (player:hasDuration("inner_frost3")) then
			anim = 26
			damagemod = (player.level * 7) + (player.will * 5)
			elseif (player:hasDuration("inner_frost4")) then
			anim = 26
			damagemod = (player.level * 9) + (player.will * 6)
			end
		end
	end

	local damage = damagemod
	local threat
	--local healthCost = (.005 * player.maxHealth)
	local magicCost = (.02 * player.maxMagic)
	local minHealth = 50

		local enspellCheck = player:magicDamageMod_enspell(damage)

		damage = enspellCheck
	
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasAether("cast_limit")) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	--FIRE
	if (element == 0) then
		if (target.blType == BL_MOB) then
			player:sendAction(6, 20)
			player:setAether("cast_limit", aether)
			--player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(735)
		
				target:sendAnimation(anim, 1)
				player:sendMinitext("You cast Omnistrike.")
				-- Code for x5 way hit. if player has Elemental Amplification
				-- Start
				if (player:hasDuration("elemental_amplification")) then
					local targets = {}
					local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
					local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
					local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
					local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

						if (#targetsLeft > 0) then
							if (targetsLeft[1].blType == BL_MOB and targetsLeft[1].protection ~= 1) then
								table.insert(targets, targetsLeft[1])
							end
							if (targetsLeft[1].blType == BL_PC) then
								table.insert(targets, targetsLeft[1])
							end
						end
						
						if (#targetsRight > 0) then
							--table.insert(targets, targetsRight[1])

							if (targetsRight[1].blType == BL_MOB and targetsRight[1].protection ~= 1) then
								table.insert(targets, targetsRight[1])
							end
							if (targetsRight[1].blType == BL_PC) then
								table.insert(targets, targetsRight[1])
							end
						end
						
						if (#targetsUp > 0) then
							--table.insert(targets, targetsUp[1])

							if (targetsUp[1].blType == BL_MOB and targetsUp[1].protection ~= 1) then
								table.insert(targets, targetsUp[1])
							end
							if (targetsUp[1].blType == BL_PC) then
								table.insert(targets, targetsUp[1])
							end
						end
						
						if (#targetsDown > 0) then
							--table.insert(targets, targetsDown[1])

							if (targetsDown[1].blType == BL_MOB and targetsDown[1].protection ~= 1) then
								table.insert(targets, targetsDown[1])
							end
							if (targetsDown[1].blType == BL_PC) then
								table.insert(targets, targetsDown[1])
							end
						end

						if (#targets > 0) then
							for i = 1, #targets do
								targets[i].attacker = player.ID
								threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
								player:addThreat(targets[i].ID, threat)
								if (#player.group > 1) then
									targets[i]:setGrpDmg(player.ID, threat)
								else
									targets[i]:setIndDmg(player.ID, threat)
								end			
								targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
								targets[i]:sendAnimation(anim, 0)
							end
						end
				end
				--End

				target.attacker = player.ID
				threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(target.ID, threat)
				
				if (#player.group > 1) then
					target:setGrpDmg(player.ID, threat)
				else
					target:setIndDmg(player.ID, threat)
				end
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player:setAether("cast_limit", aether)
			--player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(735)
		

				target:sendAnimation(anim, 1)
				player:sendMinitext("You cast Omnistrike.")
				target.attacker = player.ID
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendMinitext(player.name.." blasts you with Omnistrike.")
		end
		--Set Fire Increase
		--player:setDuration("fire_power", 100000, 0, 1)
	if (not player:hasDuration("inner_flame") and not player:hasDuration("inner_flame2") and not player:hasDuration("inner_flame3") and not player:hasDuration("inner_flame4")) then
		player:setDuration("inner_flame", 100000)
	elseif (player:hasDuration("inner_flame")) then
		player:setDuration("inner_flame", 0)
		player:setDuration("inner_flame2", 100000)
	elseif (player:hasDuration("inner_flame2")) then
		player:setDuration("inner_flame2", 0)
		player:setDuration("inner_flame3", 100000)
	elseif (player:hasDuration("inner_flame3")) then
		player:setDuration("inner_flame3", 0)
		player:setDuration("inner_flame4", 100000)
	end

	elseif (element == 1) then
		if (target.blType == BL_MOB) then
			player:sendAction(6, 20)
			player:setAether("cast_limit", aether)
			--player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(48)
		
				target:sendAnimation(anim, 1)
				player:sendMinitext("You cast Omnistrike.")
				-- Code for x5 way hit. if player has Elemental Amplification
				-- Start
				if (player:hasDuration("elemental_amplification")) then
					local targets = {}
					local targetsLeft = target:getObjectsInCell(target.m, target.x - 1, target.y, BL_MOB)
					local targetsRight = target:getObjectsInCell(target.m, target.x + 1, target.y, BL_MOB)
					local targetsUp = target:getObjectsInCell(target.m, target.x, target.y - 1, BL_MOB)
					local targetsDown = target:getObjectsInCell(target.m, target.x, target.y + 1, BL_MOB)

						if (#targetsLeft > 0) then
							if (targetsLeft[1].blType == BL_MOB and targetsLeft[1].protection ~= 1) then
								table.insert(targets, targetsLeft[1])
							end
							if (targetsLeft[1].blType == BL_PC) then
								table.insert(targets, targetsLeft[1])
							end
						end
						
						if (#targetsRight > 0) then
							--table.insert(targets, targetsRight[1])

							if (targetsRight[1].blType == BL_MOB and targetsRight[1].protection ~= 1) then
								table.insert(targets, targetsRight[1])
							end
							if (targetsRight[1].blType == BL_PC) then
								table.insert(targets, targetsRight[1])
							end
						end
						
						if (#targetsUp > 0) then
							--table.insert(targets, targetsUp[1])

							if (targetsUp[1].blType == BL_MOB and targetsUp[1].protection ~= 1) then
								table.insert(targets, targetsUp[1])
							end
							if (targetsUp[1].blType == BL_PC) then
								table.insert(targets, targetsUp[1])
							end
						end
						
						if (#targetsDown > 0) then
							--table.insert(targets, targetsDown[1])

							if (targetsDown[1].blType == BL_MOB and targetsDown[1].protection ~= 1) then
								table.insert(targets, targetsDown[1])
							end
							if (targetsDown[1].blType == BL_PC) then
								table.insert(targets, targetsDown[1])
							end
						end

						if (#targets > 0) then
							for i = 1, #targets do
								targets[i].attacker = player.ID
								threat = targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 2)
								player:addThreat(targets[i].ID, threat)
								if (#player.group > 1) then
									targets[i]:setGrpDmg(player.ID, threat)
								else
									targets[i]:setIndDmg(player.ID, threat)
								end			
								targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
								targets[i]:sendAnimation(anim, 0)
							end
						end
				end
				--End



				target.attacker = player.ID
				threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(target.ID, threat)
				
				if (#player.group > 1) then
					target:setGrpDmg(player.ID, threat)
				else
					target:setIndDmg(player.ID, threat)
				end
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player:setAether("cast_limit", aether)
			--player.health = player.health - healthCost
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:playSound(48)
		

				target:sendAnimation(anim, 1)
				player:sendMinitext("You cast Omnistrike.")
				target.attacker = player.ID
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendMinitext(player.name.." blasts you with Omnistrike.")
		end
			if (not player:hasDuration("inner_frost") and not player:hasDuration("inner_frost2") and not player:hasDuration("inner_frost3") and not player:hasDuration("inner_frost4")) then
				player:setDuration("inner_frost", 100000)
			elseif (player:hasDuration("inner_frost")) then
				player:setDuration("inner_frost", 0)
				player:setDuration("inner_frost2", 100000)
			elseif (player:hasDuration("inner_frost2")) then
				player:setDuration("inner_frost2", 0)
				player:setDuration("inner_frost3", 100000)
			elseif (player:hasDuration("inner_frost3")) then
				player:setDuration("inner_frost3", 0)
				player:setDuration("inner_frost4", 100000)
			end
	end	
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Omnistrike is a mage's ultimate offensive spell growing in strength with continued use."}
	return level, items, itemAmounts, description
end
}

omniblast = {
cast = function(player, target)
	local aether = 15000
	--0 = Fire 1 = Ice
	local element = player.registry["omnistrike_element"]

	if (target.blType == BL_MOB and target.protection == 1) then
		player:sendMinitext("You can't use this on that target.")
		return
	end

	local damagemod = ((player.level * 6) + (player.will * 5)) * 2
	if (player:hasDuration("inner_flame")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 2.5
	elseif (player:hasDuration("inner_flame2")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 3
	elseif (player:hasDuration("inner_flame3")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 3.5
	elseif (player:hasDuration("inner_flame4")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 4
	end

	if (player:hasDuration("inner_frost")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 2.5
	elseif (player:hasDuration("inner_frost2")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 3
	elseif (player:hasDuration("inner_frost3")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 3.5
	elseif (player:hasDuration("inner_frost4")) then
	damagemod = ((player.level * 6) + (player.will * 5)) * 4
	end

	local damage = damagemod
	local threat
	--local healthCost = (.005 * player.maxHealth)
	local magicCost = (.02 * player.maxMagic)
	local magicRestore = player.maxMagic * .85
	local minHealth = 50

		local enspellCheck = player:magicDamageMod_enspell(damage)

		damage = enspellCheck
	
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	--FIRE
	if (element == 0) then
		if (target.blType == BL_MOB) then
			player:sendAction(6, 20)
			player:setAether("omniblast", aether)
			--player.health = player.health - healthCost
			--player.magic = player.magic - magicCost
			--player.magic = player.magic + magicRestore
			--player:sendStatus()
			player:addMagic(magicRestore)
			player:sendAnimation(295, 1)
			player:playSound(34)
			player:playSound(735)
		
				target:sendAnimation(252, 1)
				player:sendMinitext("You cast Omniblast.")
				target.attacker = player.ID
				threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(target.ID, threat)
				
				if (#player.group > 1) then
					target:setGrpDmg(player.ID, threat)
				else
					target:setIndDmg(player.ID, threat)
				end
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player:setAether("omniblast", aether)
			--player.health = player.health - healthCost
			--player.magic = player.magic - magicCost
			--player.magic = player.magic + magicRestore
			--player:sendStatus()
			player:addMagic(magicRestore)
			player:sendAnimation(295, 1)
			player:playSound(34)
			player:playSound(735)
		

				target:sendAnimation(252, 1)
				player:sendMinitext("You cast Omniblast.")
				target.attacker = player.ID
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendMinitext(player.name.." casts Omniblast on you.")
		end
		--Set Fire Increase
		--player:setDuration("fire_power", 100000, 0, 1)
	if (player:hasDuration("inner_flame")) then
		player:setDuration("inner_flame", 0)
	elseif (player:hasDuration("inner_flame2")) then
		player:setDuration("inner_flame2", 0)
	elseif (player:hasDuration("inner_flame3")) then
		player:setDuration("inner_flame3", 0)
	elseif (player:hasDuration("inner_flame4")) then
		player:setDuration("inner_flame4", 0)
	end
	--switch to ice
	player.registry["omnistrike_element"] = 1

	elseif (element == 1) then
		if (target.blType == BL_MOB) then
			player:sendAction(6, 20)
			player:setAether("omniblast", aether)
			--player.health = player.health - healthCost
			--player.magic = player.magic - magicCost
			--player:sendStatus()
			player:addMagic(magicRestore)
			player:sendAnimation(295, 1)
			player:playSound(34)
			player:playSound(48)
		
				target:sendAnimation(187, 1)
				player:sendMinitext("You cast Omniblast.")
				target.attacker = player.ID
				threat = target:removeHealthExtend(damage, 1, 1, 1, 1, 2)
				player:addThreat(target.ID, threat)
				
				if (#player.group > 1) then
					target:setGrpDmg(player.ID, threat)
				else
					target:setIndDmg(player.ID, threat)
				end
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			
		elseif (target.blType == BL_PC and player:canPK(target)) then
			player:sendAction(6, 20)
			player:setAether("omniblast", aether)
			--player.health = player.health - healthCost
			--player.magic = player.magic - magicCost
			--player:sendStatus()
			player:addMagic(magicRestore)
			player:sendAnimation(295, 1)
			player:playSound(34)
			player:playSound(48)
		

				target:sendAnimation(187, 1)
				player:sendMinitext("You cast Omniblast.")
				target.attacker = player.ID
				target:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				target:sendMinitext(player.name.." blasts you with Omnistrike.")
		end
			if (player:hasDuration("inner_frost")) then
				player:setDuration("inner_frost", 0)
			elseif (player:hasDuration("inner_frost2")) then
				player:setDuration("inner_frost2", 0)
			elseif (player:hasDuration("inner_frost3")) then
				player:setDuration("inner_frost3", 0)
			elseif (player:hasDuration("inner_frost4")) then
				player:setDuration("inner_frost4", 0)
			end

			player.registry["omnistrike_element"] = 0
	end
end,

requirements = function(player)
	local level = 90
	local items = {}
	local itemAmounts = {}
	local description = {"Omniblast releases build up of magical energy the mage has accumulated. Schools of magic will shift after casting this spell."}
	return level, items, itemAmounts, description
end
}