han_parcel_npc = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local wolf = {graphic = convertGraphic(23, "monster"), color = 21}
	local opts = { }
	local optsPO = {}
	local welcomemsg = {"Do you wish to send a parcel or package an item?",
	"Welcome!","Welcome, how may I help you?",
	"Welcome, we have the finest sheets!",
	"Welcome "..player.name..". Would you like to rest for the night?"}
local rwelcome = math.random(#welcomemsg)

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	table.insert(opts,"Buy")
	table.insert(opts,"Sell")
	table.insert(opts,"Post Office Services")
	table.insert(opts,"A special delivery...")


local menuOption=player:menuString(""..welcomemsg[rwelcome],opts)
if(menuOption=="Post Office Services") then
			local item = player:getParcel()
			table.insert(optsPO,"Send")
			if (item ~= false) then
				table.insert(optsPO,"Receive")
			end
			local menuOptionPO=player:menuString("Post Office Services",optsPO)
			if (menuOptionPO=="Send") then
				player:sendParcelTo(npc)
			elseif (menuOptionPO=="Receive") then
				player:receiveParcelFrom(npc)
			end
elseif(menuOption=="A special delivery...") then
			if (player.quest["spec_deliv"] == 0) then
				player:dialogSeq({t, "Dagnabbit! Those pesky wolves again! I'm not as young as I used to be; otherwise I'd show them who's boss!",
				t, "Oh, sorry... I'm just going on about my troubles like no ones there. Did you need to send a parcel? No?",
				t, "Then perhaps you could lend me a hand! My courriers have been having trouble with a foul beast in the Seong Lowlands.",
				wolf, "They say it's a feral wolf with glowing red eyes and he's fast as lightning. The peculiar thing is that he only goes after courriers!",
				wolf, "Maybe he has an adversion to men who travel around with sacks full of deliveries... at any rate its a problem!",
				wolf, "Here, take this package and travel west out of the main city, before long you'll meet him! I'll reward you once you bring me proof of his demise!"}, 1)
				player.quest["spec_deliv"] = 1
				player:addItem("c_deliv", 1)
			elseif (player.quest["spec_deliv"] == 1) then
				player:dialogSeq({t, "Did you lose your way? Head out to Seong Lowlands and search for that wolf!"}, 1)
					if (player:hasItem("c_deliv", 1) ~= true) then
						player:dialogSeq({t, "Did you lose the package? No bother it was empty, here's another!"}, 1)
						player:addItem("c_deliv", 1)
					end
			elseif (player.quest["spec_deliv"] == 2) then
				player:dialogSeq({t, "VANISHED!?.... wait.. wo-wo-wo-WOLF!! Behind you!"}, 1)

				local mobBlocks = player:getObjectsInSameMap(BL_MOB)
				if (#mobBlocks == 0) then
					player:spawn(138, 9, 8, 1)
				end

			elseif (player.quest["spec_deliv"] == 3) then
					player:dialogSeq({t, "He followed you back! But you got him... At last! No more trouble in transit, my courriers will be... well.. alive!"}, 1)
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player:addGold(1500)
						player:giveXP(50000)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 1500\nExp: 50000\nImperial Standing: +1", player.ID)
						player.quest["spec_deliv"] = 4
			elseif (player.quest["spec_deliv"] == 4) then
				player:dialogSeq({t, "Thanks again for your help!"}, 1)

			end
end

end),


}