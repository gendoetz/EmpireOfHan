elixir_assistant = {
	click = async(function(player,npc)
		--player.registry["elixircolor"]=65
		local f=0
		local g=0
		local t={graphic=convertGraphic(6,"monster"),color=15}
	        local opts = { }

                              player.npcGraphic=t.graphic
			      player.npcColor=t.color
			      	if((player.registry["carnagehost"]==1 and player.armorColor==7020) or player.registry["carnagehost"]>1) then
					table.insert(opts,"Nuisance")
					table.insert(opts,"Dye Participants")
					table.insert(opts,"Send Elixir Hall")
					table.insert(opts,"Move Participant")
					table.insert(opts,"Elixir Hall Warp")
					table.insert(opts,"Move To Sidelines")
					table.insert(opts,"Check Participants Status")
					table.insert(opts,"Set Bow Success Rate")
					table.insert(opts,"Set Bow Range")
					table.insert(opts,"Set Referee")
					table.insert(opts,"===================")
					table.insert(opts,"Set Field Barricades")
					table.insert(opts,"Clear Field Barricades")
					table.insert(opts,"Set Side Barricades")
					table.insert(opts,"Clear Side Barricades")
					table.insert(opts,"===================")
					table.insert(opts,"Declare Red Winner")
					table.insert(opts,"Declare Blue Winner")
			      	end
				table.insert(opts,"Acquire Elixir Bow")
				table.insert(opts,"Leave Elixir")

				if(player.registry["event_win_type"] == 2) then
					table.insert(opts,"Claim Prize")
				end

				local menuOption=player:menuString("Hello.\n\nHow can I help you?",opts)
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
				elseif(menuOption=="Claim Prize") then
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
					player.state=0
					--player:updateState()
					player:removeItem("elixir_trophy",1)
					player:removeItem("elixir_bow2",1)
					player.registry["elixirarrowsleft"]=0
					player:warp(7003, math.random(3, 13), math.random(9, 11))
				elseif(menuOption=="Declare Red Winner") then
					player:dialogSeq({t,"Make sure you are certain you wish to declair Red team the winners!"},1)
					local pla={}
					for x=0,100 do
						for y=0,100 do
							pla=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#pla>0) then
								for z=1,#pla do
									if(pla[z].armorColor~=7020) then
										if(pla[z].registry["elixircolor"]==63) then
											--pla[z]:warp(7003, math.random(3, 13), math.random(9, 11))
											pla[z].registry["event_win_type"] = 2
											pla[z].registry["elixirarrowsleft"]=0
											--pla[z]:updateState()
											--pla[z]:refresh()
										end
										pla[z]:removeItem("elixir_trophy",1)
									end
								end
							end
						end
					end
				elseif(menuOption=="Declare Blue Winner") then
					player:dialogSeq({t,"Make sure you are certain you wish to declair Blue team the winners!"},1)
					local pla={}
					for x=0,100 do
						for y=0,100 do
							pla=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#pla>0) then
								for z=1,#pla do
									if(pla[z].armorColor~=7020) then
										if(pla[z].registry["elixircolor"]==65) then
											--pla[z]:warp(7003, math.random(3, 13), math.random(9, 11))
											pla[z].registry["event_win_type"] = 2
											pla[z].registry["elixirarrowsleft"]=0
											--pla[z]:updateState()
											--pla[z]:refresh()
										end
										pla[z]:removeItem("elixir_trophy",1)
									end
								end
							end
						end
					end
				elseif(menuOption=="Dye Participants") then
					powerBoard(player)
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
					player.state=0
					--player:updateState()
					--player:refresh()
					player.armorColor = player.registry["arenaDyeSave"]
					player.registry["arenaDyeSave"] = 0
					player:removeItem("elixir_trophy",1)
					player:removeItem("elixir_bow2",1)
					player.registry["elixirarrowsleft"]=0
					player:warp(7000, math.random(7, 16), math.random(13, 14))
					return
				elseif(menuOption=="Set Bow Success Rate") then
					player:dialogSeq({t,"Carnage Host, this tool allows you to set the Success rate of the Elixir bows. Values can be used from 50% to 100%. Press next to proceed."},1)
					local per=player:input("What shall the success rate be? (50-100)")
					per=math.floor(math.abs(tonumber(per)))
					if(per<=50) then
						per=50
					end
					if(per>=100) then
						per=100
					end
					player.mapRegistry["bowrate"]=per
					player:broadcast(player.m,"-Host "..player.name.." has set the Elixir Bow Success rate to "..per.."%.")
				elseif(menuOption=="Set Bow Range") then
					player:dialogSeq({t,"Carnage Host, this tool allows you to set the range of the Elixir arrows. Values in tiles can be chosen from 3 to 50. Press next to proceed."},1)
					local per=player:input("What shall the arrow range be? (3-50)")
					per=math.floor(math.abs(tonumber(per)))
					if(per<=3) then
						per=3
					end
					if(per>=50) then
						per=50
					end
					player.mapRegistry["bowrange"]=per
					player:broadcast(player.m,"-Host "..player.name.." has set the Elixir Arrows Range rate to "..per.." tiles.")
				elseif(menuOption=="Check Participants Status") then
				    if(player.registry["checkaliveparticipants"]+5<=os.time()) then
					player.registry["checkaliveparticipants"]=os.time()
					local red=0
					local blue=0
					local nuisance = { }
					for x=2,30 do
						for y=6,34 do
							nuisance=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
									if(nuisance[z].armorColor==63 and nuisance[z].state~=1) then
										red=red+1
									elseif(nuisance[z].armorColor==65 and nuisance[z].state~=1) then
										blue=blue+1
									end
								end
							end		
						end
					end
					player:dialogSeq({t,"The following number of players are still present on the Gaming field:\n\nRed  : "..red.."\nBlue : "..blue.."\n"})
				   else
					player:dialogSeq({t,"You can only check participants every 5 seconds."})
				   end
				elseif(menuOption=="Move To Sidelines") then
					player:dialogSeq({t,"Carnage Host, This tool allows you to send EVERYONE to the sidelines. Proceed with great caution."},1)
					local pla={}
					for x=0,100 do
						for y=0,100 do
							pla=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#pla>0) then
								for z=1,#pla do
									if(pla[z].armorColor~=7020) then
										if(pla[z].registry["elixircolor"]==65) then
											pla[z]:warp(player.m,math.random(4,28),math.random(37,39))
											pla[z].armorColor=pla[z].registry["elixircolor"]
											pla[z].registry["elixirarrowsleft"]=0
											--pla[z]:updateState()
											--pla[z]:refresh()
										elseif(pla[z].registry["elixircolor"]==63) then
											pla[z]:warp(player.m,math.random(4,28),math.random(1,3))
											pla[z].armorColor=pla[z].registry["elixircolor"]
											pla[z].registry["elixirarrowsleft"]=0
											--pla[z]:updateState()
											--pla[z]:refresh()
										end
										pla[z]:removeItem("elixir_trophy",1)
									end
								end
							end
						end
					end
													
				elseif(menuOption=="Move Participant") then
					local nameofPlayer
					local w=0
					local nuisance = { }
					nameofPlayer=player:input("Who do you need to move to the sideline from the field?")
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
				elseif(menuOption=="Send Elixir Hall") then
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
										--Player(nameofPlayer):updateState()
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

					player:dialogSeq({t,"You will send all players back to the Elixir Hall, click Next to proceed."},1)
					
					local f=0
					local g=0
					for x=0,100 do
						for y=0,100 do
							nuisance=player:getObjectsInCell(player.m,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								if(string.lower(nuisance[z].name)~=string.lower(player.name) and nuisance[z].armorColor~=7020) then
									if(nuisance[z].state==1) then											 						nuisance[z]:addHealth(1000000000)
										nuisance[z].state=0
										
									end
										nuisance[z].armorColor=nuisance[z].registry["elixircolor"]
										--nuisance[z]:updateState()
										nuisance[z]:removeItem("elixir_trophy",1)
										nuisance[z]:warp(7006,14,27)
								end
								end
									 
                                                         end
						end
					end
					end
				elseif(menuOption=="Elixir Hall Warp") then
						player:warp(7006,14,5)
				elseif(menuOption=="Clear Field Barricades") then
					local barcheck = {}
					player:dialogSeq({t,"This tool allows you to remove every barricade on the gaming field instantly. Side barricades will not be affected. Press next to proceed."},1)
						for x=1,31 do
							for y=5,35 do
								barcheck=player:getObjectsInCell(player.m,x,y,BL_MOB)
								if(#barcheck>0) then
									for z=1,#barcheck do
										if(string.lower(barcheck[z].name)==string.lower("barricade")) then
												barcheck[z].attacker=player.ID
												barcheck[z]:delete()
										end
									end
								end
							end
						end
				elseif(menuOption=="Clear Side Barricades") then
					local barcheck = {}
					player:dialogSeq({t,"This tool allows you to remove every barricade on the sidelines instantly. Field barricades will not be affected. Press next to proceed."},1)
						for x=0,32 do
							for y=0,4 do
								barcheck=player:getObjectsInCell(player.m,x,y,BL_MOB)
								if(#barcheck>0) then
									for z=1,#barcheck do
										if(string.lower(barcheck[z].name)==string.lower("barricade")) then
												barcheck[z].attacker=player.ID
												barcheck[z]:delete()
										end
									end
								end
							end
						end
						for x=0,32 do
							for y=37,40 do
								barcheck=player:getObjectsInCell(player.m,x,y,BL_MOB)
								if(#barcheck>0) then
									for z=1,#barcheck do
										if(string.lower(barcheck[z].name)==string.lower("barricade")) then
												barcheck[z].attacker=player.ID
												barcheck[z]:delete()
										end
									end
								end
							end
						end
				elseif(menuOption=="Set Referee") then
					local refcheck = {}
					refcheck=player:getObjectsInCell(player.m,16,20,BL_MOB)
						if(#refcheck == 0) then
							player:spawn(201,16,20,1)
						end
				elseif(menuOption=="Set Field Barricades") then
					local barcheck = {}
					player:dialogSeq({t,"This tool allows you to set the field barricades."},1)
						--for x=16,30 do
							x = 16
							y = 34
							--for y=20,34 do
							repeat
								barcheck=player:getObjectsInCell(player.m,x,y,BL_MOB)
								if(#barcheck == 0) then
									player:spawn(100,x,y,1)
								end
								y = y - 1
								x = x + 1
							until (y == 19)

							x = 16
							y = 6
							--for y=20,34 do
							repeat
								barcheck=player:getObjectsInCell(player.m,x,y,BL_MOB)
								if(#barcheck == 0) then
									player:spawn(100,x,y,1)
								end
								y = y + 1
								x = x - 1
							until (y == 21)
						--end
				elseif(menuOption=="Set Side Barricades") then
					player:dialogSeq({t,"Carnage Host, This tool allows you to set Sideline barricades. Press next to proceed"},1)
					local barcheck = {}
					for y=1,3 do	
						barcheck=player:getObjectsInCell(player.m,2,y,BL_MOB)
						if(#barcheck==0) then
							player:spawn(100,3,y,1)
						end
					end
					for y=37,39 do	
						barcheck=player:getObjectsInCell(player.m,2,y,BL_MOB)
						if(#barcheck==0) then
							player:spawn(100,3,y,1)
						end
					end
					for y=1,3 do	
						barcheck=player:getObjectsInCell(player.m,36,y,BL_MOB)
						if(#barcheck==0) then
							player:spawn(100,29,y,1)
						end
					end
					for y=37,39 do	
						barcheck=player:getObjectsInCell(player.m,36,y,BL_MOB)
						if(#barcheck==0) then
							player:spawn(100,29,y,1)
						end
					end
				elseif(menuOption=="Acquire Elixir Bow") then
					player:dialogSeq({t,"You need a bow to participate in the Elixir War."},1)
					if(player:hasSpace("elixir_bow2",1) and player:hasItem("elixir_bow2",1)~=true) then

					local check_bow = player:getEquippedItem(EQ_WEAP)
					if (check_bow ~= nil) then
						if (check_bow.id ~= nil) then
							if (check_bow.id == 20007) then
								player:dialogSeq({t, "You currently have an elixir bow equipped."}, 1)
								return
							end
						end
					end

						player:addItem("elixir_bow2",1)
					else
						player:dialogSeq({t, "You cannot obtain an elixir bow."}, 1)
					end
					
				end
        end)
}

