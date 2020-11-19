host_master = {
	click = async(function(player,npc)
		local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	        local opts = { }
	        local dyes = { }

                player.npcGraphic=t.graphic
			    player.npcColor=t.color
			    player.dialogType = 0

	if (player.state == 1) then
		player.state = 0
		player.health = player.maxHealth
		player.magic = player.maxMagic
		player:updateState()
		player:sendStatus()
		return
	end

			      	if(player.registry["carnagehost"]==1) then
					if(player.armorColor==7020) then
					table.insert(opts,"Obtain Host Key")
					table.insert(opts,"Destroy Host Key")
					end
			      	end
			      	if(player.registry["carnagehost"]==3 or player.gmLevel == 99) then
					if(player.armorColor==7020) then
					table.insert(opts,"Obtain Host Key")
					table.insert(opts,"Destroy Host Key")
					end
					table.insert(opts,"Grant Host Powers")
					table.insert(opts,"Remove Host Powers")
					table.insert(opts,"Step Down")
					table.insert(opts,"Highlight arena board post")
			      	end
				if(player.registry["carnagehost"]>=1 or player.gmLevel == 99) then
					table.insert(opts,"Host Dye")
					table.insert(opts,"Host Sage")
					table.insert(opts,"Host Warps")
					table.insert(opts,"Nuisance")
					table.insert(opts,"Yowls")
				end
					table.insert(opts,"Read Arena Board")
				table.insert(opts,"Regular dyes")
			    table.insert(opts,"Bleach my clothes")
				table.insert(dyes,"Blue")
				table.insert(dyes,"White")
				table.insert(dyes,"Black")
				table.insert(dyes,"Red")

			    	local menuOption=player:menuString("Hello, "..player.name..", how may I help you?",opts)
					
					if(menuOption=="Obtain Host Key") then
						if(player:hasItem("host_key1", 1) ~= true) then															
							player:sendMinitext("You receive a Host Key.")
							player:addItem(62,1)
							
						else
							player:dialogSeq({t,"You already have a Host Key"})
						end
					elseif(menuOption=="Destroy Host Key") then
								player:removeItem(62,1)
					elseif(menuOption=="Host Warps") then
						local choices = {}
						table.insert(choices,"Stone Arena")
						table.insert(choices,"Tower Battle Barracks")
						table.insert(choices,"Carnage Barracks")
						table.insert(choices,"Elixir Hall")
						table.insert(choices,"Host Den")
						--table.insert(choices,"Prize Room")
						local choice=player:menuString2("Where to?",choices)
						if(choice=="Stone Arena") then
							player:warp(7000,18,13)
						elseif(choice=="Carnage Barracks") then
							player:warp(7005,13,16)
						elseif(choice=="Tower Battle Barracks") then
							player:warp(7001,13,16)
						elseif(choice=="Elixir Hall") then
							player:warp(7006,14,7)
						elseif(choice=="Entrance Room") then
							player:warp(7002,7,7)
						elseif(choice=="Host Den") then
							player:warp(7002,7,7)
						elseif(choice=="Prize Room") then
							player:warp(7003,6,10)
						end
					elseif(menuOption=="Bleach my clothes") then
							player:dialogSeq({t,"I can bleach your clothes for 10 coins if you would like."},1)
							if(player.money>=10) then
								player.money=player.money-10
								player.armorColor=0
								player:sendStatus()
								player:updateState()
								player:dialogSeq({t,"There, it is done."})
							else
							player:dialogSeq({t,"You do not have enough money."})
							end
					elseif(menuOption=="Regular dyes") then
							player:dialogSeq({t,"Hello there, I can dye your clothes for battle.","It will cost you 50 coins."},1)
							local choice=player:menuString2("Which dye would you like applied to your clothes?",dyes)
							if(player.money>=50) then
								if(choice=="White") then
									player.money=player.money-50
									player.armorColor=11
									player:sendStatus()
									player:updateState()
									player:dialogSeq({t,"It is done."})
								elseif(choice=="Red") then
									player.money=player.money-50
									player.armorColor=31
									player:sendStatus()
									player:updateState()
									player:dialogSeq({t,"It is done."})
								elseif(choice=="Black") then
									player.money=player.money-50
									player.armorColor=10
									player:sendStatus()
									player:updateState()
									player:dialogSeq({t,"It is done."})
								elseif(choice=="Blue") then
									player.money=player.money-50
									player.armorColor=17
									player:sendStatus()
									player:updateState()
									player:dialogSeq({t,"It is done."})
								end
							else
							player:dialogSeq({t,"You do not have enough money."})
							end
					elseif(menuOption=="Highlight arena board post" and player.registry["carnagehost"]==3) then
							player:dialogSeq({t,"Good day Headmaster.\n\nThis tool will let you highlight a post from the arena board."},1)
							local postNumber=tonumber(player:input("Which post do you want to highlight? ((Enter post number))"))
							local choice=player:menuString2("Headmaster, Which applies?",{"Normal Status","Highlighted Status"})
							if(choice=="Normal Status") then
								setPostColor(270,postNumber,0)	
								player:dialogSeq({t,"It is done"})
							elseif(choice=="Highlighted Status") then
								setPostColor(270,postNumber,1)
								player:dialogSeq({t,"It is done"})
							end
					elseif(menuOption=="Yowls" and (player.registry["carnagehost"]>0 or player.gmLevel == 99)) then
							local yowlstyle = {}
							local yowlchoice = {}

							table.insert(yowlstyle,"Carnage")
							table.insert(yowlstyle,"Elixir war")
							table.insert(yowlstyle,"Tower Battle")
							table.insert(yowlstyle,"Events")
							table.insert(yowlstyle,"Disregard Carnage yowls")

							table.insert(yowlchoice,"Doors are opening")
							table.insert(yowlchoice,"Doors close in 5 minutes")
							table.insert(yowlchoice,"Doors are closed")

							local choice=player:menuString2("Hello Carnage Host, Which applies?",yowlstyle)

								if(choice=="Events") then
									player:dialogSeq({t,"Carnage Host, you are about to broadcast for the entire server an invitation to read the Events board. Press next to Proceed."},1)
									player:broadcast(-1,"Host "..player.name.." invites you to read the Events board. ((Press B))")
									return
								elseif(choice=="Disregard Carnage yowls") then
									player:dialogSeq({t,"Carnage Host, you are about to broadcast for the entire server to disregard the latest yowls. Press next to Proceed."},1)
									player:broadcast(-1,"Host "..player.name.." asks you to disregard the latest yowls.")
									return
								elseif(choice=="Tower Battle") then
									local spec=player:menuString2("Which applies?",yowlchoice)
										if(spec=="Doors are opening") then
											player:broadcast(-1,"Tower Battle entrance opening in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors close in 5 minutes") then
											player:broadcast(-1,"Tower Battle entrance will be closing in 5 minutes in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors are closed") then
											player:broadcast(-1,"Tower Battle entrance now closed.")
											player:broadcast(-1,"-- Host "..player.name)
										end
								elseif(choice=="Carnage") then
									local spec=player:menuString2("Which applies?",yowlchoice)
										if(spec=="Doors are opening") then
											player:broadcast(-1,"Carnage entrance opening in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors close in 5 minutes") then
											player:broadcast(-1,"Carnage entrance will be closing in 5 minutes in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors are closed") then
											player:broadcast(-1,"Carnage entrance now closed.")
											player:broadcast(-1,"-- Host "..player.name)
										end
								elseif(choice=="Elixir war") then
									local spec=player:menuString2("Which applies?",yowlchoice)
										if(spec=="Doors are opening") then
											player:broadcast(-1,"Elixir war entrance opening in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors close in 5 minutes") then
											player:broadcast(-1,"Elixir war entrance will be closing in 5 minutes in the Stone Arena ((93, 26)) North Gate: Han.")
											player:broadcast(-1,"-- Host "..player.name)
										elseif(spec=="Doors are closed") then
											player:broadcast(-1,"Elixir war entrance now closed.")
											player:broadcast(-1,"-- Host "..player.name)
										end
								end
					elseif(menuOption=="Grant Host Powers" and (player.registry["carnagehost"]==3 or player.gmLevel == 99))	then
					local nameofPlayer=player:input("Hello, Headmaster.\n\nWho do you wish to grant host powers?")
					local hire = Player(nameofPlayer)
						if(hire ~= nil) then
							if (hire.m >= 7000 and hire.m <= 7200) then
										if(Player(nameofPlayer).registry["carnagehost"]>0) then
											player:dialogSeq({t,""..nameofPlayer.." is already a host!"})
										else
										Player(nameofPlayer):sendMinitext("You are now a host!")
										player:sendMinitext(""..nameofPlayer.." has been granted powers.")
										Player(nameofPlayer).registry["carnagehost"]=1
										Player(nameofPlayer):addLegend(" Host of arena battles. "..curT(), "carnagehost",71,128)
										end
										Player(nameofPlayer):warp(7002,7,7)
							else
								player:sendMinitext("They must be on an arena map to be given powers.")
							end
						else
							player:sendMinitext("They must be on an arena map to be given powers.")
						end
					elseif(menuOption=="Remove Host Powers") then
						player:dialogSeq({t,"Hello Headmaster. This will allow you to remove a host from duty. Only proceed if you are certain of your decision."},1)
						local nameofPlayer=player:input("Which host needs their power removed?")
							if(Player(nameofPlayer).name ~= player.name) then
									if(Player(nameofPlayer).registry["carnagehost"]>0) then
										Player(nameofPlayer).registry["carnagehost"]=0
										Player(nameofPlayer):sendMinitext("You are no longer a host.")
										player:sendMinitext(""..nameofPlayer.." has had their powers removed.")
									end
									Player(nameofPlayer):removeItem(62,1)
									Player(nameofPlayer):removeLegendbyName("carnagehost")
									if(Player(nameofPlayer).armorColor==7020) then
										Player(nameofPlayer).armorColor=0
										Player(nameofPlayer):sendStatus()
										Player(nameofPlayer):updateState()
									end
							else
								player:dialogSeq({t,"You can not remove your own powers!"})
							end
					elseif(menuOption=="Step Down") then
						local nuisance= { }
						local w=0
						player:dialogSeq({t,"Hello Headmaster. This will allow you to step down of your position and promote a new Headmaster. Only proceed if you are -ABSOLUTELY- certain of your decision."},1)

						local nameofPlayer=player:input("Which host shall become the new Headmaster?")
						local headmaster = Player(nameofPlayer)
						if(headmaster ~= nil) then
							if (headmaster.m >= 7000 and headmaster.m <= 7200) then
										if(Player(nameofPlayer).registry["carnagehost"]>0) then
											Player(nameofPlayer):sendMinitext(""..player.name.." has made you the new Headmaster. Congratulations.")
											player:sendMinitext(""..nameofPlayer.." is now the new Headmaster.")
											Player(nameofPlayer):removeLegendbyName("carnagehost")
											Player(nameofPlayer):addLegend("Headmaster of arena battles. "..curT(), "carnagehost",71,128)
											Player(nameofPlayer).registry["carnagehost"]=3
											player:removeLegendbyName("carnagehost")
											player:addLegend("Host of arena battles. "..curT(), "carnagehost",71,128)
											player.registry["carnagehost"]=1
										else
										player:dialogSeq({t,"The player you choose needs to be a host in order to be promoted to Headmaster."},1)
										end
							else
								player:sendMinitext("They must be on an arena map to be promoted.")
							end
						else
							player:sendMinitext("They must be on an arena map to be promoted.")
						end								
     				elseif(menuOption=="Host Dye" and player.registry["dyesaved"]==0) then
						player.registry["dyesaved"]=1
						player.registry["savedye"]=player.armorColor
						player.armorColor=7020
						player:updateState()
						player:dialogSeq({t,"Your dye has been saved."})

					elseif(menuOption=="Host Dye" and player.registry["dyesaved"]==1) then
						player.registry["dyesaved"]=0
						player.armorColor=player.registry["savedye"]
						player:updateState()
						player:dialogSeq({t,"Your dye has been restored."})

					elseif(menuOption=="Host Sage") then
						player:dialogSeq({t,"In case you have lost your host sage spell, this tool allows you to relearn it, press next to proceed."},1)
						player:addSpell("host_sage")
					elseif(menuOption=="Read Arena Board") then
						player:showBoard(270)
					elseif(menuOption=="Nuisance") then
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
					end
        end)
}

arena_play = {
click = async(function(player,npc)
	local npcGraphics = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
	local menuOptions = {}

	player.npcGraphic = npcGraphics.graphic
	player.npcColor = npcGraphics.color
	player.dialogType = 0

	table.insert(menuOptions, "Observe")
	table.insert(menuOptions, "Resurrect")
	table.insert(menuOptions, "Battle Resilience")
	table.insert(menuOptions, "Resurrect & Resilience")

	local choice = player:menuString("Which will you do?", menuOptions)
		if(choice == "Observe") then
			if (player.state == 0) then
				player:removeHealthWithoutDamageNumbers(player.maxHealth, 0)
			end
		elseif (choice == "Resurrect") then
			if (player.state == 1) then
				player.state = 0
				player.health = player.maxHealth
				player.magic = player.maxMagic
				player:updateState()
				player:sendStatus()
			end
		elseif (choice == "Battle Resilience") then
			if (player.state == 0) then
				carnage_resil.cast(player)
			end
		elseif (choice == "Resurrect & Resilience") then
			if (player.state == 1) then
				player.state = 0
				player.health = player.maxHealth
				player.magic = player.maxMagic
				carnage_resil.cast(player)
				player:updateState()
				player:sendStatus()
			end
		end
end)
}