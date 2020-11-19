stun_quake = {
cast = function(player)
	local aether = 50000
	local duration = 7000
	local magicCost = 250
	local targets = {}

	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:hasDuration("stun_quake")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	local targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)
	local targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)
	local targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)
	local targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)

	if (#targetsLeft == 0) then
		targetsLeft = player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)
		
		if (#targetsLeft > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsLeft[i])) then
					table.remove(targetsLeft, i)
					i = i - 1
				end
			until (i == #targetsLeft)
		end
	end
	
	if (#targetsRight == 0) then
		targetsRight = player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)
		
		if (#targetsRight > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsRight[i])) then
					table.remove(targetsRight, i)
					i = i - 1
				end
			until (i == #targetsRight)
		end
	end
	
	if (#targetsUp == 0) then
		targetsUp = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
		
		if (#targetsUp > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsUp[i])) then
					table.remove(targetsUp, i)
					i = i - 1
				end
			until (i == #targetsUp)
		end
	end
	
	if (#targetsDown == 0) then
		targetsDown = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
		
		if (#targetsDown > 0) then
			i = 0
			
			repeat
				i = i + 1
				
				if (not player:canPK(targetsDown[i])) then
					table.remove(targetsDown, i)
					i = i - 1
				end
			until (i == #targetsDown)
		end
	end
	
	if (#targetsLeft > 0) then
		table.insert(targets, targetsLeft[1])
	end
	
	if (#targetsRight > 0) then
		table.insert(targets, targetsRight[1])
	end
	
	if (#targetsUp > 0) then
		table.insert(targets, targetsUp[1])
	end
	
	if (#targetsDown > 0) then
		table.insert(targets, targetsDown[1])
	end

	local targetsFinal = {}

	if (#targets ~= 0) then
		for i = 1, #targets do
				if(targets[i].blType == BL_MOB and targets[i].protection ~= 1) then
					table.insert(targetsFinal, targets[i])
				end
		end
	end

	if (#targetsFinal == 0) then
		player:sendMinitext("There is not one to use this on.")
		return
	end

	if (#targetsFinal > 0) then
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(735)
		
		for i = 1, #targetsFinal do
			targetsFinal[i]:sendAnimation(62, 1)
			if (targetsFinal[i].blType == BL_PC) then
				local duration = 3000
					if (targetsFinal[i].paralyzed == false) then
						targetsFinal[i].paralyzed = true
						targetsFinal[i]:setDuration("stun_quake", duration, player.id, 1)
					end
					if (#targetsLeft > 0) then
						targetsLeft[1].side=3
						targetsLeft[1]:sendSide()
					end
					if (#targetsRight > 0) then
						targetsRight[1].side=1
						targetsRight[1]:sendSide()
					end
					if (#targetsUp > 0) then
						targetsUp[1].side=0
						targetsUp[1]:sendSide()
					end
					if (#targetsDown > 0) then
						targetsDown[1].side=2
						targetsDown[1]:sendSide()
					end
			end
			if (targetsFinal[i].blType == BL_MOB) then
				local duration = 10000
				if (targetsFinal[i].paralyzed == false) then
					targetsFinal[i].paralyzed = true
					targetsFinal[i]:setDuration("stun_quake", duration, player.id, 1)
				end
					if (#targetsLeft > 0) then
						targetsLeft[1].side=3
						targetsLeft[1]:sendSide()
					end
					if (#targetsRight > 0) then
						targetsRight[1].side=1
						targetsRight[1]:sendSide()
					end
					if (#targetsUp > 0) then
						targetsUp[1].side=0
						targetsUp[1]:sendSide()
					end
					if (#targetsDown > 0) then
						targetsDown[1].side=2
						targetsDown[1]:sendSide()
					end

			end
		end
	end

	
	player:sendAction(6, 20)
	player:playSound(503)
	player:setAether("stun_quake", aether)
	player:sendStatus()
	player:sendMinitext("You use Stun Quake.")
end,

--recast = function(block)
--	block.paralyzed = true
--end,

uncast = function(block)
	block.paralyzed = false
end,

requirements = function(player)
	local level = 70
	local items = {}
	local itemAmounts = {}
	local description = {"Stun Quake causes your enemies to become paralyzed and turn direction."}
	return level, items, itemAmounts, description
end
}