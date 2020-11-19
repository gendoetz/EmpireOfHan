fear = {
cast = function(player, target)
	--local mobBlocks = player:getObjectsInSameMap(BL_MOB)
		local aether = 25000
		local magicCost = (.01 * player.maxMagic)

		if(player.state==1) then
			player:sendMinitext("Spirits can't do that.")
			return
		end

		if(target.state==1) then
			player:sendMinitext("This wouldn't be of very much help right now.")
			return
		end

		if(target:hasDuration("fear")) then
			player:sendMinitext("Fear is already in effect.")
			return
		end

		if (target.blType==BL_PC) then
			if not(player:canPK(target)) then
				player:sendMinitext("You cannot cast that now.")
				return
			end
		end

		if (target.blType == BL_MOB and target.protection == 1) then
			player:sendMinitext("You can't use this on that target.")
			return
		end

		if(target.blType==BL_PC and player:canPK(target)) then
			target:sendAnimation(111)
			player:playSound(68)
			target:setDuration("fear", 5000)
			player:sendMinitext("You cast Fear.")
			player:sendAction(6,35)   
			player:setAether("fear", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target.drunk = 255
			target.confused = true
			target:sendStatus()
			target:updateState()
			target:sendMinitext("You tremble in fear!")
		elseif (target.blType==BL_MOB) then
			if (target.aiType ~= 0) then
				player:sendMinitext("This enemy does not fear you!")
				return
			end
			target:sendAnimation(111)
			player:playSound(68)

			player:setAether("fear", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			target:setDuration("fear", 20000)
			player:setThreat(target.ID, 0)
			target.attacker = nil
			target.target = nil
			player:sendMinitext("You cast Fear.")
            player:sendAction(6,35)   
		end
end,

while_cast = function(block, caster)
		block:sendAnimation(318)
		if(block.blType==BL_MOB) then
			--caster:setThreat(block.ID, 0)
			mob_ai_basic.fear(block, target)
		end
end,

uncast = function(block)
	if(block.blType==BL_PC) then
		block:sendMinitext("Your balance has returned.")
		block.drunk = 0
		block.confused = false
		block:sendStatus()
		block:updateState()
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Fear causes your enemies to tremble and prevents full on attack."}
	return level, items, itemAmounts, description
end
}