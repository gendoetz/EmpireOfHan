salon_facegender = {
	click = async(function(player,npc)
		--player:talk(0,""..player.lastClick)
		local t={graphic=convertGraphic(55,"monster"),color=9}
		local opts = { }

				player.npcGraphic=t.graphic
				player.npcColor=t.color
				player.dialogType = 0
				
			table.insert(opts,"Facial Features")
			table.insert(opts,"Eye / Brow Color")
			table.insert(opts,"Gender")
		

			local menuOption=player:menuString("Not happy with your features? My skills are beyond compare, let me mold you into a legend!",opts)

			if(menuOption=="Facial Features") then
				player:dialogSeq({t,"I can assist you if you would like to alter your facial features. It will cost you 2,000 coins."},1)
				if(player.money<2000) then
							player:dialogSeq({t,"You do not have enough money. I do not work for free."})
							return
				end
				salon_facegender.face_select(player)

			elseif(menuOption=="Gender") then
				if(player.spouse~=0) then
					player:dialogSeq({t,"I am sorry, but you may not change gender if you have a partner."})
					return
				end
				player:dialogSeq({t,"If you are unhappy with your gender I can change it. It will cost you 10,000 coins."},1)
				local choice=player:menuString2("Are you sure you wish to change Gender? It will cost 10,000 coins.",{"Yes","No"})
				if(choice=="Yes") then
					if(player.money>=10000) then
						if(player.sex==0) then
							player.sex=1
						elseif(player.sex==1) then
							player.sex=0
						end
						player.money=player.money-10000
						player:sendAnimation(6)
						player:updateState()
						player:sendStatus()
						player:dialogSeq({t,"It is done."})
					else
						player:dialogSeq({t,"You do not have the money. I do not work for free."})
					end
				else
					player:dialogSeq({t,"Suit yourself."})
				end
			elseif(menuOption=="Eye / Brow Color") then
				player:dialogSeq({t,"It will cost you 2,000 coins to change the color of your eyes and brows."},1)
						if(player.money<2000) then
							player:dialogSeq({t,"You do not have enough money. I do not work for free."})
							return
						end
				salon_facegender.face_color(player)	
			end
        end),

face_select = function(player)
	local npc
	local t={graphic=convertGraphic(55,"monster"),color=9}
	
	local faces = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""


		table.insert(faces,"Fearless")
		table.insert(faces,"Mischievous")
		table.insert(faces,"Wide eyed")
		table.insert(faces,"Foxy")
		table.insert(faces,"Brows")
		table.insert(faces,"Modest")
		table.insert(faces,"Hopeful")
		table.insert(faces,"Blanked")
		table.insert(faces,"Cherry")
		table.insert(faces,"Intense")
		table.insert(faces,"Doubtful")
		table.insert(faces,"Sad")
		table.insert(faces,"Satisfied")
		table.insert(faces,"Jumpy")
		table.insert(faces,"Tired")
		table.insert(faces,"Squinty")
		table.insert(faces,"Joyful")
		table.insert(faces,"Naughty")
		table.insert(faces,"Mysterious")
		table.insert(faces,"Passionate")

	repeat
		t={graphic=convertGraphic(55,"monster"),color=9}
		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		styleToCraft = player:menu("What facial features interest you?", faces)

		npc = styling.getFreeStylistNPC(player)
		stylist.setup(npc, player)
		player.lastClick = npc.ID
		player.dialogType = 2
		
		if (styleToCraft == 1) then
			npc.gfxFace = 201
		elseif (styleToCraft == 2) then
			npc.gfxFace = 202
		elseif (styleToCraft == 3) then
			npc.gfxFace = 203
		elseif (styleToCraft == 4) then
			npc.gfxFace = 204
		elseif (styleToCraft == 5) then
			npc.gfxFace = 205
		elseif (styleToCraft == 6) then
			npc.gfxFace = 207
		elseif (styleToCraft == 7) then
			npc.gfxFace = 208
		elseif (styleToCraft == 8) then
			npc.gfxFace = 209
		elseif (styleToCraft == 9) then
			npc.gfxFace = 210
		elseif (styleToCraft == 10) then
			npc.gfxFace = 211
		elseif (styleToCraft == 11) then
			npc.gfxFace = 212
		elseif (styleToCraft == 12) then
			npc.gfxFace = 213
		elseif (styleToCraft == 13) then
			npc.gfxFace = 214
		elseif (styleToCraft == 14) then
			npc.gfxFace = 215
		elseif (styleToCraft == 15) then
			npc.gfxFace = 216
		elseif (styleToCraft == 16) then
			npc.gfxFace = 217
		elseif (styleToCraft == 17) then
			npc.gfxFace = 218
		elseif (styleToCraft == 18) then
			npc.gfxFace = 224
		elseif (styleToCraft == 19) then
			npc.gfxFace = 225
		elseif (styleToCraft == 20) then
			npc.gfxFace = 229
		end

		choice = player:menuString("Is this how you would like your face to look?", options)
		
		if (choice == "Yes") then

			player.face = npc.gfxFace
			player:updateState()
			player.money=player.money-2000
			player:sendStatus()

		elseif (choice == "No") then
			player.lastClick = 3221225499
		end
	until (choice == "Yes")

end,

face_color = function(player)
	local npc
	local t={graphic=convertGraphic(55,"monster"),color=9}
	
	local faceColors = {}
	local styleToCraft = 0

	local options = {"Yes", "No"}
	local choice = ""


		table.insert(faceColors, "Black")
		table.insert(faceColors, "White")
		table.insert(faceColors, "Red")
		table.insert(faceColors, "Light Red")
		table.insert(faceColors, "Rust")
		table.insert(faceColors, "Blue")
		table.insert(faceColors, "Light Blue")
		table.insert(faceColors, "Turquoise")
		table.insert(faceColors, "Brown")
		table.insert(faceColors, "Light Brown")
		table.insert(faceColors, "Blonde")
		table.insert(faceColors, "Green")
		table.insert(faceColors, "Light Green")
		table.insert(faceColors, "Light Purple")
		table.insert(faceColors, "Purple")
		table.insert(faceColors, "Dark Purple")
		table.insert(faceColors, "Orange")
		table.insert(faceColors, "Mint Green")
		table.insert(faceColors, "Honest Blue")
		table.insert(faceColors, "Dull Blue")

	repeat
		t={graphic=convertGraphic(55,"monster"),color=9}
		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		styleToCraft = player:menu("What color would you like your eyes and brows?", faceColors)

		npc = styling.getFreeStylistNPC(player)
		stylist.setup(npc, player)
		player.lastClick = npc.ID
		player.dialogType = 2
		
		if (styleToCraft == 1) then
			npc.gfxFaceC = 0
		elseif (styleToCraft == 2) then
			npc.gfxFaceC = 1
		elseif (styleToCraft == 3) then
			npc.gfxFaceC = 21
		elseif (styleToCraft == 4) then
			npc.gfxFaceC = 11
		elseif (styleToCraft == 5) then
			npc.gfxFaceC = 27
		elseif (styleToCraft == 6) then
			npc.gfxFaceC = 7
		elseif (styleToCraft == 7) then
			npc.gfxFaceC = 8
		elseif (styleToCraft == 8) then
			npc.gfxFaceC = 12
		elseif (styleToCraft == 9) then
			npc.gfxFaceC = 2
		elseif (styleToCraft == 10) then
			npc.gfxFaceC = 13
		elseif (styleToCraft == 11) then
			npc.gfxFaceC = 20
		elseif (styleToCraft == 12) then
			npc.gfxFaceC = 42
		elseif (styleToCraft == 13) then
			npc.gfxFaceC = 5
		elseif (styleToCraft == 14) then
			npc.gfxFaceC = 29
		elseif (styleToCraft == 15) then
			npc.gfxFaceC = 3
		elseif (styleToCraft == 16) then
			npc.gfxFaceC = 9
		elseif (styleToCraft == 17) then
			npc.gfxFaceC = 10
		elseif (styleToCraft == 18) then
			npc.gfxFaceC = 23
		elseif (styleToCraft == 19) then
			npc.gfxFaceC = 24
		elseif (styleToCraft == 20) then
			npc.gfxFaceC= 14
		end

		choice = player:menuString("Is this how you would like your eye and brow color?", options)
		
		if (choice == "Yes") then

			player.faceColor = npc.gfxFaceC
			player:updateState()
			player.money=player.money-2000
			player:sendStatus()

		elseif (choice == "No") then
			player.lastClick = 3221225499
		end

	until (choice == "Yes")

end,
}