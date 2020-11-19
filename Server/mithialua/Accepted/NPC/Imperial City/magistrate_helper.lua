magistrate_helper = {
	click = async(function(player,npc)
		local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	        local opts = { }
	        local optstime = { }
	        local brandingchoices = {"Add Branding", "Remove Branding"}
	        local brandingtypes = {"Disruptive Behavior", "Inappropriate Language", "Cheating/Scamming", "Harrassment"}
	        local brandingyesno = {"Yes", "No"}
                player.npcGraphic=t.graphic
			    player.npcColor=t.color
			    player.dialogType = 0
					if (player.registry["magistrate"] >= 1 or player.gmLevel >= 98) then
					--table.insert(opts,"Assess Sentence")
					table.insert(opts,"Assess/Change Sentence")
					table.insert(opts,"Jail Player")
					table.insert(opts,"Release Player")
					table.insert(opts,"Branding")
					end
					if (player.registry["magistrate"] == 2 or player.gmLevel >= 98) then
					table.insert(opts,"Appoint Magistrate")
					table.insert(opts,"Remove Magistrate")
					end
					if (player.gmLevel >= 98) then
					table.insert(opts,"Appoint Grand Magistrate")
					end
  
		if ((player.registry["magistrate"] >= 1 or player.gmLevel >= 98) and player.registry["jailtime"]==0) then
				local menuOption=player:menuString("Hello Magistrate, How can I help you today?",opts)
				if (menuOption=="Assess Sentence") then
					local nameofPlayer
					local w=0
					local nuisance = { }
					nameofPlayer=player:input("Who's sentence do you wish to assess?")
					for x=0,19 do
						for y=0,19 do
							nuisance=player:getObjectsInCell(73,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								 	if(nuisance[z].name==nameofPlayer) then
										if(Player(nameofPlayer).registry["jailtime"]>1) then
										player:dialogSeq({t,""..nameofPlayer.." still has "..Player(nameofPlayer).registry["jailtime"]-os.time().." seconds to spend here to finish his sentence."})
										elseif(Player(nameofPlayer).registry["jailtime"]==1) then
										player:dialogSeq({t,""..nameofPlayer.." is jailed forever."})
										else
										player:dialogSeq({t,""..nameofPlayer.." has finished his sentence."})
										end
										w=1
										break
									end
								end
							end		
						end
					end
					if(w==0) then
						player:dialogSeq({t,""..nameofPlayer.." isn't jailed! (or is offline)"})
					end
					elseif(menuOption=="Branding") then
						local choice=player:menuString2("What do you wish to do?",brandingchoices)
						if(choice=="Add Branding") then
							local choiceofbranding=player:menuString2("What do you wish to do?",brandingtypes)
								if(choiceofbranding=="Disruptive Behavior") then
									local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
										if(Player(nameofPlayer).registry["jailtime"] == 0) then
										player:sendMinitext("They are not in jail.")
										return
										end
									local brandings = player.registry["DisruptiveBehavior"] + 1
									player.registry["DisruptiveBehavior"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior.", "disruptivebehavior", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior "..brandings.." times.", "disruptivebehavior", 85, 4)
									end
								elseif(choiceofbranding=="Inappropriate Language") then
									local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
										if(Player(nameofPlayer).registry["jailtime"] == 0) then
										player:sendMinitext("They are not in jail.")
										return
										end
									local brandings = player.registry["InappropriateLanguage"] + 1
									player.registry["InappropriateLanguage"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language.", "InappropriateLanguage", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language "..brandings.." times.", "InappropriateLanguage", 85, 4)
									end
								elseif(choiceofbranding=="Cheating/Scamming") then
									local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
										if(Player(nameofPlayer).registry["jailtime"] == 0) then
										player:sendMinitext("They are not in jail.")
										return
										end
									local brandings = player.registry["cheatingscamming"] + 1
									player.registry["cheatingscamming"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming.", "cheatingscamming", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming "..brandings.." times.", "cheatingscamming", 85, 4)
									end
								elseif(choiceofbranding=="Harrassment") then
									local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
										if(Player(nameofPlayer).registry["jailtime"] == 0) then
										player:sendMinitext("They are not in jail.")
										return
										end
									local brandings = player.registry["harassment."] + 1
									player.registry["harassment."] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harrassment.", "harassment.", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harrassment "..brandings.." times.", "harassment.", 85, 4)
									end
								end
						elseif(choice=="Remove Branding") then
							local choiceofbranding=player:menuString2("What do you wish to do?",brandingtypes)
								if(choiceofbranding=="Disruptive Behavior") then
									local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["DisruptiveBehavior"] - 1
									player.registry["DisruptiveBehavior"] = brandings
									if (brandings <= 0) then
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
									elseif (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior.", "disruptivebehavior", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior "..brandings.." times.", "disruptivebehavior", 85, 4)
									end
								elseif(choiceofbranding=="Inappropriate Language") then
										local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["InappropriateLanguage"] - 1
									player.registry["InappropriateLanguage"] = brandings
									if (brandings <= 0) then
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
									elseif (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language.", "InappropriateLanguage", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language "..brandings.." times.", "InappropriateLanguage", 85, 4)
									end
								elseif(choiceofbranding=="Cheating/Scamming") then
										local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["cheatingscamming"] - 1
									player.registry["cheatingscamming"] = brandings
									if (brandings <= 0) then
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
									elseif (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming.", "cheatingscamming", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming "..brandings.." times.", "cheatingscamming", 85, 4)
									end
								elseif(choiceofbranding=="Harrassment") then
										local nameofPlayer=player:input("Who?")
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["harassment."] - 1
									player.registry["harassment."] = brandings
									if (brandings <= 0) then
										Player(nameofPlayer):removeLegendbyName("harassment.")
									elseif (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harassment.", "harassment.", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harassment "..brandings.." times.", "harassment.", 85, 4)
									end
									--END of this clause
								end
						end
					elseif(menuOption=="Jail Player") then
						local nameofPlayer=player:input("Hello, Magistrate.\n\nWho do you wish to jail?")
						if(nameofPlayer==player.name) then
							player:sendMinitext("You cannot jail yourself.")
							return
						end
						if(Player(nameofPlayer) == nil) then
							player:sendMinitext("You cannot jail someone if they are not online.")
							return
						end
						if(Player(nameofPlayer).registry["jailtime"] ~= 0) then
							player:sendMinitext("You cannot jail someone if they are already in jail. Please release them first.")
							return
						end
						local choicebranding=player:menuString2("Will you include a branding with this jailing?",brandingyesno)
						if (choicebranding=="Yes") then
							local choiceofbranding=player:menuString2("Which branding?",brandingtypes)
								if(choiceofbranding=="Disruptive Behavior") then
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["DisruptiveBehavior"] + 1
									player.registry["DisruptiveBehavior"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior.", "disruptivebehavior", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("disruptivebehavior")
										Player(nameofPlayer):addLegend("Has been arrested for disruptive behavior "..brandings.." times.", "disruptivebehavior", 85, 4)
									end
								elseif(choiceofbranding=="Inappropriate Language") then
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["InappropriateLanguage"] + 1
									player.registry["InappropriateLanguage"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language.", "InappropriateLanguage", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("InappropriateLanguage")
										Player(nameofPlayer):addLegend("Has been arrested for inappropriate language "..brandings.." times.", "InappropriateLanguage", 85, 4)
									end
								elseif(choiceofbranding=="Cheating/Scamming") then
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["cheatingscamming"] + 1
									player.registry["cheatingscamming"] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming.", "cheatingscamming", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("cheatingscamming")
										Player(nameofPlayer):addLegend("Has been arrested for cheating/scamming "..brandings.." times.", "cheatingscamming", 85, 4)
									end
								elseif(choiceofbranding=="Harrassment") then
										if(Player(nameofPlayer) == nil) then
										player:sendMinitext("They are not online.")
										return
										end
									local brandings = player.registry["harassment."] + 1
									player.registry["harassment."] = brandings
									if (brandings == 1) then
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harrassment.", "harassment.", 85, 4)
									else
										Player(nameofPlayer):removeLegendbyName("harassment.")
										Player(nameofPlayer):addLegend("Has been arrested for harrassment "..brandings.." times.", "harassment.", 85, 4)
									end
								end
						elseif (choicebranding=="No") then
						player:sendMinitext("No branding will be given.")
						end
						table.insert(optstime,"1 Hour")
						table.insert(optstime,"3 Hours")
						table.insert(optstime,"6 Hours")
						table.insert(optstime,"12 Hours")
						table.insert(optstime,"1 Day")
						table.insert(optstime,"3 Days")
						table.insert(optstime,"1 Week")
						local cell = math.random(1,3)
								if (cell == 1) then
									npc.registry["x"] = 6
									npc.registry["y"] = 5
								elseif (cell == 2) then
									npc.registry["x"] = 15
									npc.registry["y"] = 4
								elseif (cell == 3) then
									npc.registry["x"] = 5
									npc.registry["y"] = 15
								end
						local choice=player:menuString2("How long do you wish to jail the player?",optstime)
									if(Player(nameofPlayer) ~= nil) then
										if(choice=="1 Hour") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 1 hour confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+3600
											player:sendMinitext(""..nameofPlayer..", has been jailed for 1 hour.")
										elseif(choice=="3 Hours") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you 3 hours confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+10800
											player:sendMinitext(""..nameofPlayer..", has been jailed for 3 hour.")
										elseif(choice=="6 Hours") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 6 hours confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+21600
											player:sendMinitext(""..nameofPlayer..", has been jailed for 6 hours.")
										elseif(choice=="12 Hours") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 12 hours confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+43200
											player:sendMinitext(""..nameofPlayer..", has been jailed for 12 hours.")
										elseif(choice=="1 Day") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 1 day confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+86400
											player:sendMinitext(""..nameofPlayer..", has been jailed for 1 Day.")
										elseif(choice=="3 Days") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 3 days confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+259200
											player:sendMinitext(""..nameofPlayer..", has been jailed for 3 Days.")
										elseif(choice=="1 Week") then
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has sentenced you to 1 week confinement.")
											Player(nameofPlayer):warp(73,npc.registry["x"],npc.registry["y"])
											Player(nameofPlayer).mute = true
											Player(nameofPlayer).silence = true
											Player(nameofPlayer).registry["jailtime"]=os.time()+604800
											player:sendMinitext(""..nameofPlayer..", has been jailed for 1 Week.")
										end

										local max=NPC(65).mapRegistry["prisonercount"]

										if(max==0) then
											NPC(65).mapRegistry["prisonercount"]=1
											NPC(65).mapRegistry["prisoner1"]=Player(nameofPlayer).id
											NPC(65).mapRegistry["prisoner1jailtime"]=Player(nameofPlayer).registry["jailtime"]
											--Player(nameofPlayer).registry["jailslot"]=NPC(65).mapRegistry["prisonercount"]
											return true
										end

										NPC(65).mapRegistry["prisonercount"]=max+1
										NPC(65).mapRegistry["prisoner" .. max+1]=Player(nameofPlayer).id
										NPC(65).mapRegistry["prisoner" .. max+1 .. "jailtime"]=Player(nameofPlayer).registry["jailtime"]
										--Player(nameofPlayer).registry["jailslot"]=NPC(65).mapRegistry["prisonercount"]
									else
										player:sendMinitext("You cannot jail someone if they are not online.")
										return
									end
					elseif(menuOption=="Release Player") then
						local nuisance = { }
						local w=0
						local nameofPlayer=player:input("Hello, Magistrate.\n\nWho do you wish to release?")
						if(nameofPlayer==player.name) then
							player:sendMinitext("You are not in jail!")
							return
						end
						for x=0,19 do
						for y=0,19 do
							nuisance=player:getObjectsInCell(73,x,y,BL_PC)
							if(#nuisance>0) then
								for z=1,#nuisance do
								 	if(string.lower(nuisance[z].name)==string.lower(nameofPlayer)) then
								 						local max=NPC(65).mapRegistry["prisonercount"]
								 						for x=1,max do
								 							if(NPC(65).mapRegistry["prisoner" .. x] == Player(nameofPlayer).id) then
																NPC(65).mapRegistry["prisoner" .. x]=0
																NPC(65).mapRegistry["prisoner" .. x .. "jailtime"]=0
															end
														end
								 						--NPC(65).mapRegistry["prisonercount"]=NPC(65).mapRegistry["prisonercount"]-1
														--NPC(65).mapRegistry["prisoner" .. Player(nameofPlayer).registry["jailslot"]]=0
														--NPC(65).mapRegistry["prisoner" .. Player(nameofPlayer).registry["jailslot"] .. "jailtime"]=0
            											Player(nameofPlayer).mute = false
            											Player(nameofPlayer).silence = false
            											han_warden.adjustnumbers(player, npc)
               											Player(nameofPlayer):warp(39,16,5)
											Player(nameofPlayer):sendMinitext("Magistrate "..player.name.." has released you.")
											Player(nameofPlayer).registry["jailtime"]=0
											w=1
									end
								end
							end		
						end
					        end
						if(w==0) then
							player:dialogSeq({t,""..nameofPlayer.." isn't around!"})
						end
					elseif(menuOption=="Assess/Change Sentence") then
						player:dialogSeq({t,"This option will allow you to remove or shorten a player's sentence. (Remember this is number of seconds a player must remain in jail.)"},1)
						--local nameofPlayer=player:input("Who's sentence will you adjust?")
						local max=NPC(65).mapRegistry["prisonercount"]
						local prisoner_name_table={}
						local prisoner_name_table2={}
						local prisoner_jailtime_table={}
						local regname
							if max==0 then
								player:dialogSeq({"No prisoners are currently in jail."})
								return false
							end

						for x=1,max do
							regname="prisoner"..x..""
							table.insert(prisoner_name_table,NPC(65).mapRegistry[regname])
							regname="prisoner"..x.."jailtime"
							table.insert(prisoner_jailtime_table,NPC(65).mapRegistry[regname])
						end

						for i = 1, #prisoner_name_table do
							if (Player(prisoner_name_table[i]) ~= nil) then
							table.insert(prisoner_name_table2,Player(prisoner_name_table[i]).name)
							else
							table.insert(prisoner_name_table2,getOfflineID(prisoner_name_table[i]))
							end
						end

						local listofprisoners=player:menuString2("Who's sentence will you adjust?",prisoner_name_table2)
							for i = 1, #prisoner_name_table2 do
							if(listofprisoners==prisoner_name_table2[i]) then
								regname="prisoner"..i.."jailtime"
								jailtimeremainingsec = NPC(65).mapRegistry[regname]-os.time()
								jailtimeminutes = math.modf(jailtimeremainingsec / 60)
								if (jailtimeminutes < 0) then
									player:dialogSeq({t,""..prisoner_name_table2[i].." does not currently have a set sentence time."},1)
									newsentence=player:input("How many seconds would you like the sentence to be changed to? (Enter 0 to end sentence)")
									NPC(65).mapRegistry[regname]=os.time()+newsentence
								else
									player:dialogSeq({t,""..prisoner_name_table2[i].." currently has "..jailtimeminutes.." minutes remaining in their sentence."},1)
									newsentence=player:input("How many seconds would you like the sentence to be changed to? (Enter 0 to end sentence)")
									NPC(65).mapRegistry[regname]=os.time()+newsentence
								end
							end
						end

					elseif(menuOption=="Appoint Magistrate") then
						local nameofPlayer=player:input("Hello, Grand Magistrate.\n\nWho do you wish to appoint?")
						if(Player(nameofPlayer) == nil) then
							player:sendMinitext("You cannot appoint someone if they are not online.")
							return
						end
							if(string.lower(nameofPlayer)~=string.lower(player.name)) then
										if(Player(nameofPlayer).registry["magistrate"]>0) then
											player:dialogSeq({t,""..nameofPlayer.." is already a Magistrate!"})
										else
										Player(nameofPlayer):sendMinitext("You have been appointed as a Magistrate!")
										player:sendMinitext(""..nameofPlayer.." has been appointed a Magistrate.")
										Player(nameofPlayer).registry["magistrate"]=1
										Player(nameofPlayer):addLegend("Appointed Magistrate "..curT().."","magistrate",135,128)
										--Player(nameofPlayer).registry["board11write"]=1										
										end
							else
							player:dialogSeq({t,"You can not appoint yourself!"})
							end
					elseif(menuOption=="Appoint Grand Magistrate") then
						local nameofPlayer=player:input("Hello, GM.\n\nWho do you wish to appoint?")
						if(Player(nameofPlayer) == nil) then
							player:sendMinitext("You cannot appoint someone if they are not online.")
							return
						end
							if(string.lower(nameofPlayer)~=string.lower(player.name)) then
										if(Player(nameofPlayer).registry["magistrate"]>0) then
										Player(nameofPlayer):sendMinitext("You have been appointed as Grand Magistrate!")
										player:sendMinitext(""..nameofPlayer.." has been appointed Grand Magistrate.")
										Player(nameofPlayer).registry["magistrate"]=2
										Player(nameofPlayer):removeLegendbyName("magistrate")
										Player(nameofPlayer):addLegend("Appointed Grand Magistrate "..curT().."","magistrate",135,128)
										--Player(nameofPlayer).registry["board11write"]=1
										else
										player:dialogSeq({t,"You can not appoint a Grand Magistrate unless they already have Magistrate powers!"})						
										end
							else
							player:dialogSeq({t,"You can not appoint yourself!"})
							end
					elseif(menuOption=="Remove Magistrate") then
						player:dialogSeq({t,"Hello Grand Magistrate. This will allow you to remove a Magistrate from duty. Only proceed if you are certain of your decision."},1)
						local nameofPlayer=player:input("Which Magistrate needs his/her power removed?")
						if(Player(nameofPlayer) == nil) then
							player:sendMinitext("You cannot remove someone if they are not online.")
							return
						end
							if(string.lower(nameofPlayer)~=string.lower(player.name)) then
									if(Player(nameofPlayer).registry["magistrate"]>0) then
										Player(nameofPlayer).registry["magistrate"]=0
										Player(nameofPlayer):sendMinitext("You are no longer a Magistrate.")
										player:sendMinitext(""..nameofPlayer.." has been removed from duty.")
									end
									Player(nameofPlayer):removeLegendbyName("magistrate")
									--Player(nameofPlayer).registry["board11write"]=0	
							else
							player:dialogSeq({t,"You can not remove yourself!"})
							end
					end
		else
				if (player.registry["jailtime"] >= 1) then
					player:dialogSeq({t,"You are in jail!"},1)
				end
        end
    end)
}

han_warden = {
	click = async(function(player,npc)
			local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
            player.npcGraphic=t.graphic
			player.npcColor=t.color
			local optsj = {"About My Sentence", "Prisoner Jail Time"}

			local max=NPC(65).mapRegistry["prisonercount"]
			for x=1,max do
				if(NPC(65).mapRegistry["prisoner" .. x] == player.id) then
					local timeup = NPC(65).mapRegistry["prisoner"..x.."jailtime"]-os.time()
					if (timeup <= 0) then
					table.insert(optsj,"Leave Here")
					end
				end
			end


local choice=player:menuString2("What is it?",optsj)
if(choice=="Prisoner Jail Time") then
	local max=NPC(65).mapRegistry["prisonercount"]
	local prisoner_name_table={}
	local prisoner_name_table2={}
	local prisoner_jailtime_table={}
	local regname
	if max==0 then
		player:dialogSeq({"No prisoners are currently in jail."})
		return false
	end

	for x=1,max do
		regname="prisoner"..x..""
		table.insert(prisoner_name_table,NPC(65).mapRegistry[regname])
		regname="prisoner"..x.."jailtime"
		table.insert(prisoner_jailtime_table,NPC(65).mapRegistry[regname])
	end

	for i = 1, #prisoner_name_table do
		if (Player(prisoner_name_table[i]) ~= nil) then
		table.insert(prisoner_name_table2,Player(prisoner_name_table[i]).name)
		else
		table.insert(prisoner_name_table2,getOfflineID(prisoner_name_table[i]))
		end
	end
		--local temp=player:buy("This: "..max.." bank slots over a maximum of",prisoner_name_table,prisoner_jailtime_table,{},{})
		local listofprisoners=player:menuString2("Select a prisoner to view their remaining jail time.",prisoner_name_table2)
	for i = 1, #prisoner_name_table2 do
		if(listofprisoners==prisoner_name_table2[i]) then
			regname="prisoner"..i.."jailtime"
			jailtimeremainingsec = NPC(65).mapRegistry[regname]-os.time()
			jailtimeminutes = math.modf(jailtimeremainingsec / 60)
			if (jailtimeminutes < 0) then
				player:dialogSeq({"My records indicate that "..prisoner_name_table2[i].." does not currently have a set sentence time."})
			else
				player:dialogSeq({"My records indicate that "..prisoner_name_table2[i].." currently has "..jailtimeminutes.." minutes remaining in their sentence."})
			end
		end
	end
	elseif (choice=="Leave Here") then

								 						--NPC(65).mapRegistry["prisonercount"]=NPC(65).mapRegistry["prisonercount"]-1
								 						local max=NPC(65).mapRegistry["prisonercount"]
								 						for x=1,max do
								 							if(NPC(65).mapRegistry["prisoner" .. x] == player.id) then
																NPC(65).mapRegistry["prisoner" .. x]=0
																NPC(65).mapRegistry["prisoner" .. x .. "jailtime"]=0
															end
														end
            											player.mute = false
            											player.silence = false
            											han_warden.adjustnumbers(player, npc)
            											player:sendMinitext("You are free to go.")
														player.registry["jailtime"]=0
               											player:warp(39,16,5)	
elseif (choice=="About My Sentence") then
	player:dialogSeq({t,"You must remain here until your sentence has been served. Once your time is up, I will give you the option to (Leave). Do you have a problem with that?"},1)
end
end),

adjustnumbers = function(player, npc)
	local max=NPC(65).mapRegistry["prisonercount"]
	local y=0
	local x
	for x=1,max do
		if(NPC(65).mapRegistry["prisoner" .. x .. "jailtime"] == 0) then
			y=1
		end
		if(y>0) then
			NPC(65).mapRegistry["prisoner" .. x .. "jailtime"]=NPC(65).mapRegistry["prisoner" .. x+1 .. "jailtime"]
			NPC(65).mapRegistry["prisoner" .. x]=NPC(65).mapRegistry["prisoner" .. x+1]
		end
	end
	if(y>0) then
		NPC(65).mapRegistry["prisonercount"]=max-1
	end
end

}