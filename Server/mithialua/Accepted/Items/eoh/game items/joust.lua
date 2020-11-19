contest_javalin = {
use = function(player)
	if (player.m == 162) then

		local aethers = 2
		local objup = getObject(player.m, player.x, player.y)
		local objdown = getObject(player.m, player.x, player.y - 1)

		local pcBlocks

		if (player.state ~= 3) then
			player:sendMinitext("You must be mounted to use a javalin.")
			return
		end

		
		if (os.time() >= player.registry["joust_aethers"] + aethers) then
			if (objup == 15939) then
				pcBlocks = player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)
				if (#pcBlocks > 0) then
					if (pcBlocks[1].state == 3) then --Check that we are on mount
						local damage = (pcBlocks[1].maxHealth * .35)
						pcBlocks[1]:sendAnimation(424, 1)
						pcBlocks[1]:playSound(710)
						pcBlocks[1]:removeHealthWithoutDamageNumbers(damage)
						pcBlocks[1]:sendHealth(0, 0)
						broadcast(player.m, pcBlocks[1].name.." has been hit by "..player.name..".")
					end
				end
			end

			if (objdown == 15939) then
				pcBlocks = player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)
				if (#pcBlocks > 0) then
					if (pcBlocks[1].state == 3) then --Check that we are on mount
						local damage = (pcBlocks[1].maxHealth * .35)
						pcBlocks[1]:sendAnimation(424, 1)
						pcBlocks[1]:playSound(710)
						pcBlocks[1]:removeHealthWithoutDamageNumbers(damage)
						pcBlocks[1]:sendHealth(0, 0)
						broadcast(player.m, pcBlocks[1].name.." has been hit by "..player.name..".")
					end
				end
			end
			player.registry["joust_aethers"] = os.time()
			player:setTimer(2, 2)
		else
			player:sendMinitext("You must wait to use this again.")
		end
	else
		player:removeItem("contest_javalin", 1)
	end
end
}

jousting_npc = {
click = async(function(player, npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local sells = {"contest_javalin"}
	local options = {"Jousting Gear", "About Jousting", "Mount Horse"}

	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:updateState()
		player:sendStatus()
		return
	end

	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	choice = player:menuString("How can I help you?", options)
	if (choice == "Jousting Gear") then
		player:buyExtend("What do you need?", sells)
	elseif (choice == "Mount Horse") then
		if (player.state == 0) then
			player.registry["mount_type"] = 1
			player.disguise = 192
			player.state = 3
			player.speed = 45
			player:updateState()
			player:sendStatus()
		end
	elseif (choice == "About Jousting") then
		player:dialogSeq({npcGraphics, "Jousting is a contest of strength, speed, and accuracy. To joust you need a javalin. With a javalin in hand, say (horse) or (mount) to me and I will fetch you a steed.",
			"Stand opposite your opponent along the wall, and prepare to charge. Use the javalin to strike a blow to your opponent, but strike carefully; you will need to take a moment to recover for another strike."},1)
	end
end),

say = function(player, npc)
	local speech = string.lower(player.speech)
	
	if ((string.find(speech, "(.*)mount(.*)")) and player:hasItem("contest_javalin", 1) == true) then
		--broadcast(npc.m, "The match has been paused.")
		--player.pvp = 0
		if (player.state == 0) then
			player.registry["mount_type"] = 1
			player.disguise = 192
			player.state = 3
			player.speed = 45
			player:updateState()
			player:sendStatus()
		end
	elseif ((string.find(speech, "(.*)horse(.*)")) and player:hasItem("contest_javalin", 1) == true) then
		if (player.state == 0) then
			player.registry["mount_type"] = 1
			player.disguise = 192
			player.state = 3
			player.speed = 45
			player:updateState()
			player:sendStatus()
		end
	elseif ((string.find(speech, "(.*)res(.*)")) and player:hasItem("contest_javalin", 1) == true) then
		if (player.state == 1) then
			player.state = 0
			player.health = player.maxHealth
			player.magic = player.maxMagic
			player:updateState()
			player:sendStatus()
			return
		end
	elseif ((string.find(speech, "(.*)heal(.*)")) and player:hasItem("contest_javalin", 1) == true) then
		if (player.state == 0) then
			player.health = player.maxHealth
			player.magic = player.maxMagic
			player:updateState()
			player:sendStatus()
			return
		end
	end
end,
}
