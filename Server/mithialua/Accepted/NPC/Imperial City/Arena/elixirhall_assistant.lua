elixirhall_assistant = {
	click = async(function(player,npc)
		--player.registry["elixircolor"]=65
		local f=0
		local g=0
		local t={graphic=convertGraphic(71,"monster"),color=0}
	    local opts = { }

			player.npcGraphic=t.graphic
			player.npcColor=t.color
			player.dialogType = 0
			      	if((player.registry["carnagehost"]==1 and player.armorColor==7020) or player.registry["carnagehost"]>1) then
			      	table.insert(opts,"Autodye")
					table.insert(opts,"Nuisance")
					table.insert(opts,"Warp Below")
					table.insert(opts,"Dye Participants")
					table.insert(opts,"Sort Participants")
					table.insert(opts,"Move Participant")
					table.insert(opts,"Set Elixir Map")
					table.insert(opts,"Elixir Map Warp")
			      	end
			      	table.insert(opts,"Leave Elixir")

				local menuOption=player:menuString("Hello. How can I help you?",opts)
				if(menuOption=="Nuisance") then
						local nameofPlayer
						nameofPlayer=player:input("Who do you need to remove?")
						local nuisance = Player(nameofPlayer)
						if(nuisance ~= nil) then
						if (nuisance.m >= 7000 and nuisance.m <= 7200) then
									nuisance:warp(7008, 8, 8)
									nuisance.registry["inCarnage"] = 0
									nuisance:sendMinitext("You have been removed by "..player.name..".")
									player:sendMinitext(""..nameofPlayer.." has been removed.")
						else
							player:sendMinitext("They are not on any arena maps.")
						end
							else
								player:sendMinitext("They are not on any arena maps.")
							end
				elseif (menuOption=="Warp Below") then
					player:warp(7006,14,27)
				elseif (menuOption=="Set Elixir Map") then
							local options = {"River Arena", "Evergreen Arena"}
							local choice = player:menuString("Please select the arena.", options)
							
							if (choice == "River Arena") then
								npc.registry["arena"] = 7050
								NPC(79):warp(npc.registry["arena"], 16, 37)
								NPC(83):warp(npc.registry["arena"], 16, 3)
								--player:broadcast(player.m, "Host "..player.name.." has chosen Crossroads arena.")
							elseif (choice == "Evergreen Arena") then
								npc.registry["arena"] = 7051
								NPC(79):warp(npc.registry["arena"], 16, 37)
								NPC(83):warp(npc.registry["arena"], 16, 3)
								--player:broadcast(player.m, "Host "..player.name.." has chosen Violet Fire arena.")
							end
				elseif(menuOption=="Autodye") then
					local players = npc:getObjectsInSameMap(BL_PC)

					for i = 1, #players do
						if (players[i].armorColor ~= 7020 and players[i].gmLevel == 0) then
							if i % 2 == 0 then
							--print (i, " is even")
							players[i].armorColor=63
							players[i]:sendStatus()
							players[i]:refresh()
							else
							--print (i, " is odd")
							players[i].armorColor=65
							players[i]:sendStatus()
							players[i]:refresh()
							end
						end
					end
						--[[setObject(npc.m, 10, 9, 342)
						setObject(npc.m, 11, 9, 343)
						setObject(npc.m, 17, 9, 342)
						setObject(npc.m, 18, 9, 343)]]

						--Opens doors below here
						--setObject(npc.m, 10, 9, 370)
						--setObject(npc.m, 11, 9, 371)
						--setObject(npc.m, 17, 9, 370)
						--setObject(npc.m, 18, 9, 371)

				elseif(menuOption=="Leave Elixir") then
					player:dialogSeq({t,"Are you certain you want to leave? This could handicap your team.\n\nClick Next only if you are sure..."},1)
					
					local check_bow = player:getEquippedItem(EQ_WEAP)
					if (check_bow ~= nil) then
						if (check_bow.id ~= nil) then
							if (check_bow.id == 20007) then
								player:dialogSeq({t, "Please remove your elixir bow first."}, 1)
								return
							end
						end
					end
					player.registry["elixircolor"] = 0
					player:addHealth(player.maxHealth)
					player.state=0
					player:updateState()
					player:removeItem("elixir_trophy",1)
					player:removeItem("elixir_bow",1)
					player.registry["elixirarrowsleft"]=0
					player:warp(7008, 8, 8)
					return
				elseif(menuOption=="Dye Participants") then
					powerBoard(player)
				elseif(menuOption=="Move Participant") then
					local nameofPlayer
					local w=0
					local nuisance = { }
					nameofPlayer=player:input("Who do you need to move within the Arena?")
					for x=0,100 do
						for y=0,100 do
							nuisance=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								 	if(string.lower(nuisance[z].name)==string.lower(nameofPlayer)) then
										if(nuisance[z].registry["elixircolor"]==63) then
											Player(nameofPlayer).armorColor=player.registry["elixircolor"]	
											Player(nameofPlayer):warp(2081,15,4)
											player:sendMinitext(""..nameofPlayer.." has been moved.")
											w=1
											break
										elseif(nuisance[z].registry["elixircolor"]==65) then
											Player(nameofPlayer):warp(2081,20,51)
											player:sendMinitext(""..nameofPlayer.." has been moved.")
											w=1
											break
										end
									end
								end
							end		
						end
					end
					if(w==0) then
						player:dialogSeq({t,""..nameofPlayer.." isn't around or isn't a player!"})
					end
				elseif(menuOption=="Sort Participants") then
					local w=0
					local nuisance = { }
					local f=0
					local g=0
					local choice=player:menu("Sort Participants :",{"Sort One Participant", "Sort All Participants"})
					if(choice==1) then
					nameofPlayer=player:input("Who do you wish to sort to the Elixir Hall?")
					for x=0,100 do
						for y=0,100 do
							nuisance=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								 	if(string.lower(nuisance[z].name)==string.lower(nameofPlayer)) then
										Player(nameofPlayer).state=0
										Player(nameofPlayer).armorColor=player.registry["elixircolor"]
										Player(nameofPlayer):updateState()
										Player(nameofPlayer):addHealth(nuisance[z].maxHealth)
										Player(nameofPlayer):removeItem("elixir_trophy",1)
										Player(nameofPlayer):warp(7006,14,27)
										player:sendMinitext(""..nameofPlayer.." has been sent to the Elixir Hall.")
										w=1
										break
									end
								end
							end		
						end
					end
					if(w==0) then
						player:dialogSeq({t,""..nameofPlayer.." isn't around!"})
					end
					elseif(choice==2) then

					player:dialogSeq({t,"You will sort all participants to their respective rows in the Carnage hall, click Next to proceed."},1)
					
					local f=0
					local g=0
					for x=0,100 do
						for y=0,100 do
							nuisance=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								if(string.lower(nuisance[z].name)~=string.lower(player.name) and nuisance[z].armorColor~=15) then
									if(nuisance[z].state==1) then											 						nuisance[z]:addHealth(1000000000)
										nuisance[z].state=0
										
									end
										nuisance[z].armorColor=nuisance[z].registry["elixircolor"]
										nuisance[z]:updateState()
										nuisance[z]:addHealth(nuisance[z].maxHealth)
										nuisance[z]:addMana(nuisance[z].maxMagic)
										nuisance[z]:removeItem("elixir_trophy",1)
										nuisance[z]:warp(7006,14,27)
								end
								end
									 
                                                         end
						end
					end
					end
				elseif(menuOption=="Elixir Map Warp") then
					if (npc.registry["arena"] ~= 0) then
						player:warp(npc.registry["arena"],16,25)
					else
						player:dialogSeq({t,"You need to set an arena to proceed."},1)
					end
				end
        end)
}

