kalbog_elder = {
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
	if (player.quest["kalbog_questline"] == 0) then
		player:dialogSeq({t, "I see you have made it past the protector. You are smart, you have wits--perhaps my story will not fall on deaf ears with you...",
		t, "It is no surprise that you had to fight your way here. The creatures you are fighting I once called my brothers, my sisters, my friends, my people...",
		t, "We are the Kalbog tribe, or at least we once were. Our visage has changed, warped and mutated by the dark magic of a corrupt leader.",
		t, "Don't look at me in that way.. We once were a people similar to you, but with different colored skin and an afinity for the dark arts, and it is this darkness that ate at our souls.",
		t, "There are tales that a few of us still exist in a kingdom untouched by the corruption of our thirst for dark magic, and I have hope that I may one day return to them.",
		t, "If you could assist me, I could continue my search. I need to surpress my magic with the dark fae cider and magical herbs and I cannot bring myself to pry it from the hands of my kin.",
		t, "Before you go running off, there is one problem.. the spirits that surround me will do anything to get their hands on the cider and herbs.. you must be careful...",
		t, "Please bring me (5) Sacks of Fae Herbs and (1) Dark Fae Cider."}, 1)
			player.quest["kalbog_questline"] = 1
	elseif (player.quest["kalbog_questline"] == 1) then
		player:removeLegendbyName("kalbog1")
		player:dialogSeq({t, "Have you brought me the items I have requested?"}, 1)
		if (player:hasItem("dark_fae_cider", 1) == true and player:hasItem("fae_herbs", 5) == true) then
			player:removeItem("dark_fae_cider", 1)
			player:removeItem("fae_herbs", 5)
			player:dialogSeq({t, "You have them, quickly hand them over!",
			t, "Take this as your reward!"}, 1)
			player:addGold(600)
			player:giveXP(50000)
			onCalcTNL(player)
			player:addItem("kalbog_helm", 1)
			player:msg(8, "Rewards:\nGold: 600\nExp: 50000\n<b>Kalbog Helm", player.ID)
			player:removeLegendbyName("kalbog1")
			player:addLegend("Helped the Kalbog Elder escape the torment of his ancestors. "..curT(), "kalbog1", 5, 16)
			player.quest["kalbog_questline"] = 2
		else
			player:dialogSeq({t, "Please bring me (5) Sacks of Fae Herbs and (1) Dark Fae Cider."}, 1)
		end
	elseif (player.quest["kalbog_questline"] == 2) then
		player:dialogSeq({t, "Perhaps I will seek you out when I have discovered more about my people..."}, 1)
	end

end)
}