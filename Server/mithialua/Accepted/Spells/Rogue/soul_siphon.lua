soul_siphon = {
cast = function(player)
	--local weapon = player:getEquippedItem(EQ_WEAP)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	--local sound = 9
	local aether = 20000
	local magicCost = (.33 * player.magic)
	local damage = (magicCost * .80 / 5)
	--player.registry["siphon_damage"] = (magicCost * .80 / 5)

	local threat

	if (not player:canCast(1, 1, 1)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
		
	if (mobTarget == nil and pcTarget == nil) then
		player:sendMinitext("That is no longer useful.")
		return
	end
	
	if (mobTarget ~= nil) then

		if(mobTarget.protection == 1) then
			return
		end

	player:setAether("soul_siphon", aether)
	player:sendAction(1, 20)
	player:sendMinitext("You are slowly siphoning vitality.")
	player:playSound(13)

		player.magic = player.magic - magicCost
		player:sendStatus()
		mobTarget:sendAnimation(293, 0)
		--player:sendAnimation(310, 0)
		--player:addHealth((player.maxHealth/2)/10)
		player:setDuration("soul_siphon_hot",9000)
		player.registry["siphon_target_mob"] = mobTarget.id
		--player:setDuration("soul_siphon_heal",10000,player.ID)
			mobTarget.attacker = player.id
			threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
			player:addThreat(mobTarget.id, threat)
			
			if (#player.group > 1) then
				mobTarget:setGrpDmg(player.id, threat)
			else
				mobTarget:setIndDmg(player.id, threat)
			end
		--mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		mobTarget:setDuration("soul_siphon_dot", 9000, player.id)
		--player:swingTarget(mobTarget)
	elseif (pcTarget ~= nil) then
		if (player:canPK(pcTarget)) then
	player:setAether("soul_siphon", aether)
	player:sendAction(1, 20)
	player:sendMinitext("You are slowly siphoning vitality.")
	player:playSound(13)
			pcTarget.attacker = player.id
			--player:swingTarget(pcTarget)
			--pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
			--pcTarget.health = pcTarget.health - damage
			--pcTarget:sendStatus()
		--test HERE
		--pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
		--pcTarget:removeHealth(damage)
		pcTarget:sendStatus()
		--player:addHealth2(caster.maxMagic/25)
		--pcTarget:sendHealth(0, 0)
			--pcTarget:showHealth(0, 200000)
			--
			pcTarget:setDuration("soul_siphon_dot", 9000, player.id)
			pcTarget:sendAnimation(293, 0)
			--player:sendAnimation(310, 0)
			--player:addHealth((player.maxHealth / 2) / 10)
			player:setDuration("soul_siphon_hot", 9000)
			player.registry["siphon_target"] = pcTarget.id
			player.magic = player.magic - magicCost
			player:sendStatus()
			pcTarget:sendMinitext(player.name.." is siphoning your soul.")
			--pcTarget.registry["siphon_owner"]
		end
	end
end,


requirements = function(player)
	local level = 40
	local items = {}
	local itemAmounts = {}
	local description = {"Soul siphon is an ability that steals the health of your target to restore your own."}
	return level, items, itemAmounts, description
end
}

soul_siphon_hot = {
while_cast = function(player)

		if(player.state==1 or player.health==0) then
			player:setDuration("soul_siphon_hot", 0)
			return
		end
	if (player.registry["siphon_target"] ~= 0) then
		if(Player(player.registry["siphon_target"]).state==1 or Player(player.registry["siphon_target"]).health==0 or Player(player.registry["siphon_target"]) == nil) then
			player:setDuration("soul_siphon_hot", 0)
			player.registry["siphon_target"] = 0
			return
		end
	end
	if (player.registry["siphon_target_mob"] ~= 0) then
		if(Mob(player.registry["siphon_target_mob"]).health==0 or Mob(player.registry["siphon_target_mob"]) == nil) then
			player:setDuration("soul_siphon_hot", 0)
			player.registry["siphon_target_mob"] = 0
			return
		end
	end

		player:sendAnimation(310, 0)
		player:addHealth((player.maxHealth / 2) / 10)
end,

uncast = function(player)
	player.registry["siphon_target"] = 0
	player.registry["siphon_target_mob"] = 0
end
}

soul_siphon_dot = {
while_cast = function(block, caster)
	if (caster == nil) then
		return
	end

	local magicCost = (.33 * caster.magic)
	local damage = (caster.level * 6) + (caster.grace * 6) 
	--local caster = block:getCasterID()
	local threat
	local repeattimer = 2

	--block:talk(0,"Test ID:"..what.."")
	if (block.m ~= caster.m) then
		block:setDuration("soul_siphon_dot", 0, caster.id)
	end

	if(caster.state==1 or caster.health==0) then
		block:setDuration("soul_siphon_dot", 0, caster.id)
		return
	end

	block.attacker = caster.id
	
	if (block.blType == BL_MOB) then
		threat = block:removeHealthExtend(damage, 1, 1, 1, 1, 2)
		caster:addThreat(block.id, threat)
		
		if (#caster.group > 1) then
			block:setGrpDmg(caster.id, threat)
		else
			block:setIndDmg(caster.id, threat)
		end
	end
	--block:sendMinitext("is this good.")
	block:removeHealthExtend(damage, 1, 1, 1, 1, 0)
	block:sendAnimation(293, 0)
end
}