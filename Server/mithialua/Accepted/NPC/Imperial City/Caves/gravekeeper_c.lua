gravekeeper_c = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	--local opts = {"Buy", "Sell", "Important research..."}
	--local optsbuy = {"Potions", "Alchemy Materials"}
	--local menuOption
	--local menuOptionBuy
	--local menuOptionSell
				--table.insert(opts,"A rare flower...")
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	--menuOption = player:menuString("Potions are my specialty!", opts)
	if(player.quest["gravekeeper_questline"] == 1) then
		player:dialogSeq({t, "Oh thank the empress, help has arrived! I have locked myself away from those vile THINGS for as long as I possibly could!",
		t, "I do not understand what happened! One minute I was working on fastening a sarcophagus for a client, and the next I'm gasping for air and I wake up to my entire mortuary crawling with undead!",
		t, "What? Is there something wrong?"}, 1)
			local menuOption2=player:menuString("What is it?",{"Um, Do you know that..You're dead?", "Bizzare.. Tell me what happened next.."})
				if(menuOption2=="Um, Do you know that..You're dead?") then
					player:dialogSeq({t, "*The Gravekeeper looks down at his own body and screams*. I'M ONE OF THEM!?",
					t, "*After several brief moments of panic, the gatekeeper collects himself and continues on*"}, 1)
				end
		player:dialogSeq({t, "It was that damned client I was working for! When I cracked open the sarcopagus, a green cloud of debris ended up stagnating the air. How long have I been trapped in this place for?!"}, 1)
			local menuOption2=player:menuString("What is it?",{"*You quietly whisper the date into", " the Gravekeeper's ear*"})
		player:dialogSeq({t, "*The Gravekeeper's already pale, ghostly visage manages to grow even more pale*",
		t, "It has been... That long..?",
		t, "You must do something, even if so much time has passed! The client must be stopped if they still reside in these walls! They have turned my beloved mortuary into a festering pool of death!",
		t, "Search my dresser drawers for anything that you might find to be of use! Return to me once you have fully searched this place!"}, 1)
		player.quest["gravekeeper_questline"] = 0
	end
end),

grant_key = async(function(player,npc)
	local t={graphic=convertGraphic(30,"monster"),color=35}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	if(player.quest["gravekeeper_questline"] == 0) then
		player:dialogSeq({t, "An eerie voice speaks to you:"}, 1)
		local gravekeeperpass=player:input("You seek the Gravekeeper's key? What is the password?")
		if (tonumber(gravekeeperpass) == 666) then
			player:dialogSeq({t, "That is correct!"}, 1)
			player:addItem("graves_key1", 1)
			player.quest["gravekeeper_questline"] = 1
		else
			player:dialogSeq({t, "That is incorrect!"}, 1)
		end
	end
end)
}