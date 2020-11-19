passage_npc1 = {
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
		local opts = { }

		if (player.m == 77) then
		table.insert(opts,"Yes, take me to Halvung shore.")
		table.insert(opts,"I'm good on land, thanks..")
			player:dialogSeq({t, "Hm, you wanna head south? Southern Han is restricted to travelers by foot. I could take you by boat to the Halvung shore.. but it'll cost yeh!"}, 1)
			local choice=player:menuString2("Make your decision, I don't have all day...", opts)
			if(choice=="Yes, take me to Halvung shore.") then
				if(player.money<1000) then
					player:dialogSeq({t,"You trying to swindle me? You don't have enough money.."})
					return
				end
				player.money=player.money-1000
				player:updateState()
				player:sendStatus()
				player:warp(38, 15, 25)
				return -- Return throws them out of loop back to nothing, they wont get the still havent found message
			elseif(choice=="I'm good on land, thanks..") then
				player:dialogSeq({t, "Suit yourself landlubber."}, 1) -- You had a bracket here instead of a paranthesis, and a bracket needed to come before the comma
				return -- return allows you to stop all the remaining code below this if they say no.
			end
		end
		if (player.m == 38) then
		table.insert(opts,"Yes, take me back to the Seong region.")
		table.insert(opts,"Not yet.")
			player:dialogSeq({t, "You be lucky I charged yeh double so you can make your way back..."}, 1)
			local choice=player:menuString2("Heading back to the Seong Lowlands?", opts)
			if(choice=="Yes, take me back to the Seong region.") then
				player:warp(77, 63, 71)
				return -- Return throws them out of loop back to nothing, they wont get the still havent found message
			elseif(choice=="Not yet.") then
				player:dialogSeq({t, "Suit yourself landlubber."}, 1) -- You had a bracket here instead of a paranthesis, and a bracket needed to come before the comma
				return -- return allows you to stop all the remaining code below this if they say no.
			end
		end

end)
}