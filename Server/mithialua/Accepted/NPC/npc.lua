f1npc = {
click = async(function(player,npc)
	local optsuser= {}
	--local dialog = getDialog(player, "f1npc1")
	if (player.gmLevel==99) then 
		dialog="Hello great one! How may I help you?"
	else
		dialog="Hello. How may I help you?"
	end
	local t={graphic=convertGraphic(838,"monster"),color=0}
	
	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0
	
	opts={}
	table.insert(opts,"Silver thread")
	table.insert(opts,"Select Title")

	--Carnage Region Exit
	if (player.region == 5 ) then
		table.insert(opts,"Leave Event")
	end

	--table.insert(opts,"Item Information")
	
	--if ((player:staff("pm") > 0) or (player:staff("map") > 0) or (player:staff("lore") > 0) or (player:staff("script") > 0)) then
	--	table.insert(opts,"Dev Team")
	--end
	
	--[[if (player.class == 0 and player.level <= 10) then
		table.insert(opts, "Train Stats")
	end
	if (player.level > 5) then
		table.insert(opts, "Reset")
	end]]
	--table.insert(opts, "Character Info")
	table.insert(opts, "Set AFK Message")
	table.insert(opts, "Password Recovery")

	if (player.level <= 10) then
		if (player.registry["playerRefID"] == 0) then
			table.insert(opts, "Referral Code")
		end
	end
	--table.insert(opts,"Randomizer")
	--table.insert(opts,"Userpages settings")
	table.insert(optsuser,"Yes")
	table.insert(optsuser,"No")
	
	if (player.gmLevel >= 1) then
		table.insert(opts,"GM Tools")
	end
	
	if(player.registry["constable"]>0) then
		table.insert(opts,"Constable office warp")
		table.insert(opts,"Remove Disruption")
	end
	
	if(player.registry["carnagehost"]>0 or player.gmLevel >= 1) then
		table.insert(opts,"Event Host Warp")
	end

	if(player.registry["magistrate"] >= 1 or player.gmLevel >= 1) then
		table.insert(opts,"Magistrate Chambers")
		table.insert(opts,"Emergency Jailing")
	end
	
	--table.insert(opts, "What's my TNL?")
	
	--if(player.level>5) then
	--	table.insert(opts,"Crafting interface")
	--end

	menuOption=player:menuString(dialog,opts)

	if menuOption == "Dev Team" then
		dev.f1click(player, npc)
	elseif menuOption=="Select Title" then
		player:dialogSeq({t, "You may choose a title based on your accomplishments in game."}, 1)
		local title_table = {}

		if ((player.registry["carnageWins"] + player.registry["towerbattleWins"] + player.registry["elixirWins"]) >= 20) then
			table.insert(title_table,"Combatant")
		end
		if (player.level == 99) then
			table.insert(title_table,"The Prominent")
		end
		if (player.registry["totem_faith"] > 150) then
			table.insert(title_table,"Ascendant")
		end
		if (player.registry["bountytotal"] > 25) then
			table.insert(title_table,"Mercenary")
		end
		if (player.registry["imperial_standing"] > 50) then
			table.insert(title_table,"Imperialist")
		end
		if (player.registry["minor_questa_compTotal"] > 30) then
			table.insert(title_table,"Inquisitor")
		end
		if (player:hasItem("acorn", 100) == true) then
			table.insert(title_table,"The Nut Collector")
		end
		if (player:hasItem("leg_flameb", 1) == true) then
			table.insert(title_table,"Legendary")
		end
		if (player.quest["H_deadpeople2"] == 4) then
			table.insert(title_table,"Ghost Whisperer")
		end
		if (player.quest["roof_hole"] == 2) then
			table.insert(title_table,"The Handyman")
		end
		if (player.quest["sketchy_shipment"] == 5) then
			table.insert(title_table,"The Temptress")
		end
		if (player.quest["spec_deliv"] == 4) then
			table.insert(title_table,"Wolfsbane")
		end
		if (player.quest["spirit_rip"] == 2) then
			table.insert(title_table,"Spirit Medium")
		end
		if (player:hasItem("wicked_skull_staff", 1) == true) then
			table.insert(title_table,"The Wicked")
		end
		if (player:hasItem("wedding_tux", 1) == true) then
			table.insert(title_table,"The Dapper")
		end
		if (player:hasItem("wedding_dress", 1) == true) then
			table.insert(title_table,"The Beautiful")
		end
		if (player.baseClass == 1) then
			table.insert(title_table,"The Berserker")
		end
		if (player.baseClass == 2) then
			table.insert(title_table,"The Assassin")
		end
		if (player.baseClass == 3) then
			table.insert(title_table,"The Magus")
		end
		if (player.baseClass == 4) then
			table.insert(title_table,"The Restorer")
		end
		if(player.quest["path_choice_quest"] == 8) then
			table.insert(title_table,"Pinyan Protector")
		end
		table.insert(title_table,"Remove Title")

		local choice = player:menuString("Which title will you wear?", title_table)
		if (choice ~= "Remove Title") then
			player.title = choice
		elseif (choice == "Remove Title") then
			player.title = ""
		end
		player:updateState()

	elseif menuOption == "GM Tools" then
		gm_npc.f1click(player, npc)
	elseif menuOption == "Password Recovery" then
		if (player.email == "") then
			emailcheck = "Email not set"
		end
		player:dialogSeq({t, "If you were to ever forget your character's password you can set an Email that is authorized to grant password change authority."}, 1)
		if (player.email == "") then
			player:dialogSeq({t, "You have not set an Email yet."}, 1)
			local setemail=player:input("Please enter your Email")
			player.email = setemail
			player:dialogSeq({t, "Your Email has been set to: "..player.email}, 1)
		else
			player:dialogSeq({t, "Your Email is currently set to: "..player.email}, 1)
			local choice = player:menuString("Did you want to change this Email?", {"Yes", "No"})
				if (choice == "Yes") then
					local setemail=player:input("Please enter your Email")
					player.email = setemail
					player:dialogSeq({t, "Your Email has been set to: "..player.email}, 1)
				else
					player:dialogSeq({t, "Very well."}, 1)
				end

		end
	elseif menuOption == "Referral Code" then
		player:dialogSeq({t, "Welcome new adventurer! If you have been invited by a friend you can input your referral code here."}, 1)
		player:dialogSeq({t, "This code would have been sent through Email.\n\n<b>WARNING:\nOnce you place this code it cannot be entered again. Make sure you copy and paste the code exactly from the email."}, 1)
		local setcode=player:input("Referral Code:")

		local checklen = string.len(setcode)

		if (checklen == 32) then

			player.refCode = setcode
			--player:dialogSeq({t, "The code you entered is: "..player.refCode.."\n\nAre you sure this is correct?"}, 1)

			local codecheck = player:menuString3("The code you entered is: "..player.refCode.."\n\nAre you sure this is correct?", {"Yes", "No"})
			if (codecheck == "Yes") then
				local mentoris = getMentorCode(player.refCode)
				local mentorname = getOfflineID(mentoris)

				if (mentoris == player.id) then
					player:dialogSeq({t, "You cannot register yourself with a referral code."}, 1)
					return
				end

				if (mentoris == false) then
					player:dialogSeq({t, "This is not a referral code."}, 1)
					return
				end
				--Send player the referral gift
				--player:sendParcel(mentoris, player.ID, item.id, amount, mentoris, 0, 0)
				--player:sendParcel(mentoris, player.ID, item.id, amount, 0, "Echo: ".., 0)
				player.registry["playerRefID"] = mentoris
				player:removeLegendbyName("referralMark")
				player:sendParcel(player.ID, mentoris, 347, 1, 0, "Echo: "..mentorname, 0)
				player:sendParcel(mentoris, player.ID, 347, 1, 0, "Echo: "..player.name, 0)

				player:sendMail(""..mentorname.."", "Welcome your friend "..player.name.." to Han!", "Hi there "..mentorname.."!\n\nIt looks like your friend "..player.name.." has joined The Empire of Han! We hope you guys have fun adventuring together!\n\nFriendship is a strong bond and we would like to honor that bond by providing you with the power of the Echo.\n\nYou can pick up the Echo at the Han messenger, he's holding an Echo for your friend as well. You can use the power of the Echo to find out information on your companion such as current level, location, and even approach them in appropriate areas. You can also grant each other the Echo buff. This buff will give you each a boost in base stats as well as a heal over time.\n\nExpect rewards parceled when your friend hits level 50, and again at level 99!\n\nEmpire of Han Staff")

				player:addLegend("Journied to The Han Empire, guided by "..mentorname.." "..curT(), "referralMark", 3, 39)

				player:dialogSeq({t, "Your referral friend has been registered as: "..mentorname.."\n\nYou will both gain rewards as you increase in level, enjoy your time in The Empire of Han!"}, 1)

			elseif (codecheck == "No") then
				player:dialogSeq({t,"Try again..."},1)
			end
		else
			player:dialogSeq({t, "Bad referral code entry."}, 1)
		end

	elseif menuOption == "Leave Event" then

		local choice = player:menuString("Are you sure you wish to leave the event?", {"Yes", "No"})
		if (choice == "Yes") then
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

					player:removeItem("bt_token",3)
					player:removeItem("rt_token",3)
					player:removeItem("elixir_trophy",1)
					player:removeItem("elixir_bow2",1)
					player.registry["elixirarrowsleft"]=0
					player.armorColor = player.registry["arenaDyeSave"]
					player.registry["arenaDyeSave"] = 0
					player:warp(7000, math.random(7, 16), math.random(13, 14))
		else
			player:dialogSeq({npcGraphics, "Very well, please be patient."}, 1)
		end
	elseif menuOption=="Silver thread" then
		local v={graphic=convertGraphic(83,"monster"),color=0}
		player.npcGraphic=v.graphic
		player.npcColor=v.color
		if (player.m == 1 or player.m == 2 or player.m == 3 or player.m == 4 or player.m == 5) then
			player:dialogSeq({v, "Maybe this was all a dream.. you were exhausted.. lets wake up."}, 1)
			player:warp(2, 3, 5)
			return
		end
		if (player.m == 73) then
			player:dialogSeq({v,"You can't use Silver thread from jail."}, 1)
			return
		end
		--[[
		if(player.m==3004) then
			player:dialogSeq({v,"You can't use Silver thread from jail."})
			return
		end
		]]--
		if(player.state~=1) then
			player:dialogSeq({v,"You are alive, and doing perfectly well."})
		else
			player:dialogSeq({v,"Death is not the end.  Your life's thread is not yet severed.."},1)
			
			if (player.state == 1) then
				if (player.region == 0 or player.region == 1) then
					local warpto = math.random(1,2)
					if (warpto == 1) then
					player:warp(20, 7, 8)
					else
					player:warp(22, 8, 9)
					end
				elseif (player.region == 2) then
					player:warp(73, 10, 6)
				elseif (player.region == 3) then
					player:warp(269, 11, 7)
				end
			end
		end
	elseif menuOption=="Emergency Jailing" then
		local choice=player:input("Who is being a disruption and needs to be jailed immediately?")
		if(Player(choice) == nil) then
			player:sendMinitext("They are not online.")
			return
		end
		Player(choice):warp(73,6,5)
		Player(choice).mute = true
		Player(choice).silence = true
		player:sendMinitext(""..choice.." has been jailed for 1 hour.")
		Player(choice).registry["jailtime"]=os.time()+3600
		Player(choice):sendMinitext("Magistrate "..player.name.." has thrown you in jail!")
										local max=NPC(65).mapRegistry["prisonercount"]

										if(max==0) then
											NPC(65).mapRegistry["prisonercount"]=1
											NPC(65).mapRegistry["prisoner1"]=Player(choice).id
											NPC(65).mapRegistry["prisoner1jailtime"]=Player(choice).registry["jailtime"]
											--Player(nameofPlayer).registry["jailslot"]=NPC(65).mapRegistry["prisonercount"]
											return true
										end

										NPC(65).mapRegistry["prisonercount"]=max+1
										NPC(65).mapRegistry["prisoner" .. max+1]=Player(choice).id
										NPC(65).mapRegistry["prisoner" .. max+1 .. "jailtime"]=Player(choice).registry["jailtime"]
	elseif(menuOption=="Magistrate Chambers") then
		player:dialogSeq({t,"This tool allows you to warp to the Magistrate Chambers."},1)
				player:warp(72,4,14)
				player:sendMinitext("You warp to the Magistrate Chambers.")
	elseif(menuOption=="Event Host Warp") then
		player:dialogSeq({t,"This tool allows you to warp to the Event Hosts Den."},1)
				player:warp(7002,7,7)
				player:sendMinitext("You warp to the Hosts Den.")
	elseif(menuOption=="Remove Disruption" and player.registry["constable"]>0) then
		player:dialogSeq({t,"Constable, this tool allows you to send a Disruptive player to the Inn. Press next to proceed"},1)
			local name=player:input("Who is being a disruption and needs to be sent to the inn?")
			if(string.lower(name)==string.lower(player.name)) then
				player:dialogSeq({t,"You can not use this tool on yourself."})
				return
			end
			Player(name):sendMinitext("Constable "..player.name.." thinks you're causing disruptions and sent you to the inn.")
			Player(name):warp(9,3,6)
			player:sendMinitext("If online, "..name.." has been sent to the inn.")
	elseif(menuOption=="Randomizer") then
		if(player.group~=nil) then	
			local ropts = {}
			table.insert(ropts,"Everyone")
			table.insert(ropts,"Warriors")
			table.insert(ropts,"Rogues")
			table.insert(ropts,"Mages")
			table.insert(ropts,"Poets")
			local roptions=player:menuString2("Who do you wish to apply the randomizer on?",ropts)
			if(roptions=="Everyone") then
				if(os.time()>=player.registry["randomizeraether"]+30) then
					if(#player.group>1 and Player(player.group[1]).name==player.name) then
						local players = {}
						local rolls = {}
						local winningRoll = 0
						local winner = 0
						local comparison = function(a, b)
							return a > b
						end
						
						player:talk(0,"Calling General Randomizer")
						player.registry["randomizeraether"]=os.time()
						
						for x=1,#player.group do
							local ra=math.random(1,100)
							
							table.insert(players, player.group[x])
							table.insert(rolls, ra)
						end
						
						for i = 1, #rolls do
							if (comparison(rolls[i], winningRoll)) then
								winningRoll = rolls[i]
								winner = i
							end
						end
						
						player:talk(1, "[Randomizer]: "..Player(players[winner]).name.." wins the roll with a "..rolls[winner])
					elseif(#player.group>1 and Player(player.group[1]).name~=player.name) then
						
							player:dialogSeq({"You need to be the group leader to call for a general randomizer."})
					
					end
				else
						player:dialogSeq({"You can only use this feature once every thirty seconds"})
				end
			elseif(roptions=="Warriors") then
				if(os.time()>=player.registry["randomizeraether"]+30) then
					if(#player.group>1 and Player(player.group[1]).name==player.name) then
						local players = {}
						local rolls = {}
						local winningRoll = 0
						local winner = 0
						local comparison = function(a, b)
							return a > b
						end
						
						player:talk(0,"Calling Warriors Randomizer")
						player.registry["randomizeraether"]=os.time()
						
						for x=1,#player.group do
							if(Player(player.group[x]).baseClass == 1) then
								local ra=math.random(1,100)
							
								table.insert(players, player.group[x])
								table.insert(rolls, ra)
							end
						end
						
						for i = 1, #rolls do
							if (comparison(rolls[i], winningRoll)) then
								winningRoll = rolls[i]
								winner = i
							end
						end
						
						player:talk(1, "[Randomizer]: "..Player(players[winner]).name.." wins the roll with a "..rolls[winner])
					elseif(#player.group>1 and Player(player.group[1]).name~=player.name) then
						
							player:dialogSeq({"You need to be the group leader to call for a general randomizer."})
					
					end
				else
						player:dialogSeq({"You can only use this feature once every thirty seconds"})
				end
			elseif(roptions=="Rogues") then
				if(os.time()>=player.registry["randomizeraether"]+30) then
					if(#player.group>1 and Player(player.group[1]).name==player.name) then
						local players = {}
						local rolls = {}
						local winningRoll = 0
						local winner = 0
						local comparison = function(a, b)
							return a > b
						end
						
						player:talk(0,"Calling Rogues Randomizer")
						player.registry["randomizeraether"]=os.time()
						
						for x=1,#player.group do
							if(Player(player.group[x]).baseClass == 2) then
								local ra=math.random(1,100)
							
								table.insert(players, player.group[x])
								table.insert(rolls, ra)
							end
						end
						
						for i = 1, #rolls do
							if (comparison(rolls[i], winningRoll)) then
								winningRoll = rolls[i]
								winner = i
							end
						end
						
						player:talk(1, "[Randomizer]: "..Player(players[winner]).name.." wins the roll with a "..rolls[winner])
					elseif(#player.group>1 and Player(player.group[1]).name~=player.name) then
						
							player:dialogSeq({"You need to be the group leader to call for a general randomizer."})
					
					end
				else
						player:dialogSeq({"You can only use this feature once every thirty seconds"})
				end
			elseif(roptions=="Mages") then
				if(os.time()>=player.registry["randomizeraether"]+30) then
					if(#player.group>1 and Player(player.group[1]).name==player.name) then
						local players = {}
						local rolls = {}
						local winningRoll = 0
						local winner = 0
						local comparison = function(a, b)
							return a > b
						end
						
						player:talk(0,"Calling Mages Randomizer")
						player.registry["randomizeraether"]=os.time()
						
						for x=1,#player.group do
							if(Player(player.group[x]).baseClass == 3) then
								local ra=math.random(1,100)
							
								table.insert(players, player.group[x])
								table.insert(rolls, ra)
							end
						end
						
						for i = 1, #rolls do
							if (comparison(rolls[i], winningRoll)) then
								winningRoll = rolls[i]
								winner = i
							end
						end
						
						player:talk(1, "[Randomizer]: "..Player(players[winner]).name.." wins the roll with a "..rolls[winner])
					elseif(#player.group>1 and Player(player.group[1]).name~=player.name) then
						
							player:dialogSeq({"You need to be the group leader to call for a general randomizer."})
					
					end
				else
						player:dialogSeq({"You can only use this feature once every thirty seconds"})
				end
			elseif(roptions=="Poets") then
				if(os.time()>=player.registry["randomizeraether"]+30) then
					if(#player.group>1 and Player(player.group[1]).name==player.name) then
						local players = {}
						local rolls = {}
						local winningRoll = 0
						local winner = 0
						local comparison = function(a, b)
							return a > b
						end
						
						player:talk(0,"Calling General Poets")
						player.registry["randomizeraether"]=os.time()
						
						for x=1,#player.group do
							if(Player(player.group[x]).baseClass == 4) then
								local ra=math.random(1,100)
							
								table.insert(players, player.group[x])
								table.insert(rolls, ra)
							end
						end
						
						for i = 1, #rolls do
							if (comparison(rolls[i], winningRoll)) then
								winningRoll = rolls[i]
								winner = i
							end
						end
						
						player:talk(1, "[Randomizer]: "..Player(players[winner]).name.." wins the roll with a "..rolls[winner])
					elseif(#player.group>1 and Player(player.group[1]).name~=player.name) then
						
							player:dialogSeq({"You need to be the group leader to call for a general randomizer."})
					
					end
				else
						player:dialogSeq({"You can only use this feature once every thirty seconds"})
				end
			end
			else
			if(os.time()>=player.registry["randomizeraether"]+30) then
				player.registry["randomizeraether"]=os.time()
				player:talk(0,"Randomizer: "..player.name.." rolls a "..math.random(1,100).."")
			else
				player:dialogSeq({"You can only use this feature once every thirty seconds"})
			end				
	
		end	
	elseif(menuOption=="Userpages settings") then
		player:dialogSeq({t, "Not yet implemented."}, 1)
		--[[local t={graphic=convertGraphic(838,"monster"),color=0}
					player.npcGraphic=t.graphic
		player.npcColor=t.color
		player:dialogSeq({t,"Welcome to the userpages settings. You will be able to choose from a number of options to customize your userpages. Userpages can be found on www..net"},1)
			local choice=player:menuString2("Do you want to activate your Userpage?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesenable"]=1
				else
					player.registry["userpagesenable"]=0
				end
			choice=player:menuString2("Do you want to disclose your statistics?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesstats"]=1
				else
					player.registry["userpagesstats"]=0
				end
			choice=player:menuString2("Do you want to disclose your equipment?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesequip"]=1
				else
					player.registry["userpagesequip"]=0
				end
			choice=player:menuString2("Do you want to disclose your inventory?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesinventory"]=1
				else
					player.registry["userpagesinventory"]=0
				end
			choice=player:menuString2("Do you want to disclose your legend?",optsuser)
				if(choice=="Yes") then
					player.registry["userpageslegend"]=1
				else
					player.registry["userpageslegend"]=0
				end
			choice=player:menuString2("Do you want to disclose your Bank?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesbank"]=1
				else
					player.registry["userpagesbank"]=0
				end
			choice=player:menuString2("Do you want to disclose your Spells list?",optsuser)
				if(choice=="Yes") then
					player.registry["userpagesspells"]=1
				else
					player.registry["userpagesspells"]=0
				end
		player:dialogSeq({t,"Your userpage should now be modified to your likings."})
		]]--
	elseif (menuOption == "What's my TNL?") then
			local calc1 = (player.level + 1)
			local nextlevel = math.floor(((calc1 * calc1 * calc1 * calc1) * 10 + 40))
			local tnlcalc = (nextlevel - player.exp)
			player:dialogSeq({t,"You are currently level "..player.level..", you need: "..tnlcalc.." experience to reach the next level."},1)
	elseif (menuOption == "Crafting interface") then
		local cinter={}
		table.insert(cinter,"Assess Crafting Skill")
		--table.insert(cinter,"Choose Manufacturing Skill")
		--table.insert(cinter,"Abandon Manufacturing Skill")
		
		local assesscraft = {}
		table.insert(assesscraft,"Shepherd")
		table.insert(assesscraft,"Lumberjack")
		table.insert(assesscraft,"Miner")
		--table.insert(assesscraft,"Fisherman")
		table.insert(assesscraft,"Smelter")
		table.insert(assesscraft,"Weaver")
		--table.insert(assesscraft,"Gemcutter")
		table.insert(assesscraft,"SawMiller")
		table.insert(assesscraft,"Smith")
		--table.insert(assesscraft,"Armorer")
		table.insert(assesscraft,"Forester")
		table.insert(assesscraft,"Tailor")
		--table.insert(assesscraft,"Jewelcrafter")



		local interchoice=player:menuString2("What do wish to do ?",cinter)

		if(interchoice=="Assess Crafting Skill") then
			local assesschoice=player:menuString2("Which skill do wish to assess?",assesscraft)
			local loopchoice=string.lower(assesschoice)
			--[[if(loopchoice=="bladesmith") then
				loopchoice="weaponsmith"
			end
			if(loopchoice=="lumberjack") then
				loopchoice="woodcutter"
			end]]--

			local percent=0
			local percentlevel="null"
			
			if (loopchoice == "smith" or loopchoice == "tailor" or loopchoice == "forester") then
				if (player.registry[""..loopchoice] < 25) then
					percent = math.floor((player.registry[""..loopchoice..""] / 25) * 100)
					percentlevel = "Beginner"
				elseif(player.registry[""..loopchoice] >= 25 and player.registry[""..loopchoice..""]<40) then
					percent=math.floor(((player.registry[""..loopchoice..""]-20)/(40-20))*100)
					percentlevel="Apprentice"
				elseif(player.registry[""..loopchoice..""]>=40 and player.registry[""..loopchoice..""]<80) then
					percent=math.floor(((player.registry[""..loopchoice..""]-40)/(80-40))*100)
					percentlevel="Accomplished"
				elseif(player.registry[""..loopchoice..""]>=80 and player.registry[""..loopchoice..""]<160) then
					percent=math.floor(((player.registry[""..loopchoice..""]-80)/(160-80))*100)
					percentlevel="Adept"
				elseif(player.registry[""..loopchoice..""]>=160 and player.registry[""..loopchoice..""]<320) then
					percent=math.floor(((player.registry[""..loopchoice..""]-160)/(320-160))*100)
					percentlevel="Talented"
				elseif(player.registry[""..loopchoice..""]>=320 and player.registry[""..loopchoice..""]<640) then
					percent=math.floor(((player.registry[""..loopchoice..""]-320)/(640-320))*100)
					percentlevel="Skilled"
				elseif(player.registry[""..loopchoice..""]>=640 and player.registry[""..loopchoice..""]<1280) then
					percent=math.floor(((player.registry[""..loopchoice..""]-640)/(1280-640))*100)
					percentlevel="Expert"
				elseif(player.registry[""..loopchoice..""]>=1280 and player.registry[""..loopchoice..""]<2560) then
					percent=math.floor(((player.registry[""..loopchoice..""]-1280)/(2560-1280))*100)
					percentlevel="Master"
				elseif(player.registry[""..loopchoice..""]>=2560 and player.registry[""..loopchoice..""]<5120) then
					percent=math.floor(((player.registry[""..loopchoice..""]-2560)/(5120-2560))*100)
					percentlevel="Grand Master"
				elseif(player.registry[""..loopchoice..""]>=5120 and player.registry[""..loopchoice..""]<10240) then
					percent=math.floor(((player.registry[""..loopchoice..""]-5120)/(10240-5120))*100)
					percentlevel="Champion"
				elseif(player.registry[""..loopchoice..""]>=10240 and player.registry[""..loopchoice..""]<20480) then
					percent=math.floor(((player.registry[""..loopchoice..""]-10240)/(20480-10240))*100)
					percentlevel="Legendary"
				elseif(player.registry[""..loopchoice..""]>=20480) then
					percent=0
					percentlevel="Legendary"
				end
				if(player.registry[""..loopchoice..""]>20480) then
						player:dialogSeq({t,"Craft : "..assesschoice.."\n\nYou have reached Legendary level."})
						return
				end
			else
				if (player.registry[""..loopchoice] < 25) then
					percent = math.floor((player.registry[""..loopchoice] / 220) * 100)
					percentlevel = "Beginner"
				elseif(player.registry[""..loopchoice..""]<220) then
					percent=math.floor((player.registry[""..loopchoice..""]/220)*100)
					percentlevel="Apprentice"
				elseif(player.registry[""..loopchoice..""]>=220 and player.registry[""..loopchoice..""]<840) then
					percent=math.floor(((player.registry[""..loopchoice..""]-220)/(840-220))*100)
					percentlevel="Accomplished"
				elseif(player.registry[""..loopchoice..""]>=840 and player.registry[""..loopchoice..""]<2200) then
					percent=math.floor(((player.registry[""..loopchoice..""]-840)/(2200-840))*100)
					percentlevel="Adept"
				elseif(player.registry[""..loopchoice..""]>=2200 and player.registry[""..loopchoice..""]<6400) then
					percent=math.floor(((player.registry[""..loopchoice..""]-2200)/(6400-2200))*100)
					percentlevel="Talented"
				elseif(player.registry[""..loopchoice..""]>=6400 and player.registry[""..loopchoice..""]<18000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-6400)/(18000-6400))*100)
					percentlevel="Skilled"
				elseif(player.registry[""..loopchoice..""]>=18000 and player.registry[""..loopchoice..""]<50000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-18000)/(50000-18000))*100)
					percentlevel="Expert"
				elseif(player.registry[""..loopchoice..""]>=50000 and player.registry[""..loopchoice..""]<124000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-50000)/(124000-50000))*100)
					percentlevel="Master"
				elseif(player.registry[""..loopchoice..""]>=124000 and player.registry[""..loopchoice..""]<237000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-124000)/(237000-124000))*100)
					percentlevel="Grand Master"
				elseif(player.registry[""..loopchoice..""]>=237000 and player.registry[""..loopchoice..""]<400000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-237000)/(400000-237000))*100)
					percentlevel="Champion"
				elseif(player.registry[""..loopchoice..""]>=400000 and player.registry[""..loopchoice..""]<680000) then
					percent=math.floor(((player.registry[""..loopchoice..""]-400000)/(680000-400000))*100)
					percentlevel="Legendary"
				elseif(player.registry[""..loopchoice..""]>=680000) then
					percent=0
					percentlevel="Legendary"
				end
				if(player.registry[""..loopchoice..""]>680000) then
						player:dialogSeq({t,"Craft : "..assesschoice.."\n\nYou have reached Legendary level."})
						return
				end
			end
			
			player:dialogSeq({t,"Craft : "..assesschoice.."\n\nYou have completed "..percent.."% of the necessary work to reach "..percentlevel.." level."})
			return
		end
	elseif (menuOption=="Item Information") then
		local item = player:getInventoryItem(0)
		local popup = ""
		local aspdstr = ""
		
		if (item ~= nil) then
			if (item.attackSpeed < -24) then
				aspdstr = "Speedhacking"
			elseif (item.attackSpeed >= -24 and item.attackSpeed < -16) then
				aspdstr = "Extremely Fast"
			elseif (item.attackSpeed >= -16 and item.attackSpeed < -8) then
				aspdstr = "Very Fast"
			elseif (item.attackSpeed >= -8 and item.attackSpeed < 0) then
				aspdstr = "Fast"
			elseif (item.attackSpeed == 0) then
				aspdstr = "Normal"
			elseif (item.attackSpeed > 0 and item.attackSpeed <= 8) then
				aspdstr = "Slow"
			elseif (item.attackSpeed > 8 and item.attackSpeed <= 16) then
				aspdstr = "Very Slow"
			elseif (item.attackSpeed > 16 and item.attackSpeed <= 24) then
				aspdstr = "Extremely Slow"
			elseif (item.attackspeed > 24) then
				aspdstr = "Gooey"
			end
			player:dialogSeq({t,"This option provides full information about the item in slot a."}, 1)
			popup = popup.."<b>"..item.name.."\n\nWeapon Damage: "..item.minDmg.." - "..item.maxDmg.."\nVita/Mana: "..item.vita.."/"..item.mana.."\nDurability: "..item.dura.."/"..item.maxDura.."\nHit/Damage: "..item.hit.."/"..item.dam
			popup = popup.."\nMight/Grace/Will: "..item.might.."/"..item.grace.."/"..item.will.."\nAC: "..(item.ac * .001).."%".."\nProtection: "..item.protection.."\nWisdom: "..item.wisdom.."\nCon: "..item.con.."\nAttack Speed: "..aspdstr
			popup = popup.."\n\n<b>Requirements\n\nLevel: "..item.level.."\nClass: "..item.className.."\nVita/Mana: "..item.reqVita.."/"..item.reqMana.."\nMight/Grace/Will: "..item.reqMight.."/"..item.reqGrace.."/"..item.reqWill
			player:popUp(popup)
		else
			player:popUp("Please put an item in slot (a) for me to identify.")
		end
	elseif (menuOption == "Character Info") then
		local popup = ""
		local vitastr = tostring(player.vRegenAmount)
		local manastr = tostring(player.mRegenAmount)
		local vitafind = string.find(vitastr, "%p")
		local manafind = string.find(manastr, "%p")
		if (vitafind ~= nil) then
			vitafind = vitafind + 1
		end
		if (manafind ~= nil) then
			manafind = manafind + 1
		end
		vitastr = string.sub(vitastr, 0, vitafind)
		manastr = string.sub(manastr, 0, manafind)
		local pkstr = ""
		local pkdurastr = ""
		if (player.PK == 0) then
			pkstr = "Normal"
		elseif (player.PK == 1) then
			pkstr = "PK"
			if (player.durationPK / 1000 > 120) then
				pkdurastr = "\nPK Duration: "..tostring((player.durationPK / 1000) / 60)
			else
				pkdurastr = "\nPK Duration: "..tostring(player.durationPK / 1000)
			end
		else
			pkstr = "Bounty"
			if (player.durationPK / 1000 > 120) then
				pkdurastr = "\nPK Duration: "..tostring((player.durationPK / 1000) / 60)
			else
				pkdurastr = "\nPK Duration: "..tostring(player.durationPK / 1000)
			end
		end
		local expSold = player.expSold
		local quantifier
		if (expSold < 1000000) then
			quantifier = "K"
			expSold = expSold / 1000
		elseif (expSold < 1000000000) then
			quantifier = "M"
			expSold = expSold / 1000000
		else
			quantifier = "B"
			expSold = expSold / 1000000000
		end
		expSold = string.format("%.2f", expSold)
		player:dialogSeq({t, "This option provides full information about your character."}, 1)
		popup = popup.."<b>"..player.name.."'s Base Stats\n\nVita/Mana: "..player.baseHealth.."/"..player.baseMagic
		popup = popup.."\n\n<b>Current Stats\n\nLevel: "..player.level.."\nClass: "..player.className.."\nWeapon Damage: "..player.minDam.." - "..player.maxDam.."\nPierce: "..player.pierce.."\nVita/Mana: "..player.health.."/"..player.magic
		popup = popup.."\nMight/Grace/Will: "..player.might.."/"..player.grace.."/"..player.will.."\nHit/Miss/Dam: "..player.hit.."/"..(player.miss / 100).."/"..player.dam.."\nArmor/AC: "..math.floor(player.armor + .5).."/"..math.floor(player.ac + .5)
		popup = popup.."\nProtection: "..player.protection.."\nWisdom: "..player.wisdom.."\nCon: "..player.con.."\nVita/Mana per 5s: "..vitastr.."/"..manastr.."\nPK Status: "..pkstr..pkdurastr
		
		popup = popup.."\n\nExp Sold: "..expSold.." "..quantifier
		player:popUp(popup)
	elseif (menuOption == "Set AFK Message") then
		local afkMessage = player:input("What would you like your AFK message to say?")
		
		player.afkMessage = afkMessage
	end
end),

about_path = function(player, path, line)
end
}