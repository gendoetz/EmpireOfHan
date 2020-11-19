elemental_emanation = {
cast = function(player)
player:freeAsync()
elemental_emanation.popup(player)
end,

popup = async(function(player)
	local t = {graphic = convertGraphic(1201, "monster"), color = 2}
	local aether = 180000
	local menuOptions = {}
	local magicCost = 1000
	
	table.insert(menuOptions, "Ice")
	table.insert(menuOptions, "Fire")

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

	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
		local choice = player:menuString("Which elemental emanation will you invoke?", menuOptions)
		if(choice == "Ice") then

		local passCheck = getPass(player.m, player.x, player.y + 1)
		local objCheck = getObject(player.m, player.x, player.y + 1)
		local blockcheck = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
		local targets = {}

				if (#blockcheck == 0) then
				blockcheck = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
				end

				if (#blockcheck > 0) then
					table.insert(targets, blockcheck[1])
				end

				if (#targets > 0 or objCheck == 1 or passCheck == 1) then
					player:sendMinitext("There is an obstruction here.")
					return
				end
					if (player.magic < magicCost) then
						player:sendMinitext("Not enough mana.")
						return
					end
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendAction(6, 20)
				player:playSound(50)

				player:sendAnimationXY(133, player.x, player.y + 1, 0)
				player:spawn(72, player.x, player.y + 1, 1)

				local D = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
				Mob(D[1].ID).owner = player.id
				Mob(D[1].ID).target = player.id
				Mob(D[1].ID).summon = true

				player:setAether("elemental_emanation", aether)

		elseif(choice == "Fire") then

		local passCheck = getPass(player.m, player.x, player.y + 1)
		local objCheck = getObject(player.m, player.x, player.y + 1)
		local blockcheck = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
		local targets = {}

				if (#blockcheck == 0) then
				blockcheck = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
				end

				if (#blockcheck > 0) then
					table.insert(targets, blockcheck[1])
				end

				if (#targets > 0 or objCheck == 1 or passCheck == 1) then
					player:sendMinitext("There is an obstruction here.")
					return
				end
					if (player.magic < magicCost) then
						player:sendMinitext("Not enough mana.")
						return
					end
				player.magic = player.magic - magicCost
				player:sendStatus()
				player:sendAction(6, 20)
				player:playSound(50)

				player:sendAnimationXY(133, player.x, player.y + 1, 0)
				player:spawn(73, player.x, player.y + 1, 1)
				
				local D = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)
				Mob(D[1].ID).owner = player.id
				Mob(D[1].ID).target = player.id
				Mob(D[1].ID).summon = true

				player:setAether("elemental_emanation", aether)
		end
end),

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Elemental Emanation allows a skilled Elementalist to place constructs imbued with magical spells. Constructs will drain energy from their creator when depleated."}
	return level, items, itemAmounts, description
end
}

ice_emanation = {
click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local mp_percent = (mob.magic / mob.maxMagic) * 100
	local hp_percent = (mob.health / mob.maxHealth) * 100

	local mp = "{||||||||||}"
	local hp = "{||||||||||}"

	if (mp_percent < 100) then
		hp = "{||||||||| }"
	end
	if (mp_percent <= 90) then
		mp = "{||||||||  }"
	end
	if (mp_percent <= 80) then
		mp = "{|||||||   }"
	end
	if (mp_percent <= 70) then
		mp = "{||||||    }"
	end
	if (mp_percent <= 60) then
		mp = "{|||||     }"
	end
	if (mp_percent <= 50) then
		mp = "{||||      }"
	end
	if (mp_percent <= 40) then
		mp = "{|||       }"
	end
	if (mp_percent <= 30) then
		mp = "{||        }"
	end
	if (mp_percent <= 20) then
		mp = "{|         }"
	end
	if (mp_percent <= 10) then
		mp = "{          }"
	end

	if (hp_percent < 100) then
		hp = "{||||||||| }"
	end
	if (hp_percent <= 90) then
		hp = "{||||||||  }"
	end
	if (hp_percent <= 80) then
		hp = "{|||||||   }"
	end
	if (hp_percent <= 70) then
		hp = "{||||||    }"
	end
	if (hp_percent <= 60) then
		hp = "{|||||     }"
	end
	if (hp_percent <= 50) then
		hp = "{||||      }"
	end
	if (hp_percent <= 40) then
		hp = "{|||       }"
	end
	if (hp_percent <= 30) then
		hp = "{||        }"
	end
	if (hp_percent <= 20) then
		hp = "{|         }"
	end
	if (hp_percent <= 10) then
		hp = "{          }"
	end


	player:dialogSeq({t, "Health: "..hp.." "..math.floor(hp_percent).."%\nMagic:  "..mp.." "..math.floor(mp_percent).."%"}, 0)

end),

on_healed = function(mob, healer)
mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	return
end,

on_spawn = function(mob)
	local lifetimer = 10
	mob.registry["lifeduration"] = os.time() + lifetimer

	local elementalist = mob:getObjectsInCell(mob.m, mob.x, mob.y - 1, BL_PC)
	mob.owner = elementalist[1].ID
	mob.maxMagic = Player(mob.owner).maxMagic
	mob.magic = mob.maxMagic
	mob.maxHealth = Player(mob.owner).maxHealth
	mob.health = mob.maxHealth
	--mob:talk(0,"Owner:"..mob.owner.."Health:"..mob.health.."Mana:"..mob.magic.."")
end,

move = function(mob, target)
	--Life Cycle
	if (os.time() > mob.registry["lifeduration"]) then
		mob.registry["lifeduration"] = os.time() + 10
		local damage = (mob.maxHealth * .10)
		mob:removeHealth(damage)
		--mob.health = mob.health - (mob.maxHealth * .10)
		mob:sendHealth(0, 0)
		--if (mob.health <= (mob.maxHealth * .11)) then
		--	mob:delete()
		--end
	end
	local magicCost = 500
	local range = 4
	local creatorsrange = 7

	--if (mob.magic < magicCost or mob.magic == 0) then
	--	Player(mob.owner).magic = Player(mob.owner).magic - magicCost
	--	Player(mob.owner):sendStatus()
	--end
	--Kill emanation if elementalist goes out of range
	if (distance(mob, Player(mob.owner)) > creatorsrange) then
		mob:delete()
	end
	--Freeze aproaching targets
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local playsoundonce = 0

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if ((distance(mob, mobBlocks[i]) <= range) and not mobBlocks[i]:hasDuration("freeze") and mobBlocks[i].behavior ~= 2 and mobBlocks[i].owner == 0) then
						if (mob.magic > magicCost) then
							mob.magic = mob.magic - magicCost
							--mob:playSound(73)
							playsoundonce = 1

							mobBlocks[i]:sendAnimation(52, 0)
							mobBlocks[i]:setDuration("freeze", 20000)
							mobBlocks[i].paralyzed = true
							--mob:talk(0,"Mana:"..mob.magic.."")
						--elseif (Player(mob.owner).magic > magicCost) then
							--Player(mob.owner).magic = Player(mob.owner).magic - magicCost
							--Player(mob.owner):sendAnimation(133, 0)
							--mob:sendAnimation(133, 0)
							--Player(mob.owner):sendStatus()
							--mob:playSound(73)
							--mobBlocks[i]:sendAnimation(52, 0)
							--mobBlocks[i]:setDuration("freeze", 20000)
							--mobBlocks[i].paralyzed = true
							--mob:talk(0,"Mana:"..mob.magic.."")
						else
							--mob:talk(0,"No one has mana.")
							return
						end
				end
			end
		end
		if (playsoundonce == 1) then
			mob:playSound(73)
			playsoundonce = 0
		end
end,

attack = function(mob, target)
	ice_emanation.move(mob, target)
end,
}

fire_emanation = {
click = async(function(player, mob)
	local t = {graphic = convertGraphic(mob.look, "monster"), color = mob.lookColor}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	local mp_percent = (mob.magic / mob.maxMagic) * 100
	local hp_percent = (mob.health / mob.maxHealth) * 100

	local mp = "{||||||||||}"
	local hp = "{||||||||||}"

	if (mp_percent < 95) then
		hp = "{||||||||| }"
	end
	if (mp_percent <= 90) then
		mp = "{||||||||  }"
	end
	if (mp_percent <= 80) then
		mp = "{|||||||   }"
	end
	if (mp_percent <= 70) then
		mp = "{||||||    }"
	end
	if (mp_percent <= 60) then
		mp = "{|||||     }"
	end
	if (mp_percent <= 50) then
		mp = "{||||      }"
	end
	if (mp_percent <= 40) then
		mp = "{|||       }"
	end
	if (mp_percent <= 30) then
		mp = "{||        }"
	end
	if (mp_percent <= 20) then
		mp = "{|         }"
	end
	if (mp_percent <= 10) then
		mp = "{          }"
	end

	if (hp_percent < 95) then
		hp = "{||||||||| }"
	end
	if (hp_percent <= 90) then
		hp = "{||||||||  }"
	end
	if (hp_percent <= 80) then
		hp = "{|||||||   }"
	end
	if (hp_percent <= 70) then
		hp = "{||||||    }"
	end
	if (hp_percent <= 60) then
		hp = "{|||||     }"
	end
	if (hp_percent <= 50) then
		hp = "{||||      }"
	end
	if (hp_percent <= 40) then
		hp = "{|||       }"
	end
	if (hp_percent <= 30) then
		hp = "{||        }"
	end
	if (hp_percent <= 20) then
		hp = "{|         }"
	end
	if (hp_percent <= 10) then
		hp = "{          }"
	end


	player:dialogSeq({t, "Health: "..hp.." "..math.floor(hp_percent).."%\nMagic:  "..mp.." "..math.floor(mp_percent).."%"}, 0)

end),

on_healed = function(mob, healer)
mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	return
end,

on_spawn = function(mob)
	local lifetimer = 10
	mob.registry["lifeduration"] = os.time() + lifetimer

	local elementalist = mob:getObjectsInCell(mob.m, mob.x, mob.y - 1, BL_PC)
	mob.owner = elementalist[1].ID
	mob.maxMagic = Player(mob.owner).maxMagic
	mob.magic = mob.maxMagic
	mob.maxHealth = Player(mob.owner).maxHealth
	mob.health = mob.maxHealth
	--mob:talk(0,"Owner:"..mob.owner.."Health:"..mob.health.."Mana:"..mob.magic.."")
end,

move = function(mob, target)
	--Life Cycle
	if (os.time() > mob.registry["lifeduration"]) then
		mob.registry["lifeduration"] = os.time() + 10
		local damage = (mob.maxHealth * .10)
		mob:removeHealth(damage)
		--mob.health = mob.health - (mob.maxHealth * .10)
		mob:sendHealth(0, 0)
		--if (mob.health <= (mob.maxHealth * .11)) then
		--	mob:delete()
		--end
	end
	local magicCost = 500
	local range = 4
	local creatorsrange = 7

	--if (mob.magic < magicCost or mob.magic == 0) then
	--	Player(mob.owner).magic = Player(mob.owner).magic - magicCost
	--	Player(mob.owner):sendStatus()
	--end
	--Kill emanation if elementalist goes out of range
	if (distance(mob, Player(mob.owner)) > creatorsrange) then
		mob:delete()
	end
	--Freeze aproaching targets
	local mobBlocks = mob:getObjectsInArea(BL_MOB)
	local playsoundonce = 0

		if (#mobBlocks > 0) then
			for i = 1, #mobBlocks do
				if ((distance(mob, mobBlocks[i]) <= range) and not mobBlocks[i]:hasDuration("hindrance3") and mobBlocks[i].behavior ~= 2 and mobBlocks[i].owner == 0) then
						if (mob.magic > magicCost) then
							mob.magic = mob.magic - magicCost
							--mob:playSound(43)
							playsoundonce = 1

							mobBlocks[i]:sendAnimation(53, 0)
							mobBlocks[i]:setDuration("hindrance3", 30000)
							mobBlocks[i].deduction = mobBlocks[i].deduction + .35
							mobBlocks[i].snare = true
							--mob:talk(0,"Mana:"..mob.magic.."")
						--elseif (Player(mob.owner).magic > magicCost) then
							--Player(mob.owner).magic = Player(mob.owner).magic - magicCost
							--Player(mob.owner):sendAnimation(133, 0)
							--mob:sendAnimation(133, 0)
							--Player(mob.owner):sendStatus()
							--mob:playSound(73)
							--mobBlocks[i]:sendAnimation(52, 0)
							--mobBlocks[i]:setDuration("freeze", 20000)
							--mobBlocks[i].paralyzed = true
							--mob:talk(0,"Mana:"..mob.magic.."")
						else
							--mob:talk(0,"No one has mana.")
							return
						end
				end
			end
		end
		if (playsoundonce == 1) then
			mob:playSound(43)
			playsoundonce = 0
		end
end,

attack = function(mob, target)
	fire_emanation.move(mob, target)
end,
}

emanation_refresh = {
cast = function(player, target)
	local aether = 6000
	local magicCost = player.maxMagic / 2

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
	
	if (target.blType == BL_MOB and target.owner == player.id) then
		player:sendAnimation(133, 0)
		target:sendAnimation(133, 0)
		player:playSound(74)
		player.magic = player.magic - magicCost
		player:sendStatus()
		target.magic = target.maxMagic
		player:setAether("emanation_refresh", aether)
		--target:talk(0,"Mana:"..target.magic.."")
	else
		player:sendMinitext("You must target your own construct.")
	end
end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Emanation: Refresh takes half your mana to restore the full mana of a construct."}
	return level, items, itemAmounts, description
end
}

emanation_regen = {
cast = function(player, target)
	local aether = 6000
	local magicCost = player.maxMagic *.05
	local heal = (player.magic / 2) + (player.health / 2)

	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.blType == BL_MOB and target.owner == player.id) then
		player:sendAnimation(132, 0)
		target:sendAnimation(132, 0)
		player:playSound(74)
		player.magic = player.magic - magicCost
		player:sendStatus()
		target.attacker = player.ID
		target:addHealthExtend(heal, 0, 0, 0, 0, 0)
		player:setAether("emanation_regen", aether)
	else
		player:sendMinitext("You must target your own construct.")
	end

end,

requirements = function(player)
	local level = 85
	local items = {}
	local itemAmounts = {}
	local description = {"Emanation: Regen restores the health of your construct based on the pools of your current combined vitality and mana."}
	return level, items, itemAmounts, description
end
}