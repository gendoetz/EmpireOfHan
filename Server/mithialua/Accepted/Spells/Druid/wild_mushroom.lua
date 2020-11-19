wild_mushroom = {
cast = function(player, target)
	--local aether = 60000
	local duration = 20000
	local aether = 300000
	local magicCost = 250
	local distance = 7
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.class ~= 12) then
		player:sendMinitext("Your path is not capable of this magic.")
		player:removeSpell("wild_mushroom")
		player.registry["learned_wild_mushroom"] = 0
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
	
	if (target.blType == BL_MOB and target.mobID == 100) then
		player:sendMinitext("Your target is not eligible for that skill.")
		return
	end
	
	if (distanceSquare(player, target, distance)) then
		local objCheckright = getObject(target.m, target.x+1, target.y)
		local passCheckright = getPass(target.m, target.x+1, target.y)
		local objCheckleft = getObject(target.m, target.x-1, target.y)
		local passCheckleft = getPass(target.m, target.x-1, target.y)
		local wildm_locr = 3

		if (target.blType == BL_PC and target.state ~= 1) then
			if (objCheckright == 0 and objCheckleft == 0 and passCheckright == 0 and passCheckleft == 0) then
				wildm_locr = math.random(1, 2)
			end

				--if (objCheckright == 0 and passCheckright == 0) then
					if (wildm_locr == 1) then
					player.registry["mushroommap"] = target.m
					player.registry["mushroomx"] = target.x+1
					player.registry["mushroomy"] = target.y
					elseif (wildm_locr == 2) then
					player.registry["mushroommap"] = target.m
					player.registry["mushroomx"] = target.x-1
					player.registry["mushroomy"] = target.y
					elseif (wildm_locr == 3) then
						if (objCheckright == 0 and passCheckright == 0) then
							player.registry["mushroommap"] = target.m
							player.registry["mushroomx"] = target.x+1
							player.registry["mushroomy"] = target.y
						elseif (objCheckleft == 0 and passCheckleft == 0) then
							player.registry["mushroommap"] = target.m
							player.registry["mushroomx"] = target.x-1
							player.registry["mushroomy"] = target.y
						else
							return
						end
					end
					player:sendAnimationXY(108, player.registry["mushroomx"], player.registry["mushroomy"], 1)
					setObject(target.m, player.registry["mushroomx"], player.registry["mushroomy"], 14336)
					player:playSound(3)
					player:setDuration("wild_mushroom", duration, 0, 1)
					player:setAether("wild_mushroom", aether)
					player.registry["mushroomactive"] = 1
					player:sendAction(6, 20)
				--end
			--[[player:sendAction(6, 20)
			player:sendAnimationXY(279, player.x, player.y, 1)
			player:setAether("teleport", aether)
			player.magic = player.magic - magicCost
			player:sendStatus()
			player:sendMinitext("You cast Teleport.")
			canAmbush(player, target)
			player:playSound(84)
			player:sendAnimation(279)
			player.side = 2
			player:sendSide()--]]
		else
			return
		end
	end
end,

uncast = function(block)
	block:calcStat()
	setObject(block.registry["mushroommap"], block.registry["mushroomx"], block.registry["mushroomy"], 0)
	player.registry["mushroomactive"] = 0
end,

while_cast = function(block)
local inrangetargets = {}
local inrangetargets_u100 = {}
local inrangetargets_u75 = {}
local inrangetargets_u50 = {}
local inrangetargetsnsu = {}
local distance = 2
local heal = block.maxMagic / 60
local mushroomtargets = block:getObjectsInSameMap(BL_PC)

	if (block.m == block.registry["mushroommap"]) then
		block:sendAnimationXY(349, block.registry["mushroomx"], block.registry["mushroomy"], 1)
	end

	if (#mushroomtargets > 0) then
		for i = 1, #mushroomtargets do
				 --and distance(mob, mobBlocks[i]) <= 10
				 --Script to target only three players with health that is lower than 100%
				 --Below this, DO NOT HEAL DEADS
				if (mushroomtargets[i].state ~= 1) then
					if (distanceSquareXY(mushroomtargets[i], block.registry["mushroomx"], block.registry["mushroomy"], distance)) then
						table.insert(inrangetargets,mushroomtargets[i])
					end
				end
		end
				for i = 1, #inrangetargets do
					--and (inrangetargets[i].health <= inrangetargets[i].maxHealth*.75)
					if (inrangetargets[i].health <= inrangetargets[i].maxHealth*.50) then
						table.insert(inrangetargets_u50,inrangetargets[i])
					elseif (inrangetargets[i].health <= inrangetargets[i].maxHealth*.75) then
						table.insert(inrangetargets_u75,inrangetargets[i])
					elseif (inrangetargets[i].health ~= inrangetargets[i].maxHealth) then
						table.insert(inrangetargets_u100,inrangetargets[i])
					else
						table.insert(inrangetargetsnsu,inrangetargets[i])
					end
				end
				for i = 1, #inrangetargets_u75 do
				table.insert(inrangetargets_u50,inrangetargets_u75[i])
				end
				for i = 1, #inrangetargets_u100 do
				table.insert(inrangetargets_u50,inrangetargets_u100[i])
				end
				for i = 1, #inrangetargetsnsu do
				table.insert(inrangetargets_u50,inrangetargetsnsu[i])
				end

					for i = 1, 3 do
						if (inrangetargets_u50[i].state ~= 1) then
							inrangetargets_u50[i]:sendAnimation(280)
							--mob:playSound(708)
							--mushroomtargets[i]:addHealthExtend(heal, 0, 0, 0, 0, 0)
							inrangetargets_u50[i]:addHealth2(heal)
							inrangetargets_u50[i]:sendHealth(0, 0)
						end
					end
	else
		return
	end
end,

requirements = function(player)
	local level = 75
	local items = {}
	local itemAmounts = {}
	local description = {"Wild Mushroom sprouts a magical mushroom that will heal any wounded allies in the area."}
	return level, items, itemAmounts, description
end
}