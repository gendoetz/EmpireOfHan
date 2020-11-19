the_imperial_legion1 = {
	click =async(function(player,npc)
		local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
		player.dialogType = 0
       	player.npcGraphic=t.graphic
		player.npcColor=t.color
		local promotionopts={}
		local clanfeatures = {}
		local opts = {}
		local clannumber=1
		table.insert(promotionopts,"Level 1 - No Special Priviledges")
		table.insert(promotionopts,"Level 2 - Add kindred, Grant Clan Title")
		table.insert(promotionopts,"Level 3 - Item banking")
		table.insert(promotionopts,"Level 4 - Money banking")
		table.insert(promotionopts,"Level 5 - Terminate Kindred")

		if(player.registry["clan"..clannumber.."kindredlevel"]>=0) then
				table.insert(opts,"Buy")
				table.insert(opts,"Clan History")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=1) then
				table.insert(opts,"Leave this clan")
				table.insert(opts,"View clan bank")
				table.insert(opts,"Add item to clan bank")
				table.insert(opts,"Add money to clan bank")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=2) then
				table.insert(opts,"Add Kindred")
				table.insert(opts,"Grant Clan Title")
				table.insert(opts,"Invite Visitor")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=3) then
				table.insert(opts,"Withdraw item from clan bank")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=4) then
				table.insert(opts,"Withdraw money from clan bank")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=5) then
				table.insert(opts,"Terminate kindred")
		end
		if(player.registry["clan"..clannumber.."kindredlevel"]>=6) then
				table.insert(opts,"Obtain Clan Key")
				table.insert(opts,"Destroy Clan Key")
				table.insert(opts,"Primogen Sage")
				table.insert(opts,"Clan features")
				table.insert(opts,"Set Kindred Level")
				table.insert(opts,"Step down")
		end
		if(player.gmLevel >= 98) then
				table.insert(opts,"Add Kindred")
				table.insert(opts,"Appoint Primogen")
				table.insert(opts,"Set Bank Slots")
		end

		table.insert(clanfeatures,"Clan bank slots")
		table.insert(clanfeatures,"Kindred Talisman Location")


		local menuOption=player:menuString("How may I help you?",opts)
			if(menuOption=="Buy") then
				player:buyExtend("What would you like to purchase?",{145})
			elseif(menuOption=="Clan History") then
				player:dialogSeq({t,"The Imperial Legion.\n\nHistory of the clan, submitted by the Primogen"})
			elseif(menuOption=="Leave this clan" and player.registry["clan"..clannumber.."kindredlevel"]>=1) then
					if(player.registry["clan"..clannumber.."kindredlevel"]>=6) then
						player:dialogSeq({t,"As Primogen, you may not leave your own clan."})
						return
					end
					if(player.clan==clannumber) then
						player:dialogSeq({t,"This tool allows you to leave this clan. Only proceed if you are certain of your decision."},1)
						local choice=player:menuString2("Are you certain you wish to terminate your kindredship ?",{"Yes","No"})
						if(choice=="Yes") then
							player.clan=0
							player.registry["clan"..clannumber.."kindredlevel"]=0
							player.clanTitle=""
							player:warp(9,3,6)
							player:sendMinitext("Farewell, then.")
						else
							player:dialogSeq({"Very well."})
						end
					else
						player:dialogSeq({t,"You are not part of this clan."})
					end
			elseif(menuOption=="Obtain Clan Key") then
						if(player:hasItem("il_clankey", 1) ~= true) then															
							player:sendMinitext("You receive a clan key.")
							player:addItem(144,1)
						else
							player:dialogSeq({t,"You already have a clan key"})
						end
			elseif(menuOption=="Destroy Clan Key") then
								player:removeItem(144,1)
			elseif(menuOption=="View clan bank" and player.registry["clan"..clannumber.."kindredlevel"]>=1) then
					player:clanViewBank()
			elseif(menuOption=="Add item to clan bank" and player.registry["clan"..clannumber.."kindredlevel"]>=1) then
					player:clanShowBankAdd()
			elseif(menuOption=="Add money to clan bank" and player.registry["clan"..clannumber.."kindredlevel"]>=1) then
					player:clanBankAddMoney()
			elseif(menuOption=="Add Kindred" and (player.registry["clan"..clannumber.."kindredlevel"]>=2 or player.gmLevel >= 98)) then
					player:dialogSeq({t,"This tool allows you to add a Kindred to the clan. The selected player must not be currently part of any clan."},1)
					name=player:input("Who do you wish to add as a Kindred?")
						if(Player(name) == nil) then
							player:sendMinitext("They are not online.")
							return
						end
					if(string.lower(name)~=string.lower(player.name)) then
							if(Player(name).clan==0) then
								Player(name).registry["kindredinviter"]=player.ID
								Player(name).registry["claninvitenumber"]=clannumber
								the_imperial_legion1.addKindred(Player(name),npc)
							elseif(Player(name).clan==clannumber) then
								player:dialogSeq({t,""..name.." is already part of your clan!"})
							else
								player:dialogSeq({t,""..name.." is already part of another clan!"})
							end
					else
						player:dialogSeq({"You can not invite yourself!"})
					end
			elseif(menuOption=="Grant Clan Title" and player.registry["clan"..clannumber.."kindredlevel"]>=2) then
					player:dialogSeq({t,"This tool allows you to Grant a Clan Title to one of your Kindreds. The maximal length allowed is 18 characters. Click next to proceed."},1) 
					local name=player:input("Who shall you grant a title to?")
					if(Player(name) == nil) then
							player:sendMinitext("They are not online.")
							return
					end
					if(Player(name).registry["clan"..clannumber.."kindredlevel"]==0) then
						player:dialogSeq({t,""..name.." is not part of your clan!"})
						return
					end
					local title=player:input("What shall be the new title?")
					if(string.len(title)>18) then
							player:dialogSeq({t,"This title is too long."})
							return
					end
					--if(string.find(string.lower(title),"'")) then
					--		player:dialogSeq({t,"You may not use ' in your titles."})
					--		return
					--end
					if(Player(name) ~= nil) then
						Player(name).clanTitle=title
						Player(name):sendMinitext("You have been granted a new clan title by "..player.name..".")
						player:sendMinitext("It is done.")
					else
						player:sendMinitext("They are not online.")
						return
					end
			elseif(menuOption=="Invite Visitor" and player.registry["clan"..clannumber.."kindredlevel"]>=2) then
					player:dialogSeq({t,"This tool will allow you to invite a non-kindred into the hall.  Please make sure you have permission to do so."},1) 
					local name=player:input("Who will be invited?")
					if(Player(name) == nil) then
							player:sendMinitext("They are not online.")
							return
					end
					if(Player(name).m ~= 15) then
						player:sendMinitext("Player must be in Han to invite.")
						return
					end
					if (Player(name).registry["jailtime"] ~= 0) then
						player:dialogSeq({t,"This person is currently serving jail time, that would be very unwise."},1)
						return
					end
					Player(name).registry["kindredinviter"]=player.ID
					the_imperial_legion1.invitevisit(Player(name),npc)

			elseif(menuOption=="Withdraw item from clan bank" and player.registry["clan"..clannumber.."kindredlevel"]>=3) then
					player:clanShowBank()
			elseif(menuOption=="Withdraw money from clan bank" and player.registry["clan"..clannumber.."kindredlevel"]>=4) then
					player:clanBankWithdrawMoney()
			elseif(menuOption=="Terminate kindred" and player.registry["clan"..clannumber.."kindredlevel"]>=5) then
					player:dialogSeq({t,"This tool allows you to terminate a Kindred. Only proceed if you are certain of your decision."},1)
					local name=player:input("Who shall be expelled from the Clan?")
					if(Player(name) == nil) then
							player:sendMinitext("They are not online.")
							return
					end
					if(Player(name).clan~=clannumber) then
							player:dialogSeq({t,""..name.." isn't part of your clan!"})
					end
					if(Player(name).registry["clan"..clannumber.."kindredlevel"]>=player.registry["clan"..clannumber.."kindredlevel"] and player.gmLevel ~= 99) then
							player:dialogSeq({t,"You may not terminate an equal or higher ranking officer."})
							return
					end
					Player(name).registry["clan"..clannumber.."kindredlevel"]=0
					Player(name).registry["clanmap"]=0
					Player(name).clanTitle=""
					Player(name).clan=0
					Player(name):removeItem(144,1)
					Player(name):sendMinitext(""..player.name.." expells you from the clan.")
					Player(name):removeLegendbyName("primogen")
					Player(name):removeSpell("primogen_sage")
					player:sendMinitext(""..name.." has been terminated.")
			elseif(menuOption=="Primogen Sage" and player.registry["clan"..clannumber.."kindredlevel"]>=6) then
					player:dialogSeq({t,"Primogen, this tool allows you to learn your Primogen Sage. Remember that it is strictly forbidden to use it for personnal purposes."},1)
					player:addSpell("primogen_sage")
					player:sendMinitext("Your mind expands as you learn Primogen Sage")
			elseif(menuOption=="Clan features" and player.registry["clan"..clannumber.."kindredlevel"]>=6) then
					player:dialogSeq({t,"Primogen, this tool allows you to buy features for your clan. Click next to proceed."},1)
					local choice=player:menuString2("Which feature are you interested in?",clanfeatures)
						if(choice=="Clan bank slots") then
							if(player.mapRegistry["clanbankmaxslots"]>=200) then
								player:dialogSeq({t,"Your clan is currently equipped with 200 slots. You may not purchase any more."})
								return
							end
							player:dialogSeq({t,"Your clan is currently equipped with "..player.mapRegistry["clanbankmaxslots"].." bank slots. Each additional slot costs 50.000 coins and you can buy up to 200 slots."},1)
							local clanbankslots=player:menuString2("Do you wish to purchase one clan bank slot for 50.000 coins?",{"Yes","No"})
								if(clanbankslots=="Yes") then
									if(player.money>=50000) then
										player.mapRegistry["clanbankmaxslots"]=player.mapRegistry["clanbankmaxslots"]+1
										player.money=player.money-50000
										--saveMapRegistry(player.m)
										player:sendStatus()
										player:dialogSeq({t,"Your clan is now equipped with a total of "..player.mapRegistry["clanbankmaxslots"].." bank slots."})
									else
										player:dialogSeq({t,"You do not have enough money."})
									end
								end
						elseif (choice=="Kindred Talisman Location") then
							player:dialogSeq({t,"Using this function will change the location of where you appear when using a Kindred Talismon."},1)
							local clanbankslots=player:menuString2("Do you wish to change the warp location to where you are standing for 5,000 coins?",{"Yes","No"})
								if(clanbankslots=="Yes") then
									if(player.money>=5000) then
										player.mapRegistry["clanwarpx"] = player.x
										player.mapRegistry["clanwarpy"] = player.y
										player.money=player.money-5000
										--saveMapRegistry(player.m)
										player:sendStatus()
										player:dialogSeq({t,"Your clan's Kindred Talisman return location has been set."})
									else
										player:dialogSeq({t,"You do not have enough money."})
									end
								end
						else

						--[[

						
						More coming later

					
						]]--


						end

			elseif(menuOption=="Set Kindred Level" and player.registry["clan"..clannumber.."kindredlevel"]>=6) then
					player:dialogSeq({t,"Primogen, this tool allows you to set the level of a Kindred within your clan. Proceed with caution."},1)
					local name=player:input("Which Kindred needs his level adjusted?")
					if(Player(name) == nil) then
							player:sendMinitext("They are not online.")
							return
					end
					if(name==player.name) then
						player:dialogSeq({t,"As Primogen, you may not adjust your own Kindred level."})
						return
					end
					local choice=player:menuString2("Which level shall "..name.." be? ((All levels inherits the previous level powers. Only the new powers are indicated))",promotionopts)
					if(Player(name).clan~=clannumber) then
							player:dialogSeq({t,""..name.." is not a part of your clan."})
							return
					end
					if(choice=="Level 1 - No Special Priviledges") then
							if(Player(name) ~= nil) then
							Player(name).registry["clan"..clannumber.."kindredlevel"]=1
							Player(name):sendMinitext("You are now a level 1 Kindred")
							player:sendMinitext(""..name.." is now a level 1 Kindred.")
							else
								player:sendMinitext("They are not online.")
								return
							end
					elseif(choice=="Level 2 - Add kindred, Grant Clan Title") then
						if(Player(name) ~= nil) then
							Player(name).registry["clan"..clannumber.."kindredlevel"]=2
							Player(name):sendMinitext("You are now a level 2 Kindred")
							player:sendMinitext(""..name.." is now a level 2 Kindred.")
						else
								player:sendMinitext("They are not online.")
								return
							end
					elseif(choice=="Level 3 - Item banking") then
						if(Player(name) ~= nil) then
							Player(name).registry["clan"..clannumber.."kindredlevel"]=3
							Player(name):sendMinitext("You are now a level 3 Kindred")
							player:sendMinitext(""..name.." is now a level 3 Kindred.")
						else
								player:sendMinitext("They are not online.")
								return
							end
					elseif(choice=="Level 4 - Money banking") then
						if(Player(name) ~= nil) then
							Player(name).registry["clan"..clannumber.."kindredlevel"]=4
							Player(name):sendMinitext("You are now a level 4 Kindred")
							player:sendMinitext(""..name.." is now a level 4 Kindred.")
						else
								player:sendMinitext("They are not online.")
								return
							end
					elseif(choice=="Level 5 - Terminate Kindred") then
						if(Player(name) ~= nil) then
							Player(name).registry["clan"..clannumber.."kindredlevel"]=5
							Player(name):sendMinitext("You are now a level 5 Kindred")
							player:sendMinitext(""..name.." is now a level 5 Kindred.")
						else
								player:sendMinitext("They are not online.")
								return
							end
					end
			elseif(menuOption=="Step down" and player.registry["clan"..clannumber.."kindredlevel"]>=6) then
					player:dialogSeq({t,"Primogen, this tool allows you to step down from your position. Only proceed if you are -ABSOLUTELY- certain of your decision."},1)
						local nuisance= { }
						local w=0
						local nameofPlayer=player:input("Who shall become the new Primogen?")
						if(nameofPlayer~=player.name) then
							for x=-20,20 do
								for y=-20,20 do
									nuisance=player:getObjectsInCell(player.m,player.x+x,player.y+y,BL_PC)
									if(#nuisance>0) then
										for z=1,#nuisance do
								 			if(nuisance[z].name==nameofPlayer and nuisance[z].clan==clannumber) then
												Player(nameofPlayer):sendMinitext(""..player.name.." has made you the new Primogen. Congratulations.")
												player:sendMinitext(""..nameofPlayer.." is now the new Primogen")
												Player(nameofPlayer):addLegend("High Commander of the Imperial Legion. "..curT().."","primogen",7,128)
												Player(nameofPlayer).registry["clan"..clannumber.."kindredlevel"]=6
												player:removeLegendbyName("primogen")
												player:removeSpell("primogen_sage")
												player:removeItem(144,1)
												player.registry["clan"..clannumber.."kindredlevel"]=1
												w=1
											end
										end
									end		
								end
							end
						else
							player:dialogSeq({t,"You can not do that."})
						end
						if(w==0) then
							player:dialogSeq({t,""..nameofPlayer.." isn't around or isn't a part of your clan!"})
						end
				elseif(menuOption=="Appoint Primogen" and player.gmLevel >= 98) then
					player:dialogSeq({t,"Proceed only if you must appoint a new Primogen and the previous Primogen's powers have been removed."},1)
						local nuisance= { }
						local w=0
						local nameofPlayer=player:input("Who shall become the new Primogen?")
						if(nameofPlayer~=player.name) then
							for x=-20,20 do
								for y=-20,20 do
									nuisance=player:getObjectsInCell(player.m,player.x+x,player.y+y,BL_PC)
									if(#nuisance>0) then
										for z=1,#nuisance do
								 			if(nuisance[z].name==nameofPlayer and nuisance[z].clan==clannumber) then
												Player(nameofPlayer):sendMinitext(""..player.name.." has made you the new Primogen. Congratulations.")
												player:sendMinitext(""..nameofPlayer.." is now the new Primogen")
												Player(nameofPlayer):addLegend("Primogen of the Imperial Legion. "..curT().."","primogen",7,128)
												Player(nameofPlayer).registry["clan"..clannumber.."kindredlevel"]=6
												w=1
											end
										end
									end		
								end
							end
						else
							player:dialogSeq({t,"You can not do that."})
						end
						if(w==0) then
							player:dialogSeq({t,""..nameofPlayer.." isn't around or isn't a part of your clan!"})
						end
				elseif(menuOption=="Set Bank Slots" and player.gmLevel >= 98) then
					player:dialogSeq({t,"You can only use this option to initially set a clan's bank slots to 15. Currently the clan has "..player.mapRegistry["clanbankmaxslots"].." bank slots."},1)
									if (player.mapRegistry["clanbankmaxslots"] <= 14) then
										player.mapRegistry["clanbankmaxslots"] = 15
										player:sendStatus()
										player:dialogSeq({t,"This clan is now equipped with a total of "..player.mapRegistry["clanbankmaxslots"].." bank slots."})
									else
										player:dialogSeq({t,"You cannot use this option once the clan has begun to purchase additional slots past 15."})
									end

			end
					
			
		
		
		



	end),

	addKindred=async(function(player,npc)

			local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
			local opts = {}
			local check = {}
			local clannumber=1
			table.insert(opts,"Yes")
			table.insert(opts,"No")
            player.npcGraphic=t.graphic
			player.npcColor=t.color

			local choice=player:menuString2(""..Player(player.registry["kindredinviter"]).name.." would like to make you a kindred of the Imperial Legion, do you accept?",opts)
				if(choice=="No") then
					Player(player.registry["kindredinviter"]):dialogSeq({t,""..player.name.." has refused your offer."})
				elseif(choice=="Yes") then
						player.clan = clannumber
						player.registry["clan"..player.clan.."kindredlevel"]=1
						player.registry["clannpcmap"]=npc.id
						player:sendStatus()
						Player(player.registry["kindredinviter"]):sendMinitext(""..player.name.." has accepted your offer and is now a kindred of this clan.")
						player:sendMinitext("You are now a Kindred of the Imperial Legion.")
				end




	end),

	invitevisit=async(function(player,npc)

			local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
			local opts = {}
			local check = {}
			local clannumber=1
			table.insert(opts,"Yes")
			table.insert(opts,"No")
            player.npcGraphic=t.graphic
			player.npcColor=t.color

			local choice=player:menuString2(""..Player(player.registry["kindredinviter"]).name.." would like to invite you to visit their clan hall, do you accept?",opts)
				if(choice=="No") then
					Player(player.registry["kindredinviter"]):dialogSeq({t,""..player.name.." has refused your offer."})
				elseif(choice=="Yes") then
						canAmbush(player, Player(player.registry["kindredinviter"]))
				end
	end)
}