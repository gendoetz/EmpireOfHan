shadow_walker = {
	click = async(function(player,npc)
		local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	    local opts = { }

		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0
		local classcheck=8
		table.insert(opts,"Bind")
		--table.insert(opts,"Shadow Items")
		table.insert(opts,"Learn Spell")
		table.insert(opts,"Forget Spell")
		--table.insert(opts,"Abandon")
		if(player.level==99) then
		table.insert(opts,"Path Adornments")
		end
		if(player.registry["subpathlevel"]>=2) then
			table.insert(opts,"Add Walker")
		end

		if(player.registry["subpathlevel"]==3) then
			table.insert(opts,"Add Guide")
			table.insert(opts,"Demote")
			table.insert(opts,"Step Down")
			--table.insert(opts,"Exile walker")
			--table.insert(opts,"Elder sage")
		end

		if(player.gmLevel == 99) then
			table.insert(opts,"Add Walker")
			table.insert(opts,"Add Guide")
			table.insert(opts,"Make Elder")
		end

		local menuOption=player:menuString("Hello, how may I help you?",opts)

			if(menuOption=="Shadow Items") then
				-- buy menu
			elseif(menuOption=="Bind") then
				local menuOptionBind=player:menuString("Do you wish to bind to here?",{"Yes", "No"})
					if(menuOptionBind=="Yes") then
						if (player.bind ~= 1) then
							player:sendMinitext("You cannot bind here.")
							return
						else
							player.registry["bindMap"] = player.m
							player.registry["bindX"] = player.x
							player.registry["bindY"] = player.y
							player:dialogSeq({t,"You are now bound here. The return spell will bring you to this location."},1)
						end
					elseif(menuOptionBind=="No") then
						player:dialogSeq({t,"So be it."},1)
					end
			elseif(menuOption=="Forget Spell") then
				player:forgetSpell(t)
			elseif(menuOption=="Learn Spell") then
				player:learnSpell_sub(t)
			elseif(menuOption=="Path Adornments") then
				if (player.quest["subitem"] == 0) then
					player:dialogSeq({t,"Congratulations young one; you have finally reached the highest insight!",
						t, "You are now ready to begin working towards our paths sacred treasures.."}, 1)
					player.quest["subitem"] = player.quest["subitem"] + 1
					subpathQuests_shadow.click(player,npc)
				elseif (player.quest["subitem"] == 1) then
					subpathQuests_shadow.click(player,npc)
				end
			elseif(menuOption=="Abandon") then
				if(player.class==classcheck) then
					if(player.registry["subpathlevel"]==3) then
						player:dialogSeq({t,"As the Elder, you cannot abandon your own path"})
						return
					end
					player.registry["subpathlevel"]=0
					player:warp(39,15,5)
					player.class=4
					player.registry["bindMap"] = player.m
					player.registry["bindX"] = player.x
					player.registry["bindY"] = player.y
					player:removeLegendbyName("subpathguide")
					player:sendStatus()
				end
			elseif(menuOption=="Exile walker" and player.class==classcheck and player.registry["subpathlevel"]==3) then
				player:dialogSeq({t,"Hello Elder, this will allow you to Exile one of your walkers."},1)
				local nameofPlayer=player:input("Who should be exiled?")
				if(string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end
				if(Player(nameofPlayer).registry["subpathlevel"]<=2 and Player(nameofPlayer).class==classcheck) then
					Player(nameofPlayer):sendMinitext("You have been exiled!")
					player:sendMinitext(""..nameofPlayer.." has been exiled.")
					Player(nameofPlayer).registry["subpathlevel"]=0
					Player(nameofPlayer):warp(39,15,5)
					Player(nameofPlayer).class=4
					Player(nameofPlayer).registry["bindMap"] = player.m
					Player(nameofPlayer).registry["bindX"] = player.x
					Player(nameofPlayer).registry["bindY"] = player.y
					Player(nameofPlayer):removeLegendbyName("subpathguide")
					Player(nameofPlayer):sendStatus()
				end
			--elseif(menuOption=="Elder sage" and player.class==classcheck and player.registry["subpathlevel"]==3) then
			--	player:dialogSeq({t,"Hello Elder, this tool will allow you to learn Elder sage."},1)
			--	player:addSpell("elder_sage")
			elseif(menuOption=="Add Walker" and ((player.class==classcheck and player.registry["subpathlevel"]>=2) or player.gmLevel == 99)) then
				local checkplayer = {}
				local check=0
				player:dialogSeq({t,"Hello, do you wish for me to assist you in adding a new walker?"},1)
				local nameofPlayer=player:input("Who should become one of your path?")
				if (string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end
				if (Player(nameofPlayer).class == 2 and Player(nameofPlayer).level >= 50) then
								--Player(nameofPlayer).registry["pathinviter"]=player.ID
								local pathinviter = player.ID
								shadow_walker.addtoPath(Player(nameofPlayer),npc,pathinviter)
					--Player(nameofPlayer).class = 12
					--Player(nameofPlayer):sendStatus()
				else
				player:dialogSeq({t,"They are not the correct path."})
				end

			elseif(menuOption=="Add Guide" and ((player.class==classcheck and player.registry["subpathlevel"]>=3) or player.gmLevel == 99)) then
				local checkplayer = {}
				local check=0
				player:dialogSeq({t,"Hello Elder, this will allow you to promote one of your walkers to a guide. The player must be present in the room."},1)
				local nameofPlayer=player:input("Who should become one of your guides?")
				if(string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end

				checkplayer=player:getObjectsInArea(BL_PC)
				if(#checkplayer>0) then
					for x=1,#checkplayer do
						if(string.lower(checkplayer[x].name)==string.lower(nameofPlayer)) then
							if(checkplayer[x].class~=classcheck) then
								player:dialogSeq({t,""..nameofPlayer.." does not walk your path."})
								return
							end
							if(checkplayer[x].registry["subpathlevel"]>=2) then
								player:dialogSeq({t,""..nameofPlayer.." is already a guide."})
								return
							end
							--Must Be level 99
							if(checkplayer[x].level ~= 99) then
								player:dialogSeq({t,""..nameofPlayer.." is not high enough level. Level 99 is required."})
								return
							end
							
							Player(nameofPlayer).registry["subpathlevel"]=2
							--Player(nameofPlayer).registry["boardname266"]=4
							--Player(nameofPlayer).registry["boardname267"]=4
							--Player(nameofPlayer).registry["board267write"]=1
							Player(nameofPlayer):removeLegendbyName("subpathguide")
							Player(nameofPlayer):addLegend("Guide of the Shadow path "..curT(), "subpathguide", 22, 128)
							Player(nameofPlayer):sendMinitext("You have been made a guide, congratulations!")
							player:sendMinitext(""..nameofPlayer.." has been ascended.")
							check=1
							return
						end
					end
					if(check==0) then
						player:dialogSeq({t,""..nameofPlayer.." is not around."})
						return
					end
				end



			elseif(menuOption=="Demote" and player.class==classcheck and player.registry["subpathlevel"]==3) then
				player:dialogSeq({t,"Hello Elder, this will allow you to demote one of your guides back to walker."},1)
				local nameofPlayer=player:input("Which guide should be demoted?")
				if(string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end
				if(Player(nameofPlayer).registry["subpathlevel"]>=2 and Player(nameofPlayer).class==classcheck) then
					Player(nameofPlayer):sendMinitext("Your guideship has been rescinded.")
					player:sendMinitext(""..nameofPlayer.." has been demoted.")
					Player(nameofPlayer).registry["subpathlevel"]=1
					--Player(nameofPlayer).registry["boardname266"]=0
					--Player(nameofPlayer).registry["boardname267"]=0
					--Player(nameofPlayer).registry["board267write"]=0
					Player(nameofPlayer):removeLegendbyName("subpathguide")
				end
			elseif(menuOption=="Step Down" and player.class==classcheck and player.registry["subpathlevel"]==3) then
				local checkplayer = {}
				local check=0
				player:dialogSeq({t,"Hello Elder, this will allow you to step down from your position and promote someone as the new Elder. The player must already be a guide and be in the room.", "Only proceed if you have absolutely sure of your decision."},1)
				local nameofPlayer=player:input("Who should become the next Elder?")
				if(string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end

				checkplayer=player:getObjectsInArea(BL_PC)
				
				if(#checkplayer>0) then
				
					for x=1,#checkplayer do
						if(string.lower(checkplayer[x].name)==string.lower(nameofPlayer)) then
							if(checkplayer[x].class~=classcheck) then
								player:dialogSeq({t,""..nameofPlayer.." does not walk your path."})
								return
							end
							if(checkplayer[x].registry["subpathlevel"]<2) then
								player:dialogSeq({t,""..nameofPlayer.." is not a guide."})
								return
							end
							
							Player(nameofPlayer).registry["subpathlevel"]=3
							--Player(nameofPlayer).registry["boardname266"]=3
							--Player(nameofPlayer).registry["boardname267"]=3
							--Player(nameofPlayer).registry["board267write"]=1
							--Player(nameofPlayer).registry["board266del"]=1
							--Player(nameofPlayer).registry["board267del"]=1
							Player(nameofPlayer):removeLegendbyName("subpathguide")
							Player(nameofPlayer):addLegend("Elder of the Shadow path "..curT(), "subpathguide", 22, 128)
							Player(nameofPlayer):sendMinitext("You have been made Elder, congratulations!")

							player.registry["subpathlevel"]=2
							--player.registry["boardname266"]=0
							--player.registry["boardname267"]=0
							--player.registry["board267write"]=0
							--player.registry["board266del"]=0
							--player.registry["board267del"]=0
							player:removeLegendbyName("subpathguide")
							player:addLegend("Guide of the Shadow path "..curT(), "subpathguide", 22, 128)
							--player:removeSpell("elder_sage")
							player:sendMinitext("It is done.")
							check=1
							return
						end
					end
					if(check==0) then
						player:dialogSeq({t,""..nameofPlayer.." is not around."})
						return
					end
				end
			elseif(menuOption=="Make Elder" and player.gmLevel==99) then
				local checkplayer = {}
				local check=0
				player:dialogSeq({t,"This will allow you to promote someone as the new Elder. The player must already be a guide and be in the room.", "Only proceed if you have absolutely sure of your decision."},1)
				local nameofPlayer=player:input("Who should become the next Elder?")
				if(string.lower(nameofPlayer)==string.lower(player.name)) then
					player:dialogSeq({t,"You cannot do that."})
					return
				end

				checkplayer=player:getObjectsInArea(BL_PC)
				
				if(#checkplayer>0) then
				
					for x=1,#checkplayer do
						if(string.lower(checkplayer[x].name)==string.lower(nameofPlayer)) then
							if(checkplayer[x].class~=classcheck) then
								player:dialogSeq({t,""..nameofPlayer.." does not walk your path."})
								return
							end
							if(checkplayer[x].registry["subpathlevel"]<2) then
								player:dialogSeq({t,""..nameofPlayer.." is not a guide."})
								return
							end
							
							Player(nameofPlayer).registry["subpathlevel"]=3
							--Player(nameofPlayer).registry["boardname266"]=3
							--Player(nameofPlayer).registry["boardname267"]=3
							--Player(nameofPlayer).registry["board267write"]=1
							--Player(nameofPlayer).registry["board266del"]=1
							--Player(nameofPlayer).registry["board267del"]=1
							Player(nameofPlayer):removeLegendbyName("subpathguide")
							Player(nameofPlayer):addLegend("Elder of the Shadow path "..curT(), "subpathguide", 22, 128)
							Player(nameofPlayer):sendMinitext("You have been made Elder, congratulations!")

							player.registry["subpathlevel"]=1
							--player.registry["boardname266"]=0
							--player.registry["boardname267"]=0
							--player.registry["board267write"]=0
							--player.registry["board266del"]=0
							--player.registry["board267del"]=0
							player:removeLegendbyName("subpathguide")
							--player:removeSpell("elder_sage")
							player:sendMinitext("It is done.")
							check=1
							return
						end
					end
					if(check==0) then
						player:dialogSeq({t,""..nameofPlayer.." is not around."})
						return
					end
				end
			end
	
        end),

addtoPath=async(function(player,npc,pathinviter)
			local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
			local opts = {}
			local check = {}
			local clannumber=1
			table.insert(opts,"Yes")
			table.insert(opts,"No")
            player.npcGraphic=t.graphic
			player.npcColor=t.color

			local choice=player:menuString2(""..Player(pathinviter).name.." would like to add you to their path, do you accept?",opts)
				if(choice=="No") then
					Player(pathinviter):dialogSeq({t,""..player.name.." has refused your offer."})
				elseif(choice=="Yes") then

						player:sendStatus()
						Player(pathinviter):sendMinitext(""..player.name.." has accepted and is now a member of the path.")
						player.class = 8
						player.registry["subpathlevel"] = 1
						player:sendStatus()
						player:sendMinitext("Congratulations.")
				end
	end),
}
