pc_timer = {

tick = function(player)
	--player:talk(0,"interval "..player.timerInterval)
	if (player.timerTick%2 ~= 0) then--0.5,1.5,2.5 seconds
		--player:sendMinitext("Tick")
		player:expireItem()
	end
	
	if (player.timerTick%2 == 0) then--1 second
		pc_timer.second(player)
	end

	if (player.timerTick%120 == 0) then--60 seconds
		pc_timer.minute(player)
	end
	
	if (player.timerTick%7200 == 0) then--1 hour
		pc_timer.hour(player)
	end
	
	if (player.registry["opening_warp"] > 0 and player.registry["opening_warp"] < os.time()) then
		player.registry["opening_warp"] = 0
		player:warp(0, 8, 7)
	end
	
	if (player.registry["dps_potion"] <= os.time() and player.registry["dps_potion"] > 0) then
		player:msg(0, "You dealt "..player.dmgDealt.." damage in "..(player.registry["dps_potion_len"] / 60).." minute(s).", player.ID)
		player:msg(0, "Damage Per Second: "..(player.dmgDealt / player.registry["dps_potion_len"]), player.ID)
		player.registry["dps_potion"] = 0
		player.dmgDealt = 0
	end
		
end,

advice = function(player)
	if (player.timerTick % 600 == 0) then--60 seconds
		player:msg(11, advice[math.random(#advice)], player.ID)
	end
end,

second = function(player)
	local seconds = math.floor(player.timerTick/2)
	local time = curTime() --gets current time
	
	if (seconds % 2 == 0) then
		--pc_timer.second2(player)
	end

	--player:sendMinitext("Has Cocontainer: "..player.coRef)

	--Chung Ryong
	if((time > 3 and time < 10) and player.totem == 3) then
		if (player.totemTime == 0) then
			player:sendMinitext("Dawn breaks and you gain favor with Chung Ryong.")
			player:sendAnimation(16, 0)
			player:sendAnimation(425, 0)
			--player:playSound(64)
			player.totemTime = 1
		end
	end
	if((time < 3 or time > 10) and player.totem == 3) then
		if (player.totemTime == 1) then
			player:sendMinitext("The sun begins to blaze in the sky, your favor with Chung Ryong fades.")
			player.totemTime = 0
		end
	end
	--Jujak
	if((time > 9 and time < 16) and player.totem == 0) then
		if (player.totemTime == 0) then
			player:sendMinitext("The sun begins to climb in the sky, you gain favor with Ju Jak.")
			player:sendAnimation(16, 0)
			player:sendAnimation(425, 0)
			--player:playSound(64)
			player.totemTime = 1
		end
	end
	if((time < 9 or time > 16) and player.totem == 0) then
		if (player.totemTime == 1) then
			player:sendMinitext("Dusk approaches, Ju Jak's magic begins to wane.")
			player.totemTime = 0
		end
	end
	--Baekho
	if((time > 15 and time < 22) and player.totem == 1) then
		if (player.totemTime == 0) then
			player:sendMinitext("Dusk begins to fall you gain favor with Baekho.")
			player:sendAnimation(16, 0)
			player:sendAnimation(425, 0)
			--player:playSound(64)
			player.totemTime = 1
		end
	end
	if((time < 15 or time > 22) and player.totem == 1) then
		if (player.totemTime == 1) then
			player:sendMinitext("The darkest hours approach, Baekho's power fades.")
			player.totemTime = 0
		end
	end
	--Hyun moo
	if((time > 21 and time < 4) and player.totem == 2) then
		if (player.totemTime == 0) then
			player:sendMinitext("The midnight hours approach, you gain favor with Hyun Moo.")
			player:sendAnimation(16, 0)
			player:sendAnimation(425, 0)
			--player:playSound(64)
			player.totemTime = 1
		end
	end
	if((time < 21 or time > 4) and player.totem == 2) then
		if (player.totemTime == 1) then
			player:sendMinitext("The sun crests at the horizon, your favor with Hyun Moo wanes.")
			player.totemTime = 0
		end
	end


	--player.registry["totem_timeOn"]
	
	--[[if (seconds%15==0) then
		if (player.state == 1) and (player.health == 0)then
			player.state = 0
			player:addHealth(player.maxHealth)
			player:updateState()
			player:sendMinitext("You have been revived by Genesis for testing during Alpha period.")
		end
	end]]--
end,


second2 = function(player)
	local last_level = player.registry["last_level"]
	local about_path = player.registry["about_path"]

	
	if (about_path >= 10) and (player.level < 10) then
		if (os.time() >= last_level + 60) then
			player.registry["about_path"] = about_path + 1
			f1npc.about_path(player, about_path, about_path % 10)
		end

		if (about_path % 10 == 3) then
			player.registry["about_path"] = 1
		end
	end

end,


minute = function(player)
	local minutes = math.floor(player.timerTick/120)
	local spells = player:getSpells()
	
	if (minutes%2==0) then
		
	end
	
	--if (player.level >= 2 and #spells <= 1) then
	--	player:msg(4, player.f1Name..' (Spirit of Genesis)" You can learn some spells from a nearby path trainer.', player.ID)
	--end
		
	if ((minutes < 60) and (minutes%15 == 0)) then
		--player:msg(4,"You have been playing for "..minutes.." minutes.",player.ID)
	end
	--DONT PRINT ON HOUR
end,

hour = function(player)
	local hours = math.floor(player.timerTick/7200)
	
	if (hours%6==0) then
		--player:msg(4,"You have been playing for "..hours.." hour(s). Perhaps you should take a break and come back later.",player.ID)
	else
		--player:msg(4,"You have been playing for "..hours.." hour(s).",player.ID)
	end
end,

display_timer = function(player)
--Executes when a display timer finishes.
	--player:talk(2, "Beep beep, beep beep...")
	if (player.registry["botCheck"] == 1) then
		player.registry["botCheck"] = 0
		player.registry["botFlag"] = player.registry["botFlag"] + 1
		if (player.registry["botFlag"] > 5) then
			player:gmMsg(""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			addChatLog(player, ""..player.name.." should be jailed with "..player.registry["botFlag"].." failed bot checks.")
			--player:gmMsg(""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			--addChatLog(player, ""..player.name.." has been jailed with "..player.registry["botFlag"].." failed bot checks.")
			--player.registry["botFlag"] = 0
			--justice.jail(player, player)
		else
			player:gmMsg(""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
			addChatLog(player, ""..player.name.." failed bot check within time. ("..player.registry["botFlag"]..")")
		end
	end
end

}