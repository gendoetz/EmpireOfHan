gm_option_npc = {
click = async(function(player,npc)
		--player.lastClick = 3221225472
		--player:talk(0,""..npc.id)
		local t={graphic=convertGraphic(57,"monster"),color=20}

		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		if (player.gmLevel >= 10) then
			gm_option_npc.main_options(player, npc)
		else
			player:dialogSeq({t, "I am sorry, you are not powerful enough for me to assist you."}, 1)
			return
		end
end),

main_options = function(player,npc)
		local t={graphic=convertGraphic(57,"monster"),color=20}
		local buymsg = {"What do you wish to buy?","What do you wish to buy today?","What would you like to buy?","What can I offer you?"}
		local rbuy = math.random(#buymsg)
		local opts = { }

		table.insert(opts,"Dye Options")
		table.insert(opts,"Reset Armor Quest")
		table.insert(opts,"Ref Code")
		table.insert(opts,"Grant Exp1")
		table.insert(opts,"Grant Exp2")
		table.insert(opts,"Grant Exp3")
		table.insert(opts,"Grant Exp4")
		--table.insert(opts,"Quest Test")


			local choice=player:menuString("How may I help you?", opts)
			if(choice=="Grant Exp1") then
							player:giveXP(1000000)
							onCalcTNL(player)
			elseif(choice=="Grant Exp2") then
							player:giveXP(5000000)
							onCalcTNL(player)
			elseif(choice=="Grant Exp3") then
							player:giveXP(10000000)
							onCalcTNL(player)
			elseif(choice=="Grant Exp4") then
							player:giveXP(100000000)
							onCalcTNL(player)
			elseif(choice=="Ref Code") then

					player:dialogSeq({t, "Ref: "..player.registry["playerRefID"]}, 1)
					player.registry["playerRefID"] = 0

			elseif(choice=="Dye Options") then
				gm_option_npc.dye_options(player, npc)
				--return
			elseif(choice=="Reset Armor Quest") then
				player.quest["warrior_65armor"] = 0
				player.quest["mage_65armor"] = 0
				player.quest["rogue_65armor"] = 0
				player.quest["poet_65armor"] = 0
			end
end,

dye_options = function(player,npc)
		local dyes = { }
		table.insert(dyes,"Blue")
		table.insert(dyes,"White")
		table.insert(dyes,"Black")
		table.insert(dyes,"Red")
		table.insert(dyes,"GM Orange")
		table.insert(dyes,"Bleach")

			local choice=player:menuString("Which dye would you like applied to your clothes?",dyes)
			if(choice=="White") then
				player.armorColor=11
				player:sendStatus()
				player:updateState()
				--player:dialogSeq({t,"It is done."})
			elseif(choice=="Red") then
				player.armorColor=31
				player:sendStatus()
				player:updateState()
				--player:dialogSeq({t,"It is done."})
			elseif(choice=="Black") then
				player.armorColor=10
				player:sendStatus()
				player:updateState()
				--player:dialogSeq({t,"It is done."})
			elseif(choice=="Blue") then
				player.armorColor=17
				player:sendStatus()
				player:updateState()
				--player:dialogSeq({t,"It is done."})
			elseif(choice=="GM Orange") then
				player.armorColor=20
				player:sendStatus()
				player:updateState()
				--player:dialogSeq({t,"It is done."})
			elseif(choice=="Bleach") then
				player.armorColor=0
				player:sendStatus()
				player:updateState()
			end
			--return gm_option_npc.main_options(player, npc)
end
}