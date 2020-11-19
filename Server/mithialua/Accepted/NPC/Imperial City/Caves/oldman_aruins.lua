oldman_aruins = {
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

	player:dialogSeq({t, "Ah, you're interested in some of my Elecampane flowers? You know, to grow these delicate flowers, you must grow them with very rare soil.",
	t, "I'd be willing to part with a dozen of my beautiful flowers for a fair price. What do you say?"}, 1)
	local menuOption2=player:menuString("Interested in my flowers?",{"Pay 5,000 coins.", "No thank you!"})
	if(menuOption2=="Pay 5,000 coins.") then
		if(player.money >= 5000) then
			player.money = player.money - 5000
			player:sendStatus()
			player:dialogSeq({t, "Thank you kindly, here are the flowers, as promised."}, 1)
			player:addItem("flower_elecampane", 12)
		else
			player:dialogSeq({t,"Come back when you have the coin, child."})
		end
	else
		player:dialogSeq({t,"Very well then. If you should ever happen to need a dozen or so of these rare flowers, you know where to find me."})
	end

end)
}