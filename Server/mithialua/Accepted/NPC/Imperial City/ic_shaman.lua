ic_shaman = {
click = async(function(player,npc)
	local npcG = {graphic = convertGraphic(83, "monster"), color = 0}
	local rott = {graphic = convertGraphic(772, "monster"), color = 4}
	local opts = {"Please resurrect me?", "Nothing, powerful one."}
	local options = {}
	local menu

	player.npcGraphic = npcG.graphic
	player.npcColor = npcG.color
	player.dialogType = 0
	player.lastClick = npc.ID
	

	if (player.state ~= 1) then
		options = {"Return", "Sell"}

		if (player.m == 20 or player.m == 22) then
			table.insert(options,"A rip in the spirit planes...")
		end

		menu = player:menuString("You are wasting my time...", options)
		if (menu == "Return") then--Bind
			if (player.registry["bindMap"] > 0) then
				local menuOption = player:menuString("Would you like to return to your bind point?", {"Yes", "No"})
				
				if (menuOption == "Yes") then
					npc:talk(0, "Shaman: We shall meet again, "..player.name..".")
					player:warp(player.registry["bindMap"], player.registry["bindX"], player.registry["bindY"])
				end
			else
				player:dialogSeq({npcG, "You dare disturb the wicked? You have no bind point..."})
			end
		elseif (menu == "Sell") then
		player:sellExtend("What do you wish to sell?", {65, 66, 432, 433})
		elseif (menu == "A rip in the spirit planes...") then
			if (player.quest["spirit_rip"] == 0) then
				player:dialogSeq({npcG, "The spirits foretold of your arrival. **You peer eyes wide at the Shaman**",
				npcG, "Do not try my patience for judgemental glares, I am half of the physical plane and half of the spirital, I could snap your spine instantly.",
				npcG, "It is fortunate you are here, but fortune has little to do with it. Assist me and I will reward you.",
				npcG, "Lately the spirits have been whispering about a growing power in the restful undead to the west.",
				rott, "The Seong Lowlands specifically. There grows a weed called rottwither near the eerie passage to the dark valley, this plant is known to feed off of increased spirital unrest. Bring me 10!"}, 1)
				player.quest["spirit_rip"] = 1
			elseif (player.quest["spirit_rip"] == 1) then
				if (player:hasItem("rottwither", 10) == true) then
					player:dialogSeq({npcG, "You took long enough.. on your head be it when the realm crumbles to the spirit world..."}, 1)
					player:removeItem("rottwither", 10)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player:addGold(1800)
						player:giveXP(30000)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 1800\nExp: 30000\nImperial Standing: +1", player.ID)
						player.quest["spirit_rip"] = 2
				else
					player:dialogSeq({rott, "Travel to the Seong Lowlands and bring me that rottwither, just 10 will do!"}, 1)
				end
			elseif (player.quest["spirit_rip"] == 2) then
				player:dialogSeq({npcG, "*Chants something in a eerie raspy voice*"}, 1)
			end

		end
	else	
		local menuOption = player:menuString("I sense the presence of a spirit... What do you need?", opts)
		if (menuOption == "Please resurrect me?") then
			player.state = 0
			player.attacker = player.ID
			player:addHealthExtend(player.maxHealth, 0, 0, 0, 0, 0)
			player.magic = player.maxMagic
			player:updateState()
			player:addHealthExtend(1, 0, 0, 0, 0, 0)
			player:sendAnimation(96)
			player:playSound(112)
			player.registry["lastrez"] = os.time()
			npc:talk(0, "Shaman: Darkness will consume you again, "..player.name..", it is inevitable.")
		else
			player:dialogSeq({npcG, "Suit yourself.", 
			"You need time to accept your fate."}, 1)
		end
	end
end),

say = function(player, npc)
	local speech = string.lower(player.speech)
	
	if ((string.find(speech, "(.*)res(.*)") or string.find(speech, "(.*)rez(.*)")) and player.state == 1) then
		player.state = 0
		player.attacker = player.ID
		player:addHealthExtend(player.maxHealth, 0, 0, 0, 0, 0)
		player.magic = player.maxMagic
		player:updateState()
		player:addHealthExtend(1, 0, 0, 0, 0, 0)
		player:sendAnimation(96)
		player:playSound(112)
		player.registry["lastrez"] = os.time()
		npc:talk(0, "Shaman: Darkness will consume you again, "..player.name..", it is inevitable.")
	elseif (string.find(speech, "(.*)bind(.*)") and player.state ~= 1 and player.bindMap > 0) then
		player:sendAnimationXY(15, player.x, player.y, 0)
		npc:talk(0, "Shaman: Darkness will consume you again, "..player.name..", it is inevitable.")
		player:warp(player.bindMap, player.bindX, player.bindY)
		player:sendAnimation(15, 0)
	end
end
}