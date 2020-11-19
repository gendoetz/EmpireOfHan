ice_king = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

after_death = function(mob, attacker, block)
	local warpnpc = NPC(147)
	warpnpc:warp(5000, 14, 3)
	mob:sendAnimationXY(99,mob.x,mob.y,1)
end,

on_spawn = function(mob)
	mob.registry["ice_wave_y"] = 3
	mob.registry["attack_choice"] = math.random(1, 2)
	mob.side = 2
	mob:sendSide()
	local warpnpc = NPC(147)
	warpnpc:warp(mob.m, mob.x, mob.y)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
		--moved = ice_king.zap(mob, target)
		--moved = ice_king.avalanche_cast(mob, target)
		--mob:talk(2,"Move")
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then
				target = block
				--mob:attack(target.ID)
				mob.state = MOB_HIT
				--mob:talk(2,"Target Acquired")
			end
			
end,

attack = function(mob, target)
	
	--Timer for room ice wave
	local roomiceTimer = 30
	local roomhailTimer = 40
	mob.newAttack = math.random(1500, 3500)

	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end
			if (mob.registry["attack_choice"] == 1) then
				if (os.time() >= mob.registry["roomiceTimer"] + roomiceTimer) then
					mob:talk(2,"**The Ice King starts to summon a wall of ice**")
					broadcast(mob.m, "The Ice King starts to summon a wall of ice!")
					mob:addNPC("ice_waveNPC", mob.m, mob.x, mob.y, 700, 20000, mob.ID)
					mob.registry["roomiceTimer"] = os.time()
					mob.registry["roomhailTimer"] = os.time()
					mob.registry["attack_choice"] = math.random(1, 2)
				end
			else
				if (os.time() >= mob.registry["roomhailTimer"] + roomhailTimer) then
					mob:talk(2,"**The Ice King starts to gather magical energy**")
					broadcast(mob.m, "The Ice King has started to gather magical energy!")

					mob:addNPC("repHailAttack", mob.m, mob.x, mob.y, 700, 20000, mob.ID)
					local randx
					local randy
					local spellCheck
					for i = 1, 6 do
						randx = math.random(9, 19)
						randy = math.random(9, 15)
						spellCheck = mob:getObjectsInCell(mob.m, randx, randy, BL_NPC)
						if (#spellCheck == 0) then
							mob:addNPC("hail_attackNPC", mob.m, randx, randy, 200, 20000)
						end
					end
					mob.registry["roomhailTimer"] = os.time()
					mob.registry["roomiceTimer"] = os.time()
					mob.registry["attack_choice"] = math.random(1, 2)
				end
			end
		--mob:talk(2,"ID "..target.ID)
		if(mob:moveIntent(target.ID) == 1) then
			--We are right next to them, so attack!
			mob:sendAnimation(3, 0)
			mob:playSound(708)
			mob:flank()
			mob:attack(target.ID)
			mob:sendAnimationXY(169, mob.x-1, mob.y, 1)
			mob:sendAnimationXY(169, mob.x+1, mob.y, 1)
			mob:sendAnimationXY(169, mob.x, mob.y+1, 1)

		else
			--mob.state = MOB_ALIVE
			local attack_roomtargets = mob:getObjectsInArea(BL_PC)
			if (#attack_roomtargets > 0) then
				mob:playSound(39)
				mob:playSound(708)
				mob:sendAnimation(3, 0)
				for i = 1, #attack_roomtargets do
					if (attack_roomtargets[i].state ~= 1) then
						attack_roomtargets[i].attacker = attack_roomtargets[i].ID
						attack_roomtargets[i]:removeHealthExtend(mob.damage, 1, 1, 1, 1, 0)
						mob:sendAnimationXY(169, attack_roomtargets[i].x, attack_roomtargets[i].y, 1)
					end
				end
			end
		end
	else
		--mob.state = MOB_ALIVE
	end
	--mob:talk(2,"Test")
end,
}

ice_waveNPC = {
action = function(npc)
	local waveTarget
	local soundtarget
	local damage = 15000
	npc.registry["ice_wave_y"] = npc.registry["ice_wave_y"] + 1

	if (npc.registry["ice_wave_y"] >= 3 and npc.registry["ice_wave_y"] <= 20) then
		soundtarget = npc:getObjectsInCell(npc.m, npc.x, npc.y, BL_MOB)
		if (#soundtarget > 0) then
			soundtarget[1]:playSound(46)
		end
		for x = 1, 27 do
			if (((x == 7 or x == 21) and npc.registry["ice_wave_y"] >= 10) or (x == 14 and npc.registry["ice_wave_y"] == 6)) then
			--mob:sendAnimationXY(1, x, mob.registry["ice_wave_y"], 1)
			else
			waveTarget = npc:getObjectsInCell(npc.m, x, npc.registry["ice_wave_y"], BL_PC)
			if (#waveTarget ~= 0) then
				for i = 1, #waveTarget do
					if (waveTarget[i].state ~= 1) then
						waveTarget[i].attacker = waveTarget[i].ID
						damage = damage + waveTarget[i].maxHealth / 2
						waveTarget[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						waveTarget[i]:playSound(712)
					end
				end
			end
			npc:sendAnimationXY(392, x, npc.registry["ice_wave_y"], 1)
			end
		end
	end
end,

endAction = function(npc)
	npc:delete()
end,
}

hail_attackNPC = {
action = function(npc)
	npc:sendAnimationXY(358, npc.x, npc.y, 1)		
end,

endAction = function(npc)
	npc:delete()
end,
}

repHailAttack = {
action = function(npc)
local checkplayer
local checknpc
local damage = 250
npc.registry["hail_attacktimer"] = npc.registry["hail_attacktimer"] + 1
			
	if (npc.registry["hail_attacktimer"] >= 3) then
		damage = damage * npc.registry["hail_attacktimer"] 
		for x = 1, 27 do
			for y = 3, 22 do
				checkplayer = npc:getObjectsInCell(npc.m, x, y, BL_PC)
				checknpc = npc:getObjectsInCell(npc.m, x, y, BL_NPC)
				if(#checkplayer > 0) then
					if (#checknpc > 0) then
						if (checknpc[1].yname ~= "hail_attackNPC") then
						--do damage
							if (checkplayer[1].state ~= 1) then
								checkplayer[1].attacker = checkplayer[1].ID
								checkplayer[1]:sendAnimation(392)
								checkplayer[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
								checkplayer[1]:playSound(712)
							end
						end
					else
						--do Damage
							if (checkplayer[1].state ~= 1) then
								checkplayer[1].attacker = checkplayer[1].ID
								checkplayer[1]:sendAnimation(392)
								checkplayer[1]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
								checkplayer[1]:playSound(712)
							end
					end
				end
			end 
		end
	end
end,

endAction = function(npc)
	npc:delete()
end,
}

some_spell = {
cast = function(player, target)
	local aether = 2000
	local duration = 8000
	local damage = 500--player.level + (player.will*2)
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (target:hasDurationID("avalanche", player.id)) then
		player:sendMinitext("That spell is already cast.")
		return
	end
	
	if (target.blType == BL_MOB) then
		player:sendAction(6, 20)
		player:setAether("avalanche", aether)
		player:sendStatus()
		player:playSound(370)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			target:setDuration("avalanche", duration, player.id)
		--end
		
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player:setAether("avalanche", aether)
		player:playSound(735)
	
		--if (checkProtection(player, target, 1)) then
		--	player:sendMinitext("Singe has been deflected.")
		--else
			target:sendAnimation(46, 1)
			target:setDuration("avalanche", duration, player.id)
		--end
	end
end,

while_cast = function(block, caster)
	block.registry["counter_avalanche"] = block.registry["counter_avalanche"] + 1
	block:sendAnimation(359, 0)

	if (block.registry["counter_avalanche"] == 7) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 1)

		block:sendAnimationXY(25, block.x, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 1, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end

	end

	if (block.registry["counter_avalanche"] == 8) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 2)

		block:sendAnimationXY(25, block.x, block.y - 2, 1)
		block:sendAnimationXY(25, block.x + 2, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 2, block.y, 1)

		block:sendAnimationXY(25, block.x + 1, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 1, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 1, block.y - 1, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end

	end

	if (block.registry["counter_avalanche"] == 9) then
		local damage = 5000
		local block_dam = 5000
		local targets = {}

		block:playSound(48)
		block:sendAnimation(187, 0)
		block:removeHealthExtend(block_dam, 1, 1, 1, 1, 0)
		targets = getTargetsAroundPhase(block, BL_PC, 3)

		block:sendAnimationXY(25, block.x, block.y - 3, 1)
		block:sendAnimationXY(25, block.x + 3, block.y, 1)
		block:sendAnimationXY(25, block.x, block.y + 3, 1)
		block:sendAnimationXY(25, block.x - 3, block.y, 1)

		block:sendAnimationXY(25, block.x + 1, block.y - 2, 1)
		block:sendAnimationXY(25, block.x + 1, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 1, block.y + 2, 1)
		block:sendAnimationXY(25, block.x - 1, block.y - 2, 1)

		block:sendAnimationXY(25, block.x + 2, block.y - 1, 1)
		block:sendAnimationXY(25, block.x + 2, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 2, block.y + 1, 1)
		block:sendAnimationXY(25, block.x - 2, block.y - 1, 1)

		if (#targets > 0) then

			for i = 1, #targets do
				if (targets[i].blType == BL_PC) then
					targets[i].attacker = block.ID		
					targets[i]:removeHealthExtend(damage, 1, 1, 1, 1, 0)
					targets[i]:sendAnimation(187, 0)
				end
			end
		end
		block:setDuration("avalanche", 0)

	end
end,

uncast = function(player)
	--player:sendAnimation(133, 0)
	--player:sendMinitext("Your mana stops regenerating.")
end,
}