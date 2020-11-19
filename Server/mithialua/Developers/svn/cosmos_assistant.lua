cosmos_assistant = { 
click = async(function(player, npc)
	local npcA = {graphic = convertGraphic(993, "monster"), color = 26}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0 -- 1 Player-Graphic NPC // 0 Disguise-Graphic NPC

	--player:sendAnimation(391)

	local cosmosOpts = {}
		if (player.gmLevel >= 1) then	
			table.insert(cosmosOpts, "- Nuisance")
			table.insert(cosmosOpts, "Clear Floor")
			table.insert(cosmosOpts, " ")
			--table.insert(cosmosOpts, "Cody - Test NPC")
				if (player.id == 3) then
				end
		end

	if (player.gmLevel >= 1) then
		local mainMenu = player:menuString2("What would you like to do?", cosmosOpts)	
		if (mainMenu == "Clear Floor") then
			local m = player.m
			local itemBlocks = player:getObjectsInMap(m, BL_ITEM)
				local itemReturns = {}
					for i = 1,#itemBlocks do
						table.insert(itemReturns, itemBlocks[i].id)
							itemBlocks[i]:delete()
					end		
		--elseif (mainMenu == "Cody - Test NPC") then
		elseif (mainMenu == "- Nuisance") then
			cosmos_nuisance.say(player,npc)
			return
		end
	else
		player:sendAnimation(11)
		player:sendAnimation(10)
		player:dialogSeq({npcA, "Can I help you?"}, 0)
	end

end),

say = async(function(player, npc)
	local npcA = {graphic = convertGraphic(993, "monster"), color = 26}
		player.npcGraphic = npcA.graphic
		player.npcColor = npcA.color
		player.dialogType = 0 -- 1 Player-Graphic NPC // 0 Disguise-Graphic NPC

	local speech = player.speech
	local lspeech = string.lower(speech)

		if (player.id == 3) then
			if (lspeech == "setface") then
				local mainMenu = player:menuString2("What apperance do you want?", {"Classic Cosmos", "New Face", "New Hair"})
					if (mainMenu == "Classic Cosmos") then
						player.face = 207
						player.faceColor = 555
						player.hair = 52
						player.hairColor = 666
						player:sendAnimation(11)
						player:sendStatus()
						player:updateState()
				elseif (mainMenu == "New Face") then
					local input0 = player:input("Whos face do you want to alter?")
					local input1 = player:input("What face did you want?")
					local input2 = player:input("What eye color did you want?")
						Player(input0).faceColor = input2
						Player(input0).face = input1
						Player(input0):sendAnimation(11)
						Player(input0):sendStatus()
						Player(input0):updateState()
				elseif (mainMenu == "New Hair") then
					local input0 = player:input("Whos hair do you want to alter?")
					local input1 = player:input("What hair did you want?")
					local input2 = player:input("What hair color did you want?")
						Player(input0).hairColor = input2
						Player(input0).hair = input1
						Player(input0):sendAnimation(11)
						Player(input0):sendStatus()
						Player(input0):updateState()
				end
			elseif (lspeech == "npcfollow") then
				local menu1 = player:menuString2("Turn 'Follow' feature On/Off?", {"Turn On.", "Turn Off."})
					if (menu1 == "Turn On.") then
						npc.registry["follow"] = 1
					elseif (menu1 == "Turn Off.") then
						npc.registry["follow"] = 0
					end
			elseif (lspeech == "break") then
				local menuOpts = {}
					table.insert(menuOpts, "Armor")
					table.insert(menuOpts, "Shield")
					table.insert(menuOpts, "Helm")
					table.insert(menuOpts, "Hand - (L)")
					table.insert(menuOpts, "Hand - (R)")
					table.insert(menuOpts, "SubAcc - (L)")
					table.insert(menuOpts, "SubAcc - (R)")
					table.insert(menuOpts, "Face Acc")
					table.insert(menuOpts, "Crown")
					table.insert(menuOpts, "Mantle")
					table.insert(menuOpts, "Necklace")
					table.insert(menuOpts, "Boots")
					table.insert(menuOpts, "Coat")
					table.insert(menuOpts, " ")
					table.insert(menuOpts, "-- ALL GEAR")
				local input1 = player:input("Whos gear do you wish to break?")
				local menu1 = player:menuString2("Which gear would you like to break?", menuOpts)
					if (menu1 == "Weapon") then
						Player(input1):deductDura(0, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Armor") then
						Player(input1):deductDura(1, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Shield") then
						Player(input1):deductDura(2, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Helm") then
						Player(input1):deductDura(3, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Hand - (L)") then
						Player(input1):deductDura(4, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Hand - (R)") then
						Player(input1):deductDura(5, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "SubAcc - (L)") then
						Player(input1):deductDura(6, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "SubAcc - (R)") then
						Player(input1):deductDura(7, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Face Acc") then
						Player(input1):deductDura(8, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Crown") then
						Player(input1):deductDura(9, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Mantle") then
						Player(input1):deductDura(10, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Necklace") then
						Player(input1):deductDura(11, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Boots") then
						Player(input1):deductDura(12, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "Coat") then
						Player(input1):deductDura(13, 9999999)
						Player(input1):sendStatus()
						Player(input1):updateState()
					elseif (menu1 == "-- ALL GEAR") then
						Player(input1):deductDura(0, 9999999)
						Player(input1):deductDura(1, 9999999)
						Player(input1):deductDura(2, 9999999)
						Player(input1):deductDura(3, 9999999)
						Player(input1):deductDura(4, 9999999)
						Player(input1):deductDura(5, 9999999)
						Player(input1):deductDura(6, 9999999)
						Player(input1):deductDura(7, 9999999)
						Player(input1):deductDura(8, 9999999)
						Player(input1):deductDura(9, 9999999)
						Player(input1):deductDura(10, 9999999)
						Player(input1):deductDura(11, 9999999)
						Player(input1):deductDura(12, 9999999)
						Player(input1):deductDura(13, 9999999)
					end
			elseif (lspeech == "setinv") then
				local input1 = player:input("Who's inventory ")
				local mainMenu = player:menuString2("What size inventory would you like?", {"Minimum", "Maximum"})
				if (mainMenu == "Minimum") then
					Player(input1).maxInv = 27
					Player(input1):updateInv()
					Player(input1):sendStatus()
				elseif (mainMenu == "Maximum") then
					Player(input1).maxInv = 52
					Player(input1):updateInv()
					Player(input1):sendStatus()
				end
			--elseif
			end
		end
		if (player.gmLevel >= 1) then

			if (lspeech == "floor1") then
				cosmos_officefloor1.action(npc)
				return
			elseif (lspeech == "floor2") then
				cosmos_officefloor2.action(npc)
				return
			elseif (lspeech == "floor3") then
				cosmos_officefloor3.action(npc)
				return
			elseif (lspeech == "clearfloor") then
				local m = player.m
				local itemBlocks = npc:getObjectsInMap(m, BL_ITEM)
				local itemReturns = {}
					for i = 1,#itemBlocks do
						table.insert(itemReturns, itemBlocks[i].id)
						itemBlocks[i]:delete()
					end

			elseif (lspeech == "chance") then
				local probChance = tonumber((math.random(100))/100)
				player:talk(0, "Probability: "..probChance.."")

			elseif (lspeech == "spawnmob") then
				local spawnOpts = { }
					--table.insert(spawnOpts, "Single   - Single Tile")
					table.insert(spawnOpts, "Multiple - Single Tile")
					--table.insert(spawnOpts, " ")
					--table.insert(spawnOpts, "Area (4)")
					--table.insert(spawnOpts, "Area (8)")
					--table.insert(spawnOpts, " ")
					--table.insert(spawnOpts, "Diamond")
					--table.insert(spawnOpts, " ")
					table.insert(spawnOpts, "Entire Floor")
					table.insert(spawnOpts, "Entire Map")

				local spawnMenu = player:menuString2("What would you like to do?", spawnOpts)
					--if (spawnMenu == "Single   - Single Tile") then
					if (spawnMenu == "Multiple - Single Tile") then
						local input1 = tonumber(player:input("What mob would you like to spawn?"))
						local input2 = tonumber(player:input("How many?"))
							npc:spawn((input1), player.x, player.y, (input2), player.m)
					--elseif (spawnMenu == "Area (4)")
					--elseif (spawnMenu == "Area (8)")
					--elseif (spawnMenu == "Diamond")
					elseif (spawnMenu == "Entire Floor") then
						local input1 = tonumber(player:input("What mob would you like to spawn?"))
							for x=2, 14 do
								for y=2, 12 do
									npc:spawn((input1), x, y, 1, 1001)
								end
							end
					elseif (spawnMenu == "Entire Map") then
						local what_mobID = tonumber(player:input("What monster ID will you set to spawn?"))
						local what_mobAMT = tonumber(player:input("How many monsters?"))
						local what_mobXstart = 0
						local what_mobYstart = 0
						local what_mobXend = npc.xmax
						local what_mobYend = npc.ymax
						local mobCheck
						local pcCheck
						local repCounter = 0
						for i = 1, what_mobAMT do
							repeat
								x = math.random(what_mobXstart, what_mobXend)
								y = math.random(what_mobYstart, what_mobYend)
								mobCheck = player:getObjectsInCell(player.m, x, y, BL_MOB)
								pcCheck = player:getObjectsInCell(player.m, x, y, BL_PC)
							until ((getPass(player.m, x, y) == 0 and #mobCheck == 0 and #pcCheck == 0) or repCounter >= what_mobAMT)
								if (repCounter >= what_mobAMT) then
									player:sendMinitext("Attempted spawning mob over "..what_mobAMT.." times, aborted.")
									repCounter = 0
								else
									player:spawn(what_mobID, x, y, 1, player.m)
									local mob_para = player:getObjectsInCell(player.m, x, y, BL_MOB)
									mob_para[1].paralyzed = true
									mob_para[1]:sendAnimation(74)
									repCounter = repCounter + 1
								end
						end

					end

			elseif (lspeech == "popcheck") then
				local mapX = tonumber(npc.xmax)
				local mapY = tonumber(npc.ymax)
				local formula = math.floor(((mapX * mapY)/12.5))
				local checkcurrentPop = npc:getObjectsInMap(npc.m, BL_MOB)
					player:msg(8, "Current Population: "..(#checkcurrentPop).."\nMax Population Total: "..formula.."", player.ID)

			elseif (lspeech == "travel") then
				local travelOpts = {}
					table.insert(travelOpts, "- Subpath Circles")
					table.insert(travelOpts, "Hunting Grounds")
				local menu1 = player:menuString2("Where would you like to go?", travelOpts)
					if (menu1 == "- Subpath Circles") then
						local sCirclesOpts = {}
							table.insert(sCirclesOpts, "Knight")
							table.insert(sCirclesOpts, "Gladiator")
							table.insert(sCirclesOpts, "Shadow")
							table.insert(sCirclesOpts, "Archer")
							table.insert(sCirclesOpts, "Elementalist")
							table.insert(sCirclesOpts, "Seer")
							table.insert(sCirclesOpts, "Druid")
							table.insert(sCirclesOpts, "Bard")			
						local menu2 = player:menuString2("What would you like to do?", sCirclesOpts)
							if (menu2 == "Knight") then
								player:warp(2006,14,8)
							elseif (menu2 == "Gladiator") then
								player:warp(2007,11,4)
							elseif (menu2 == "Shadow") then
								player:warp(2008,18,4)
							elseif (menu2 == "Archer") then
								player:warp(2009,13,6)
							elseif (menu2 == "Elementalist") then
								player:warp(2010,12,11)
							elseif (menu2 == "Seer") then
								player:warp(2011,4,4)
							elseif (menu2 == "Druid") then
								player:warp(2012,9,12)
							elseif (menu2 == "Bard") then
								player:warp(2013,8,4)
							end							
					elseif (menu1 == "Hunting Grounds") then
						local menu2 = player:menuString2("Which hunting grounds?", {"1-99", "99+"})
							if (menu2 == "1-99") then
								local hGroundsAOpts = {}
									table.insert(hGroundsAOpts, "Lv 8-15   Crystal Fox")
									table.insert(hGroundsAOpts, "Lv15-20   Han Sewers")
									table.insert(hGroundsAOpts, "Lv20-25   Stone Voodoo")
									table.insert(hGroundsAOpts, "Lv25-31   Hive")
									table.insert(hGroundsAOpts, "Lv31-37   Poring Paradise")
									table.insert(hGroundsAOpts, "Lv37-43   Mud Boars")
									table.insert(hGroundsAOpts, "Lv43-50   Kalbog Fae")
									table.insert(hGroundsAOpts, "Lv50-55   Haunted Valley")
									table.insert(hGroundsAOpts, "Lv55-62   Tanzar Walls")
									table.insert(hGroundsAOpts, "Lv62-67   Serpants Slither")
									table.insert(hGroundsAOpts, "Lv67-73   Florandine")
									table.insert(hGroundsAOpts, "Lv73-79   Du Jan Volcano")
									table.insert(hGroundsAOpts, "Lv79-85   Dor Sun Tower")
									table.insert(hGroundsAOpts, "Lv85-91   North Kingdom Wall")
									table.insert(hGroundsAOpts, "Lv91-95   Ogre")
									table.insert(hGroundsAOpts, "Lv95-99   Pirates")
								local menu3 = player:menuString2("Select a cavern to teleport to:", hGroundsAOpts)
									if (menu3 == "Lv 8-15   Crystal Fox") then
										player:warp(33,25,43)
									elseif (menu3 == "Lv15-20   Han Sewers") then
										player:warp(573,8,6)
									elseif (menu3 == "Lv20-25   Stone Voodoo") then
										player:warp(526,12,20)
									elseif (menu3 == "Lv25-31   Hive") then
										player:warp(126,14,24)
									elseif (menu3 == "Lv31-37   Poring Paradise") then
										player:warp(119,20,23)
									elseif (menu3 == "Lv37-43   Mud Boars") then
										player:warp(52,46,45)
									elseif (menu3 == "Lv43-50   Kalbog Fae") then
										player:warp(48,4,7)
									elseif (menu3 == "Lv50-55   Haunted Valley") then
										player:warp(78,38,40)
									elseif (menu3 == "Lv55-62   Tanzar Walls") then
										player:warp(105,17,30)
									elseif (menu3 == "Lv62-67   Serpants Slither") then
										player:warp(111,5,23)
									elseif (menu3 == "Lv67-73   Florandine") then
										player:warp(101,5,24)
									elseif (menu3 == "Lv73-79   Du Jan Volcano") then
										player:warp(65,24,24)
									elseif (menu3 == "Lv79-85   Dor Sun Tower") then
										player:warp(61,24,25)
									elseif (menu3 == "Lv85-91   North Kingdom Wall") then
										player:warp(152,11,18)
									elseif (menu3 == "Lv91-95   Ogre") then
										player:warp(133,36,41)
									elseif (menu3 == "Lv95-99   Pirates") then
										player:warp(138,52,13)
									end
							elseif (menu2 == "99+") then
								local hGroundsBOpts = {}
									table.insert(hGroundsBOpts, "Lv 99-1   Underwater")
									table.insert(hGroundsBOpts, "Lv 99-2   Jungle Temple")
									table.insert(hGroundsBOpts, "Lv 99-3   The Frozen Hold")
									table.insert(hGroundsBOpts, "Lv 99-4   Lost Library")
								local menu3 = player:menuString2("Select a cavern to teleport to:", hGroundsBOpts)
									if (menu3 == "Lv 99-1   Underwater") then
										player:warp(146,13,33)
									elseif (menu3 == "Lv 99-2   Jungle Temple") then
										player:warp(518,4,31)
									elseif (menu3 == "Lv 99-3   The Frozen Hold") then
										player:warp(580,21,68)
									elseif (menu3 == "Lv 99-4   Lost Library") then
										player:warp(500,12,31)
									end
							end	
	 				end
			elseif (lspeech == "passcheck") then
				local mXtiles = (tonumber(npc.xmax)+1)
				local mYtiles = (tonumber(npc.ymax)+1)
				local tTiles = mXtiles * mYtiles
				local passCheck
				local num_nopass = 0
				local num_pass = 0
					for x=0, npc.xmax do
						for y=0, npc.ymax do
							passCheck = getPass(player.m, x, y)
								if (passCheck == 1) then
									num_nopass = num_nopass + 1
									npc:spawn(100, x, y, 1, player.m)
								else
									num_pass = num_pass + 1
								end
						end
					end

				local formula = math.floor(num_pass/12.5)
				local checkcurrentPop = npc:getObjectsInMap(npc.m, BL_MOB)

				player:msg(8, "\n   Total Tiles          :: "..tTiles.."\n   Passable Tiles       :: "..num_pass.."\n   Unpassable Tiles     :: "..num_nopass.."\n  ------------------------------\n   Current Population   :: "..(#checkcurrentPop).."\n   Maximum Population   :: "..formula.."\n", player.ID)
			elseif (lspeech == "getfloortiles") then
				local floorTiles = {}
					for x=0, 16 do
						for y=0, 14 do
							npcTile = getTile(1001, x, y)
							table.insert(floorTiles, npcTile)
						end
					end
					local totalTiles = tostring(table.concat(floorTiles, "," ))
					player:sendMail(""..player.name.."", "Floor Tiles", totalTiles)
			elseif (lspeech == "passremove") then
				local mobBlocks = npc:getObjectsInMap(npc.m, BL_MOB)
					if (#mobBlocks > 0) then
						for i = 1, #mobBlocks do
							mobBlocks[i]:delete()
						end
					end
			elseif (lspeech == "locspawn") then
				local mXtiles = (tonumber(npc.xmax)+1)
				local mYtiles = (tonumber(npc.ymax)+1)
				local tTiles = mXtiles * mYtiles
				local passCheck
				local num_nopass = 0
				local num_pass = 0
					for x=0, npc.xmax do
						for y=0, npc.ymax do
							passCheck = getPass(player.m, x, y)
								if(passCheck == 1) then
									num_nopass = num_nopass + 1
								else
									num_pass = num_pass + 1
								end
						end
					end
				local formula = math.floor(num_pass/12.5)
				local checkcurrentPop = npc:getObjectsInMap(npc.m, BL_MOB)
				npc:talk(0, "Maximum Population   :: "..formula.."")
				npc:talk(0, "Location             :: Map# "..tonumber(npc.m).."")
			elseif (lspeech == "passon") then
				local pass = getPass(player.m, player.x, player.y)
				if (pass ~= 0) then
					setPass(player.m, player.x, player.y, 0)
					npc:talk(0, "Tile: ("..player.x..","..player.y..") Fixed.")
				end
			elseif (lspeech == "passoff") then
				local pass = getPass(player.m, player.x, player.y)
				if (pass ~= 1) then
					setPass(player.m, player.x, player.y, 1)
					npc:talk(0, "Tile: ("..player.x..","..player.y..") Fixed.")
				end
			elseif (lspeech == "fixpasstile") then
				if (pass ~= 0) then
					setPass(player.m, player.x, player.y, 0)
					npc:talk(0, "Fixed.")
				end
			elseif (lspeech == "checkbot") then
				local input1 = player:input("Check Who?")
				npc:talk(0, "botCheck: "..Player(input1).registry["botCheck"].."")
				npc:talk(0, "botFlag: "..Player(input1).registry["botFlag"].."")
				npc:talk(0, "botTimer: "..Player(input1).registry["botCheckTimer"].."")
			elseif (lspeech == "resetbot") then
				local input1 = player:input("Check Who?")
				Player(input1).registry["botCheck"] = 0
				Player(input1).registry["botFlag"] = 0
				Player(input1).registry["botCheckTimer"] = 0
			elseif (lspeech == "testmenu") then
				local menu1 = player:menuString2("What would you like to do?", {"Test1", "Test2", "Test3"})
					if (menu1 == "Test1") then
						local menu2 = player:menuString2("What would you like to do?", {"Change1", "Change2", "Change3"})				
					elseif (menu1 == "Test2") then
						local menu2 = player:menuString2("What would you like to do?", {"Change1", "Change2", "Change3"})
					elseif (menu1 == "Test3") then
						local menu2 = player:menuString2("What would you like to do?", {"Change1", "Change2", "Change3"})
					end
			elseif (lspeech == "testinput") then
				local input1 = player:input("A?")
					local input2 = player:input("B?")
						local input3 = player:input("C?")
							local input4 = player:input("D?")
								local input5 = player:input("E?")
									if (input1 ~= "A") then
										player:popUp("Nope, you got it wrong. 1 ")
									else
										if (input2 ~= "B") then
											player:popUp("Nope, you got it wrong. 2 ")
										else
											if (input3 ~= "C") then
												player:popUp("Nope, you got it wrong. 3 ")
											else
												if (input4 ~= "D") then
													player:popUp("Nope, you got it wrong. 4 ")
												else
													if (input5 ~= "E") then
														player:popUp("Nope, you got it wrong. 5 ")
													else
														player:popUp("You got it right!")
													end
												end
											end
										end
									end
			elseif (lspeech == "testa1") then
				player.quest["subitem"] = 0
				player.quest["subitem_Weapon"] = 0
				player.quest["subitem_Coat"] = 0
				npc:talk(0, "Quest: 'subitem' reset.")
				npc:talk(0, "Quest: 'subitem_Weapon' reset.")
				npc:talk(0, "Quest: 'subitem_Coat' reset.")
			elseif (lspeech == "testname") then
				local input1 = player:input("Who?")
					npc:talk(0, "Player: "..input1.."")
					npc:talk(0, "Offline ID: "..getOfflineID(input1).."")
			elseif (lspeech == "checkmap") then
				npc:talk(0, "BGM - "..npc.bgm.."") --map bgm
				npc:talk(0, "PVP - "..npc.pvp.."") --map pvp value
				npc:talk(0, "Spell - "..npc.spell.."") --map pvp value
				npc:talk(0, "Light - "..npc.light.."") --map light value
				npc:talk(0, "Weather - "..npc.weather.."") --weather number:
			elseif (lspeech == "setmap") then
				local setMenu = player:menuString2("Which would you like to set?", {"BGM", "PvP", "Spell", "Light", "Weather"})
					if (setMenu == "BGM") then
						local input1 = player:input("Set to what?")
							npc.bgm = input1
							player:sendMinitext("BGM set to: "..input1.."")
							local players = player:getObjectsInMap(player.m, BL_PC)
							for i = 1, #players do
								local people = players[i].name
								Player(people):refresh()
							end
					elseif (setMenu == "PvP") then
						local menu1 = player:menuString2("Set to what?", {"0 - Off", "1 - PvP", "2 - Bounty"})
							if menu1 == "0 - Off" then
								npc.pvp = 0
								player:sendMinitext("PvP set to: 0")
								local players = player:getObjectsInMap(player.m, BL_PC)
								for i = 1, #players do
									local people = players[i].name
									Player(people):refresh()
								end
							elseif menu1 == "1 - PvP" then
								npc.pvp = 1
								player:sendMinitext("PvP set to: 1")
								local players = player:getObjectsInMap(player.m, BL_PC)
								for i = 1, #players do
									local people = players[i].name
									Player(people):refresh()
								end
							elseif menu1 == "2 - Bounty" then
								npc.pvp = 2
								player:sendMinitext("PvP set to: 2")
								local players = player:getObjectsInMap(player.m, BL_PC)
								for i = 1, #players do
									local people = players[i].name
									Player(people):refresh()
								end
							end
					elseif (setMenu == "Spell") then
						local menu1 = player:menuString2("Set to what?", {"0 - Off", "1 - On"})
							if menu1 == "0 - Off" then
								npc.spell = 0
								player:sendMinitext("Spells turned Off.")
								local players = player:getObjectsInMap(player.m, BL_PC)
								for i = 1, #players do
									local people = players[i].name
									Player(people):refresh()
								end
							elseif menu1 == "1 - On" then
								npc.spell = 1
								player:sendMinitext("Spells turned On.")
								local players = player:getObjectsInMap(player.m, BL_PC)
								for i = 1, #players do
									local people = players[i].name
									Player(people):refresh()
								end
							end
					elseif (setMenu == "Light") then
						local input1 = player:input("Set to what?")
							npc.light = input1
							player:sendMinitext("Light set to: "..input1.."")
							local players = player:getObjectsInMap(player.m, BL_PC)
							for i = 1, #players do
								local people = players[i].name
								Player(people):refresh()
							end

					elseif (setMenu == "Weather") then
						local input1 = player:input("Set to what?")
							npc.weather = input1
							player:sendMinitext("Weather set to: "..input1.."")
							local players = player:getObjectsInMap(player.m, BL_PC)
							for i = 1, #players do
								local people = players[i].name
								Player(people):refresh()
							end
					end

			elseif (lspeech == "removeitem") then
				local amountCheck = 0
				local itemTable = {}
				local amount = 0
				local found = 0
				
				for i = 0, player.maxInv do
					local nItem = player:getInventoryItem(i)
					
					if (nItem ~= nil and nItem.id > 0) then
						if (#itemTable > 0) then
							found = 0
							
							for j = 1, #itemTable do
								if (itemTable[j] == nItem.id) then
									found = 1
									break
								end
							end
							
							if (found == 0) then
								table.insert(itemTable, nItem.id)
							end
						else
							table.insert(itemTable, nItem.id)
						end
					end
				end
				
				local choice = player:sell("What would you like to remove?", itemTable)
				local dItem = player:getInventoryItem(choice - 1)
				
				if (dItem == nil) then
					return
				end
				
				if (dItem.maxAmount > 1 and dItem.amount > 1) then
					amount = math.abs(tonumber(math.floor(player:input("How many would you like to remove?"))))

					if (player:hasItem(dItem.id, amount) ~= true) then
						amountCheck = player:hasItem(dItem.id, amount)
						amount = amountCheck
					end
				else
					amount = 1
				end

				if (amount == 0) then
					player:dialogSeq({"You try to hand nothing, but fail."})
					return false
				end

				moneyChoice = player:menuString("Are you sure you wish to remove this item?", {"Yes", "No"})
				
				if (moneyChoice == "Yes") then
					if (player:hasItem(dItem.id, amount) == true) then
						if (amount == 1) then
							player:removeItemSlot((choice - 1), amount, 2)
						else
							player:removeItem(dItem.id, amount, 2)
						end
						player:sendStatus()
					else
						player:dialogSeq({"You do not have what it is you want me to remove for you."})
						return false
					end
				else
					return false
				end


			end
		end
end),

-- Timer == Loop Time
-- End Action == Duration Times

action = function(npc) --action based off timer
	local cosM = Player(3).m
	local cosX = Player(3).x
	local cosY = Player(3).y

	local range = 30

	-- Follow Commands
		if (npc.registry["follow"] == 0) then
			npc:warp(npc.startM, npc.startX, npc.startY) 
		elseif (npc.registry["follow"] == 1) then
			if (npc.m == cosM) then
				if (distance(NPC(113), Player(3)) >= range) then
					npc:warp(cosM, cosX, cosY)
				end
			else
				npc:warp(cosM, cosX, cosY)
			end
		end
end,
}



cosmos_officefloor1 = {
action = function(npc)
	setTile(1001, 1, 1, 41639)
	setTile(1001, 1, 2, 41652)
	setTile(1001, 1, 3, 41652)
	setTile(1001, 1, 4, 41652)
	setTile(1001, 1, 5, 41652)
	setTile(1001, 1, 6, 41652)
	setTile(1001, 1, 7, 41652)
	setTile(1001, 1, 8, 41652)
	setTile(1001, 1, 9, 41652)
	setTile(1001, 1, 10, 41652)
	setTile(1001, 1, 11, 41652)
	setTile(1001, 1, 12, 41652)
	setTile(1001, 1, 13, 41733)
	setTile(1001, 2, 1, 41640)
	setTile(1001, 2, 2, 28567)
	setTile(1001, 2, 3, 28570)
	setTile(1001, 2, 4, 28570)
	setTile(1001, 2, 5, 28570)
	setTile(1001, 2, 6, 28570)
	setTile(1001, 2, 7, 28570)
	setTile(1001, 2, 8, 28570)
	setTile(1001, 2, 9, 28570)
	setTile(1001, 2, 10, 28570)
	setTile(1001, 2, 11, 28570)
	setTile(1001, 2, 12, 28572)
	setTile(1001, 2, 13, 41734)
	setTile(1001, 3, 1, 41641)
	setTile(1001, 3, 2, 28568)
	setTile(1001, 3, 3, 28551)
	setTile(1001, 3, 4, 28551)
	setTile(1001, 3, 5, 28551)
	setTile(1001, 3, 6, 28551)
	setTile(1001, 3, 7, 28551)
	setTile(1001, 3, 8, 28551)
	setTile(1001, 3, 9, 28551)
	setTile(1001, 3, 10, 28551)
	setTile(1001, 3, 11, 28551)
	setTile(1001, 3, 12, 28573)
	setTile(1001, 3, 13, 41744)
	setTile(1001, 4, 1, 41641)
	setTile(1001, 4, 2, 28568)
	setTile(1001, 4, 3, 28551)
	setTile(1001, 4, 4, 28551)
	setTile(1001, 4, 5, 28551)
	setTile(1001, 4, 6, 28551)
	setTile(1001, 4, 7, 28551)
	setTile(1001, 4, 8, 28551)
	setTile(1001, 4, 9, 28551)
	setTile(1001, 4, 10, 28551)
	setTile(1001, 4, 11, 28551)
	setTile(1001, 4, 12, 28573)
	setTile(1001, 4, 13, 41744)
	setTile(1001, 5, 1, 41641)
	setTile(1001, 5, 2, 28568)
	setTile(1001, 5, 3, 28551)
	setTile(1001, 5, 4, 28551)
	setTile(1001, 5, 5, 28551)
	setTile(1001, 5, 6, 28551)
	setTile(1001, 5, 7, 28551)
	setTile(1001, 5, 8, 28551)
	setTile(1001, 5, 9, 28551)
	setTile(1001, 5, 10, 28551)
	setTile(1001, 5, 11, 28551)
	setTile(1001, 5, 12, 28573)
	setTile(1001, 5, 13, 41744)
	setTile(1001, 6, 1, 41641)
	setTile(1001, 6, 2, 28568)
	setTile(1001, 6, 3, 28551)
	setTile(1001, 6, 4, 28551)
	setTile(1001, 6, 5, 28551)
	setTile(1001, 6, 6, 28551)
	setTile(1001, 6, 7, 28551)
	setTile(1001, 6, 8, 28551)
	setTile(1001, 6, 9, 28551)
	setTile(1001, 6, 10, 28551)
	setTile(1001, 6, 11, 28551)
	setTile(1001, 6, 12, 28573)
	setTile(1001, 6, 13, 41744)
	setTile(1001, 7, 1, 41641)
	setTile(1001, 7, 2, 28568)
	setTile(1001, 7, 3, 28551)
	setTile(1001, 7, 4, 28551)
	setTile(1001, 7, 5, 28551)
	setTile(1001, 7, 6, 28551)
	setTile(1001, 7, 7, 28551)
	setTile(1001, 7, 8, 28551)
	setTile(1001, 7, 9, 28551)
	setTile(1001, 7, 10, 28551)
	setTile(1001, 7, 11, 28551)
	setTile(1001, 7, 12, 28573)
	setTile(1001, 7, 13, 41744)
	setTile(1001, 8, 1, 41641)
	setTile(1001, 8, 2, 28568)
	setTile(1001, 8, 3, 28551)
	setTile(1001, 8, 4, 28551)
	setTile(1001, 8, 5, 28551)
	setTile(1001, 8, 6, 28551)
	setTile(1001, 8, 7, 28551)
	setTile(1001, 8, 8, 28551)
	setTile(1001, 8, 9, 28551)
	setTile(1001, 8, 10, 28551)
	setTile(1001, 8, 11, 28551)
	setTile(1001, 8, 12, 28573)
	setTile(1001, 8, 13, 41744)
	setTile(1001, 9, 1, 41641)
	setTile(1001, 9, 2, 28568)
	setTile(1001, 9, 3, 28551)
	setTile(1001, 9, 4, 28551)
	setTile(1001, 9, 5, 28551)
	setTile(1001, 9, 6, 28551)
	setTile(1001, 9, 7, 28551)
	setTile(1001, 9, 8, 28551)
	setTile(1001, 9, 9, 28551)
	setTile(1001, 9, 10, 28551)
	setTile(1001, 9, 11, 28551)
	setTile(1001, 9, 12, 28573)
	setTile(1001, 9, 13, 41744)
	setTile(1001, 10, 1, 41641)
	setTile(1001, 10, 2, 28568)
	setTile(1001, 10, 3, 28551)
	setTile(1001, 10, 4, 28551)
	setTile(1001, 10, 5, 28551)
	setTile(1001, 10, 6, 28551)
	setTile(1001, 10, 7, 28551)
	setTile(1001, 10, 8, 28551)
	setTile(1001, 10, 9, 28551)
	setTile(1001, 10, 10, 28551)
	setTile(1001, 10, 11, 28551)
	setTile(1001, 10, 12, 28573)
	setTile(1001, 10, 13, 41744)
	setTile(1001, 11, 1, 41641)
	setTile(1001, 11, 2, 28568)
	setTile(1001, 11, 3, 28551)
	setTile(1001, 11, 4, 28551)
	setTile(1001, 11, 5, 28551)
	setTile(1001, 11, 6, 28551)
	setTile(1001, 11, 7, 28551)
	setTile(1001, 11, 8, 28551)
	setTile(1001, 11, 9, 28551)
	setTile(1001, 11, 10, 28551)
	setTile(1001, 11, 11, 28551)
	setTile(1001, 11, 12, 28573)
	setTile(1001, 11, 13, 41744)
	setTile(1001, 12, 1, 41641)
	setTile(1001, 12, 2, 28568)
	setTile(1001, 12, 3, 28551)
	setTile(1001, 12, 4, 28551)
	setTile(1001, 12, 5, 28551)
	setTile(1001, 12, 6, 28551)
	setTile(1001, 12, 7, 28551)
	setTile(1001, 12, 8, 28551)
	setTile(1001, 12, 9, 28551)
	setTile(1001, 12, 10, 28551)
	setTile(1001, 12, 11, 28551)
	setTile(1001, 12, 12, 28573)
	setTile(1001, 12, 13, 41744)
	setTile(1001, 13, 1, 41641)
	setTile(1001, 13, 2, 28568)
	setTile(1001, 13, 3, 28551)
	setTile(1001, 13, 4, 28551)
	setTile(1001, 13, 5, 28551)
	setTile(1001, 13, 6, 28551)
	setTile(1001, 13, 7, 28551)
	setTile(1001, 13, 8, 28551)
	setTile(1001, 13, 9, 28551)
	setTile(1001, 13, 10, 28551)
	setTile(1001, 13, 11, 28551)
	setTile(1001, 13, 12, 28573)
	setTile(1001, 13, 13, 41744)
	setTile(1001, 14, 1, 41643)
	setTile(1001, 14, 2, 28569)
	setTile(1001, 14, 3, 28571)
	setTile(1001, 14, 4, 28571)
	setTile(1001, 14, 5, 28571)
	setTile(1001, 14, 6, 28571)
	setTile(1001, 14, 7, 28571)
	setTile(1001, 14, 8, 28571)
	setTile(1001, 14, 9, 28571)
	setTile(1001, 14, 10, 28571)
	setTile(1001, 14, 11, 28571)
	setTile(1001, 14, 12, 28574)
	setTile(1001, 14, 13, 41735)
	setTile(1001, 15, 1, 41644)
	setTile(1001, 15, 2, 41748)
	setTile(1001, 15, 3, 41748)
	setTile(1001, 15, 4, 41748)
	setTile(1001, 15, 5, 41748)
	setTile(1001, 15, 6, 41748)
	setTile(1001, 15, 7, 41748)
	setTile(1001, 15, 8, 41748)
	setTile(1001, 15, 9, 41748)
	setTile(1001, 15, 10, 41748)
	setTile(1001, 15, 11, 41748)
	setTile(1001, 15, 12, 41748)
	setTile(1001, 15, 13, 41736)
	setPass(1001, 1, 1, 0)
	setPass(1001, 1, 2, 0)
	setPass(1001, 1, 3, 0)
	setPass(1001, 1, 4, 0)
	setPass(1001, 1, 5, 0)
	setPass(1001, 1, 6, 0)
	setPass(1001, 1, 7, 0)
	setPass(1001, 1, 8, 0)
	setPass(1001, 1, 9, 0)
	setPass(1001, 1, 10, 0)
	setPass(1001, 1, 11, 0)
	setPass(1001, 1, 12, 0)
	setPass(1001, 1, 13, 0)
	setPass(1001, 2, 1, 0)
	setPass(1001, 2, 2, 0)
	setPass(1001, 2, 3, 0)
	setPass(1001, 2, 4, 0)
	setPass(1001, 2, 5, 0)
	setPass(1001, 2, 6, 0)
	setPass(1001, 2, 7, 0)
	setPass(1001, 2, 8, 0)
	setPass(1001, 2, 9, 0)
	setPass(1001, 2, 10, 0)
	setPass(1001, 2, 11, 0)
	setPass(1001, 2, 12, 0)
	setPass(1001, 2, 13, 0)
	setPass(1001, 3, 1, 0)
	setPass(1001, 3, 2, 0)
	setPass(1001, 3, 3, 0)
	setPass(1001, 3, 4, 0)
	setPass(1001, 3, 5, 0)
	setPass(1001, 3, 6, 0)
	setPass(1001, 3, 7, 0)
	setPass(1001, 3, 8, 0)
	setPass(1001, 3, 9, 0)
	setPass(1001, 3, 10, 0)
	setPass(1001, 3, 11, 0)
	setPass(1001, 3, 12, 0)
	setPass(1001, 3, 13, 0)
	setPass(1001, 4, 1, 0)
	setPass(1001, 4, 2, 0)
	setPass(1001, 4, 3, 0)
	setPass(1001, 4, 4, 0)
	setPass(1001, 4, 5, 0)
	setPass(1001, 4, 6, 0)
	setPass(1001, 4, 7, 0)
	setPass(1001, 4, 8, 0)
	setPass(1001, 4, 9, 0)
	setPass(1001, 4, 10, 0)
	setPass(1001, 4, 11, 0)
	setPass(1001, 4, 12, 0)
	setPass(1001, 4, 13, 0)
	setPass(1001, 5, 1, 0)
	setPass(1001, 5, 2, 0)
	setPass(1001, 5, 3, 0)
	setPass(1001, 5, 4, 0)
	setPass(1001, 5, 5, 0)
	setPass(1001, 5, 6, 0)
	setPass(1001, 5, 7, 0)
	setPass(1001, 5, 8, 0)
	setPass(1001, 5, 9, 0)
	setPass(1001, 5, 10, 0)
	setPass(1001, 5, 11, 0)
	setPass(1001, 5, 12, 0)
	setPass(1001, 5, 13, 0)
	setPass(1001, 6, 1, 0)
	setPass(1001, 6, 2, 0)
	setPass(1001, 6, 3, 0)
	setPass(1001, 6, 4, 0)
	setPass(1001, 6, 5, 0)
	setPass(1001, 6, 6, 0)
	setPass(1001, 6, 7, 0)
	setPass(1001, 6, 8, 0)
	setPass(1001, 6, 9, 0)
	setPass(1001, 6, 10, 0)
	setPass(1001, 6, 11, 0)
	setPass(1001, 6, 12, 0)
	setPass(1001, 6, 13, 0)
	setPass(1001, 7, 1, 0)
	setPass(1001, 7, 2, 0)
	setPass(1001, 7, 3, 0)
	setPass(1001, 7, 4, 0)
	setPass(1001, 7, 5, 0)
	setPass(1001, 7, 6, 0)
	setPass(1001, 7, 7, 0)
	setPass(1001, 7, 8, 0)
	setPass(1001, 7, 9, 0)
	setPass(1001, 7, 10, 0)
	setPass(1001, 7, 11, 0)
	setPass(1001, 7, 12, 0)
	setPass(1001, 7, 13, 0)
	setPass(1001, 8, 1, 0)
	setPass(1001, 8, 2, 0)
	setPass(1001, 8, 3, 0)
	setPass(1001, 8, 4, 0)
	setPass(1001, 8, 5, 0)
	setPass(1001, 8, 6, 0)
	setPass(1001, 8, 7, 0)
	setPass(1001, 8, 8, 0)
	setPass(1001, 8, 9, 0)
	setPass(1001, 8, 10, 0)
	setPass(1001, 8, 11, 0)
	setPass(1001, 8, 12, 0)
	setPass(1001, 8, 13, 0)
	setPass(1001, 9, 1, 0)
	setPass(1001, 9, 2, 0)
	setPass(1001, 9, 3, 0)
	setPass(1001, 9, 4, 0)
	setPass(1001, 9, 5, 0)
	setPass(1001, 9, 6, 0)
	setPass(1001, 9, 7, 0)
	setPass(1001, 9, 8, 0)
	setPass(1001, 9, 9, 0)
	setPass(1001, 9, 10, 0)
	setPass(1001, 9, 11, 0)
	setPass(1001, 9, 12, 0)
	setPass(1001, 9, 13, 0)
	setPass(1001, 10, 1, 0)
	setPass(1001, 10, 2, 0)
	setPass(1001, 10, 3, 0)
	setPass(1001, 10, 4, 0)
	setPass(1001, 10, 5, 0)
	setPass(1001, 10, 6, 0)
	setPass(1001, 10, 7, 0)
	setPass(1001, 10, 8, 0)
	setPass(1001, 10, 9, 0)
	setPass(1001, 10, 10, 0)
	setPass(1001, 10, 11, 0)
	setPass(1001, 10, 12, 0)
	setPass(1001, 10, 13, 0)
	setPass(1001, 11, 1, 0)
	setPass(1001, 11, 2, 0)
	setPass(1001, 11, 3, 0)
	setPass(1001, 11, 4, 0)
	setPass(1001, 11, 5, 0)
	setPass(1001, 11, 6, 0)
	setPass(1001, 11, 7, 0)
	setPass(1001, 11, 8, 0)
	setPass(1001, 11, 9, 0)
	setPass(1001, 11, 10, 0)
	setPass(1001, 11, 11, 0)
	setPass(1001, 11, 12, 0)
	setPass(1001, 11, 13, 0)
	setPass(1001, 12, 1, 0)
	setPass(1001, 12, 2, 0)
	setPass(1001, 12, 3, 0)
	setPass(1001, 12, 4, 0)
	setPass(1001, 12, 5, 0)
	setPass(1001, 12, 6, 0)
	setPass(1001, 12, 7, 0)
	setPass(1001, 12, 8, 0)
	setPass(1001, 12, 9, 0)
	setPass(1001, 12, 10, 0)
	setPass(1001, 12, 11, 0)
	setPass(1001, 12, 12, 0)
	setPass(1001, 12, 13, 0)
	setPass(1001, 13, 1, 0)
	setPass(1001, 13, 2, 0)
	setPass(1001, 13, 3, 0)
	setPass(1001, 13, 4, 0)
	setPass(1001, 13, 5, 0)
	setPass(1001, 13, 6, 0)
	setPass(1001, 13, 7, 0)
	setPass(1001, 13, 8, 0)
	setPass(1001, 13, 9, 0)
	setPass(1001, 13, 10, 0)
	setPass(1001, 13, 11, 0)
	setPass(1001, 13, 12, 0)
	setPass(1001, 13, 13, 0)
	setPass(1001, 14, 1, 0)
	setPass(1001, 14, 2, 0)
	setPass(1001, 14, 3, 0)
	setPass(1001, 14, 4, 0)
	setPass(1001, 14, 5, 0)
	setPass(1001, 14, 6, 0)
	setPass(1001, 14, 7, 0)
	setPass(1001, 14, 8, 0)
	setPass(1001, 14, 9, 0)
	setPass(1001, 14, 10, 0)
	setPass(1001, 14, 11, 0)
	setPass(1001, 14, 12, 0)
	setPass(1001, 14, 13, 0)
	setPass(1001, 15, 1, 0)
	setPass(1001, 15, 2, 0)
	setPass(1001, 15, 3, 0)
	setPass(1001, 15, 4, 0)
	setPass(1001, 15, 5, 0)
	setPass(1001, 15, 6, 0)
	setPass(1001, 15, 7, 0)
	setPass(1001, 15, 8, 0)
	setPass(1001, 15, 9, 0)
	setPass(1001, 15, 10, 0)
	setPass(1001, 15, 11, 0)
	setPass(1001, 15, 12, 0)
	setPass(1001, 15, 13, 0)
	setPass(1001, 0, 0, 1)
	setPass(1001, 0, 1, 1)
	setPass(1001, 0, 2, 1)
	setPass(1001, 0, 3, 1)
	setPass(1001, 0, 4, 1)
	setPass(1001, 0, 5, 1)
	setPass(1001, 0, 6, 1)
	setPass(1001, 0, 7, 1)
	setPass(1001, 0, 8, 1)
	setPass(1001, 0, 9, 1)
	setPass(1001, 0, 10, 1)
	setPass(1001, 0, 11, 1)
	setPass(1001, 0, 12, 1)
	setPass(1001, 0, 13, 1)
	setPass(1001, 0, 14, 1)
	setPass(1001, 1, 0, 1)
	setPass(1001, 1, 1, 1)
	setPass(1001, 1, 2, 1)
	setPass(1001, 1, 3, 1)
	setPass(1001, 1, 4, 1)
	setPass(1001, 1, 5, 1)
	setPass(1001, 1, 6, 1)
	setPass(1001, 1, 7, 1)
	setPass(1001, 1, 8, 1)
	setPass(1001, 1, 9, 1)
	setPass(1001, 1, 10, 1)
	setPass(1001, 1, 11, 1)
	setPass(1001, 1, 12, 1)
	setPass(1001, 1, 13, 1)
	setPass(1001, 1, 14, 1)
	setPass(1001, 2, 0, 1)
	setPass(1001, 2, 1, 1)
	setPass(1001, 2, 13, 1)
	setPass(1001, 2, 14, 1)
	setPass(1001, 3, 0, 1)
	setPass(1001, 3, 1, 1)
	setPass(1001, 3, 13, 1)
	setPass(1001, 3, 14, 1)
	setPass(1001, 4, 0, 1)
	setPass(1001, 4, 1, 1)
	setPass(1001, 4, 13, 1)
	setPass(1001, 4, 14, 1)
	setPass(1001, 5, 0, 1)
	setPass(1001, 5, 1, 1)
	setPass(1001, 5, 13, 1)
	setPass(1001, 5, 14, 1)
	setPass(1001, 6, 0, 1)
	setPass(1001, 6, 1, 1)
	setPass(1001, 6, 13, 1)
	setPass(1001, 6, 14, 1)
	setPass(1001, 7, 0, 1)
	setPass(1001, 7, 1, 1)
	setPass(1001, 7, 13, 1)
	setPass(1001, 7, 14, 1)
	setPass(1001, 8, 0, 1)
	setPass(1001, 8, 1, 1)
	setPass(1001, 8, 13, 1)
	setPass(1001, 8, 14, 1)
	setPass(1001, 9, 0, 1)
	setPass(1001, 9, 1, 1)
	setPass(1001, 9, 13, 1)
	setPass(1001, 9, 14, 1)
	setPass(1001, 10, 0, 1)
	setPass(1001, 10, 1, 1)
	setPass(1001, 10, 13, 1)
	setPass(1001, 10, 14, 1)
	setPass(1001, 11, 0, 1)
	setPass(1001, 11, 1, 1)
	setPass(1001, 11, 13, 1)
	setPass(1001, 11, 14, 1)
	setPass(1001, 12, 0, 1)
	setPass(1001, 12, 1, 1)
	setPass(1001, 12, 13, 1)
	setPass(1001, 12, 14, 1)
	setPass(1001, 13, 0, 1)
	setPass(1001, 13, 1, 1)
	setPass(1001, 13, 13, 1)
	setPass(1001, 13, 14, 1)
	setPass(1001, 14, 0, 1)
	setPass(1001, 14, 1, 1)
	setPass(1001, 14, 13, 1)
	setPass(1001, 14, 14, 1)
	setPass(1001, 15, 0, 1)
	setPass(1001, 15, 1, 1)
	setPass(1001, 15, 2, 1)
	setPass(1001, 15, 3, 1)
	setPass(1001, 15, 4, 1)
	setPass(1001, 15, 5, 1)
	setPass(1001, 15, 6, 1)
	setPass(1001, 15, 7, 1)
	setPass(1001, 15, 8, 1)
	setPass(1001, 15, 9, 1)
	setPass(1001, 15, 10, 1)
	setPass(1001, 15, 11, 1)
	setPass(1001, 15, 12, 1)
	setPass(1001, 15, 13, 1)
	setPass(1001, 15, 14, 1)
	setPass(1001, 16, 0, 1)
	setPass(1001, 16, 1, 1)
	setPass(1001, 16, 2, 1)
	setPass(1001, 16, 3, 1)
	setPass(1001, 16, 4, 1)
	setPass(1001, 16, 5, 1)
	setPass(1001, 16, 6, 1)
	setPass(1001, 16, 7, 1)
	setPass(1001, 16, 8, 1)
	setPass(1001, 16, 9, 1)
	setPass(1001, 16, 10, 1)
	setPass(1001, 16, 11, 1)
	setPass(1001, 16, 12, 1)
	setPass(1001, 16, 13, 1)
	setPass(1001, 16, 14, 1)
end,
}
cosmos_officefloor2 = {
action = function(npc)
	setTile(1001, 0, 0, 29923)
	setTile(1001, 0, 1, 29932)
	setTile(1001, 0, 2, 29943)
	setTile(1001, 0, 3, 29960)
	setTile(1001, 0, 4, 29977)
	setTile(1001, 0, 5, 29994)
	setTile(1001, 0, 6, 30011)
	setTile(1001, 0, 7, 30028)
	setTile(1001, 0, 8, 30045)
	setTile(1001, 0, 9, 30062)
	setTile(1001, 0, 10, 30066)
	setTile(1001, 0, 11, 30068)
	setTile(1001, 0, 12, 30451)
	setTile(1001, 0, 13, 30451)
	setTile(1001, 0, 14, 30451)
	setTile(1001, 1, 0, 29924)
	setTile(1001, 1, 1, 29933)
	setTile(1001, 1, 2, 29944)
	setTile(1001, 1, 3, 29961)
	setTile(1001, 1, 4, 29978)
	setTile(1001, 1, 5, 29995)
	setTile(1001, 1, 6, 30012)
	setTile(1001, 1, 7, 30029)
	setTile(1001, 1, 8, 30046)
	setTile(1001, 1, 9, 30063)
	setTile(1001, 1, 10, 30067)
	setTile(1001, 1, 11, 30069)
	setTile(1001, 1, 12, 30451)
	setTile(1001, 1, 13, 30451)
	setTile(1001, 1, 14, 30451)
	setTile(1001, 2, 0, 29925)
	setTile(1001, 2, 1, 29934)
	setTile(1001, 2, 2, 29945)
	setTile(1001, 2, 3, 29962)
	setTile(1001, 2, 4, 29979)
	setTile(1001, 2, 5, 29996)
	setTile(1001, 2, 6, 30013)
	setTile(1001, 2, 7, 30030)
	setTile(1001, 2, 8, 30047)
	setTile(1001, 2, 9, 30451)
	setTile(1001, 2, 10, 30451)
	setTile(1001, 2, 11, 30451)
	setTile(1001, 2, 12, 30451)
	setTile(1001, 2, 13, 30451)
	setTile(1001, 2, 14, 30451)
	setTile(1001, 3, 0, 29926)
	setTile(1001, 3, 1, 29935)
	setTile(1001, 3, 2, 29946)
	setTile(1001, 3, 3, 29963)
	setTile(1001, 3, 4, 29980)
	setTile(1001, 3, 5, 29997)
	setTile(1001, 3, 6, 30014)
	setTile(1001, 3, 7, 30031)
	setTile(1001, 3, 8, 30048)
	setTile(1001, 3, 9, 30451)
	setTile(1001, 3, 10, 30451)
	setTile(1001, 3, 11, 30451)
	setTile(1001, 3, 12, 30451)
	setTile(1001, 3, 13, 30451)
	setTile(1001, 3, 14, 30451)
	setTile(1001, 4, 0, 29926)
	setTile(1001, 4, 1, 29936)
	setTile(1001, 4, 2, 29947)
	setTile(1001, 4, 3, 29964)
	setTile(1001, 4, 4, 29981)
	setTile(1001, 4, 5, 29998)
	setTile(1001, 4, 6, 30015)
	setTile(1001, 4, 7, 30032)
	setTile(1001, 4, 8, 30049)
	setTile(1001, 4, 9, 30451)
	setTile(1001, 4, 10, 30451)
	setTile(1001, 4, 11, 30451)
	setTile(1001, 4, 12, 30451)
	setTile(1001, 4, 13, 30451)
	setTile(1001, 4, 14, 30451)
	setTile(1001, 5, 0, 29926)
	setTile(1001, 5, 1, 29936)
	setTile(1001, 5, 2, 29948)
	setTile(1001, 5, 3, 29965)
	setTile(1001, 5, 4, 29982)
	setTile(1001, 5, 5, 29999)
	setTile(1001, 5, 6, 30016)
	setTile(1001, 5, 7, 30033)
	setTile(1001, 5, 8, 30050)
	setTile(1001, 5, 9, 30451)
	setTile(1001, 5, 10, 30451)
	setTile(1001, 5, 11, 30451)
	setTile(1001, 5, 12, 30451)
	setTile(1001, 5, 13, 30451)
	setTile(1001, 5, 14, 30451)
	setTile(1001, 6, 0, 29926)
	setTile(1001, 6, 1, 29936)
	setTile(1001, 6, 2, 29949)
	setTile(1001, 6, 3, 29966)
	setTile(1001, 6, 4, 29983)
	setTile(1001, 6, 5, 30000)
	setTile(1001, 6, 6, 30017)
	setTile(1001, 6, 7, 30034)
	setTile(1001, 6, 8, 30051)
	setTile(1001, 6, 9, 30451)
	setTile(1001, 6, 10, 30451)
	setTile(1001, 6, 11, 30451)
	setTile(1001, 6, 12, 30451)
	setTile(1001, 6, 13, 30451)
	setTile(1001, 6, 14, 30451)
	setTile(1001, 7, 0, 29926)
	setTile(1001, 7, 1, 29936)
	setTile(1001, 7, 2, 29950)
	setTile(1001, 7, 3, 29967)
	setTile(1001, 7, 4, 29984)
	setTile(1001, 7, 5, 30001)
	setTile(1001, 7, 6, 30018)
	setTile(1001, 7, 7, 30035)
	setTile(1001, 7, 8, 30052)
	setTile(1001, 7, 9, 30451)
	setTile(1001, 7, 10, 30451)
	setTile(1001, 7, 11, 30451)
	setTile(1001, 7, 12, 30451)
	setTile(1001, 7, 13, 30451)
	setTile(1001, 7, 14, 30451)
	setTile(1001, 8, 0, 29926)
	setTile(1001, 8, 1, 29936)
	setTile(1001, 8, 2, 29951)
	setTile(1001, 8, 3, 29968)
	setTile(1001, 8, 4, 29985)
	setTile(1001, 8, 5, 30002)
	setTile(1001, 8, 6, 30019)
	setTile(1001, 8, 7, 30036)
	setTile(1001, 8, 8, 30053)
	setTile(1001, 8, 9, 30451)
	setTile(1001, 8, 10, 30451)
	setTile(1001, 8, 11, 30451)
	setTile(1001, 8, 12, 30451)
	setTile(1001, 8, 13, 30451)
	setTile(1001, 8, 14, 30451)
	setTile(1001, 9, 0, 29926)
	setTile(1001, 9, 1, 29936)
	setTile(1001, 9, 2, 29952)
	setTile(1001, 9, 3, 29969)
	setTile(1001, 9, 4, 29986)
	setTile(1001, 9, 5, 30003)
	setTile(1001, 9, 6, 30020)
	setTile(1001, 9, 7, 30037)
	setTile(1001, 9, 8, 30054)
	setTile(1001, 9, 9, 30451)
	setTile(1001, 9, 10, 30451)
	setTile(1001, 9, 11, 30451)
	setTile(1001, 9, 12, 30451)
	setTile(1001, 9, 13, 30451)
	setTile(1001, 9, 14, 30451)
	setTile(1001, 10, 0, 29926)
	setTile(1001, 10, 1, 29936)
	setTile(1001, 10, 2, 29953)
	setTile(1001, 10, 3, 29970)
	setTile(1001, 10, 4, 29987)
	setTile(1001, 10, 5, 30004)
	setTile(1001, 10, 6, 30021)
	setTile(1001, 10, 7, 30038)
	setTile(1001, 10, 8, 30055)
	setTile(1001, 10, 9, 30451)
	setTile(1001, 10, 10, 30451)
	setTile(1001, 10, 11, 30451)
	setTile(1001, 10, 12, 30451)
	setTile(1001, 10, 13, 30451)
	setTile(1001, 10, 14, 30451)
	setTile(1001, 11, 0, 29926)
	setTile(1001, 11, 1, 29937)
	setTile(1001, 11, 2, 29954)
	setTile(1001, 11, 3, 29971)
	setTile(1001, 11, 4, 29988)
	setTile(1001, 11, 5, 30005)
	setTile(1001, 11, 6, 30022)
	setTile(1001, 11, 7, 30039)
	setTile(1001, 11, 8, 30056)
	setTile(1001, 11, 9, 30451)
	setTile(1001, 11, 10, 30451)
	setTile(1001, 11, 11, 30451)
	setTile(1001, 11, 12, 30451)
	setTile(1001, 11, 13, 30451)
	setTile(1001, 11, 14, 30451)
	setTile(1001, 12, 0, 29927)
	setTile(1001, 12, 1, 29938)
	setTile(1001, 12, 2, 29955)
	setTile(1001, 12, 3, 29972)
	setTile(1001, 12, 4, 29989)
	setTile(1001, 12, 5, 30006)
	setTile(1001, 12, 6, 30023)
	setTile(1001, 12, 7, 30040)
	setTile(1001, 12, 8, 30057)
	setTile(1001, 12, 9, 30451)
	setTile(1001, 12, 10, 30451)
	setTile(1001, 12, 11, 30451)
	setTile(1001, 12, 12, 30451)
	setTile(1001, 12, 13, 30451)
	setTile(1001, 12, 14, 30451)
	setTile(1001, 13, 0, 29928)
	setTile(1001, 13, 1, 29939)
	setTile(1001, 13, 2, 29956)
	setTile(1001, 13, 3, 29973)
	setTile(1001, 13, 4, 29990)
	setTile(1001, 13, 5, 30007)
	setTile(1001, 13, 6, 30024)
	setTile(1001, 13, 7, 30041)
	setTile(1001, 13, 8, 30058)
	setTile(1001, 13, 9, 30451)
	setTile(1001, 13, 10, 30451)
	setTile(1001, 13, 11, 30451)
	setTile(1001, 13, 12, 30451)
	setTile(1001, 13, 13, 30451)
	setTile(1001, 13, 14, 30451)
	setTile(1001, 14, 0, 29929)
	setTile(1001, 14, 1, 29940)
	setTile(1001, 14, 2, 29957)
	setTile(1001, 14, 3, 29974)
	setTile(1001, 14, 4, 29991)
	setTile(1001, 14, 5, 30008)
	setTile(1001, 14, 6, 30025)
	setTile(1001, 14, 7, 30042)
	setTile(1001, 14, 8, 30059)
	setTile(1001, 14, 9, 30451)
	setTile(1001, 14, 10, 30451)
	setTile(1001, 14, 11, 30451)
	setTile(1001, 14, 12, 30451)
	setTile(1001, 14, 13, 30451)
	setTile(1001, 14, 14, 30451)
	setTile(1001, 15, 0, 29930)
	setTile(1001, 15, 1, 29941)
	setTile(1001, 15, 2, 29958)
	setTile(1001, 15, 3, 29975)
	setTile(1001, 15, 4, 29992)
	setTile(1001, 15, 5, 30009)
	setTile(1001, 15, 6, 30026)
	setTile(1001, 15, 7, 30043)
	setTile(1001, 15, 8, 30060)
	setTile(1001, 15, 9, 30064)
	setTile(1001, 15, 10, 30451)
	setTile(1001, 15, 11, 30451)
	setTile(1001, 15, 12, 30451)
	setTile(1001, 15, 13, 30451)
	setTile(1001, 15, 14, 30451)
	setTile(1001, 16, 0, 29931)
	setTile(1001, 16, 1, 29942)
	setTile(1001, 16, 2, 29959)
	setTile(1001, 16, 3, 29976)
	setTile(1001, 16, 4, 29993)
	setTile(1001, 16, 5, 30010)
	setTile(1001, 16, 6, 30027)
	setTile(1001, 16, 7, 30044)
	setTile(1001, 16, 8, 30061)
	setTile(1001, 16, 9, 30065)
	setTile(1001, 16, 10, 30451)
	setTile(1001, 16, 11, 30451)
	setTile(1001, 16, 12, 30451)
	setTile(1001, 16, 13, 30451)
	setTile(1001, 16, 14, 30451)
	setPass(1001, 0, 0, 1)
	setPass(1001, 0, 1, 1)
	setPass(1001, 0, 2, 1)
	setPass(1001, 0, 3, 1)
	setPass(1001, 0, 4, 1)
	setPass(1001, 0, 5, 1)
	setPass(1001, 0, 6, 1)
	setPass(1001, 0, 7, 1)
	setPass(1001, 0, 8, 1)
	setPass(1001, 0, 9, 1)
	setPass(1001, 0, 10, 1)
	setPass(1001, 0, 11, 1)
	setPass(1001, 0, 12, 0)
	setPass(1001, 0, 13, 0)
	setPass(1001, 0, 14, 0)
	setPass(1001, 1, 0, 1)
	setPass(1001, 1, 1, 1)
	setPass(1001, 1, 2, 1)
	setPass(1001, 1, 3, 1)
	setPass(1001, 1, 4, 1)
	setPass(1001, 1, 5, 1)
	setPass(1001, 1, 6, 1)
	setPass(1001, 1, 7, 1)
	setPass(1001, 1, 8, 1)
	setPass(1001, 1, 9, 1)
	setPass(1001, 1, 10, 1)
	setPass(1001, 1, 11, 0)
	setPass(1001, 1, 12, 0)
	setPass(1001, 1, 13, 0)
	setPass(1001, 1, 14, 0)
	setPass(1001, 2, 0, 1)
	setPass(1001, 2, 1, 1)
	setPass(1001, 2, 2, 1)
	setPass(1001, 2, 3, 1)
	setPass(1001, 2, 4, 1)
	setPass(1001, 2, 5, 1)
	setPass(1001, 2, 6, 1)
	setPass(1001, 2, 7, 1)
	setPass(1001, 2, 8, 1)
	setPass(1001, 2, 9, 0)
	setPass(1001, 2, 10, 0)
	setPass(1001, 2, 11, 0)
	setPass(1001, 2, 12, 0)
	setPass(1001, 2, 13, 0)
	setPass(1001, 2, 14, 0)
	setPass(1001, 3, 0, 1)
	setPass(1001, 3, 1, 1)
	setPass(1001, 3, 2, 1)
	setPass(1001, 3, 3, 1)
	setPass(1001, 3, 4, 1)
	setPass(1001, 3, 5, 1)
	setPass(1001, 3, 6, 1)
	setPass(1001, 3, 7, 1)
	setPass(1001, 3, 8, 1)
	setPass(1001, 3, 9, 0)
	setPass(1001, 3, 10, 0)
	setPass(1001, 3, 11, 0)
	setPass(1001, 3, 12, 0)
	setPass(1001, 3, 13, 0)
	setPass(1001, 3, 14, 0)
	setPass(1001, 4, 0, 1)
	setPass(1001, 4, 1, 1)
	setPass(1001, 4, 2, 1)
	setPass(1001, 4, 3, 1)
	setPass(1001, 4, 4, 1)
	setPass(1001, 4, 5, 1)
	setPass(1001, 4, 6, 1)
	setPass(1001, 4, 7, 1)
	setPass(1001, 4, 8, 1)
	setPass(1001, 4, 9, 0)
	setPass(1001, 4, 10, 0)
	setPass(1001, 4, 11, 0)
	setPass(1001, 4, 12, 0)
	setPass(1001, 4, 13, 0)
	setPass(1001, 4, 14, 0)
	setPass(1001, 5, 0, 1)
	setPass(1001, 5, 1, 1)
	setPass(1001, 5, 2, 1)
	setPass(1001, 5, 3, 1)
	setPass(1001, 5, 4, 1)
	setPass(1001, 5, 5, 1)
	setPass(1001, 5, 6, 1)
	setPass(1001, 5, 7, 1)
	setPass(1001, 5, 8, 1)
	setPass(1001, 5, 9, 0)
	setPass(1001, 5, 10, 0)
	setPass(1001, 5, 11, 0)
	setPass(1001, 5, 12, 0)
	setPass(1001, 5, 13, 0)
	setPass(1001, 5, 14, 0)
	setPass(1001, 6, 0, 1)
	setPass(1001, 6, 1, 1)
	setPass(1001, 6, 2, 1)
	setPass(1001, 6, 3, 1)
	setPass(1001, 6, 4, 1)
	setPass(1001, 6, 5, 1)
	setPass(1001, 6, 6, 1)
	setPass(1001, 6, 7, 1)
	setPass(1001, 6, 8, 1)
	setPass(1001, 6, 9, 0)
	setPass(1001, 6, 10, 0)
	setPass(1001, 6, 11, 0)
	setPass(1001, 6, 12, 0)
	setPass(1001, 6, 13, 0)
	setPass(1001, 6, 14, 0)
	setPass(1001, 7, 0, 1)
	setPass(1001, 7, 1, 1)
	setPass(1001, 7, 2, 1)
	setPass(1001, 7, 3, 1)
	setPass(1001, 7, 4, 1)
	setPass(1001, 7, 5, 1)
	setPass(1001, 7, 6, 1)
	setPass(1001, 7, 7, 1)
	setPass(1001, 7, 8, 1)
	setPass(1001, 7, 9, 0)
	setPass(1001, 7, 10, 0)
	setPass(1001, 7, 11, 0)
	setPass(1001, 7, 12, 0)
	setPass(1001, 7, 13, 0)
	setPass(1001, 7, 14, 0)
	setPass(1001, 8, 0, 1)
	setPass(1001, 8, 1, 1)
	setPass(1001, 8, 2, 1)
	setPass(1001, 8, 3, 1)
	setPass(1001, 8, 4, 1)
	setPass(1001, 8, 5, 1)
	setPass(1001, 8, 6, 1)
	setPass(1001, 8, 7, 1)
	setPass(1001, 8, 8, 1)
	setPass(1001, 8, 9, 0)
	setPass(1001, 8, 10, 0)
	setPass(1001, 8, 11, 0)
	setPass(1001, 8, 12, 0)
	setPass(1001, 8, 13, 0)
	setPass(1001, 8, 14, 0)
	setPass(1001, 9, 0, 1)
	setPass(1001, 9, 1, 1)
	setPass(1001, 9, 2, 1)
	setPass(1001, 9, 3, 1)
	setPass(1001, 9, 4, 1)
	setPass(1001, 9, 5, 1)
	setPass(1001, 9, 6, 1)
	setPass(1001, 9, 7, 1)
	setPass(1001, 9, 8, 1)
	setPass(1001, 9, 9, 0)
	setPass(1001, 9, 10, 0)
	setPass(1001, 9, 11, 0)
	setPass(1001, 9, 12, 0)
	setPass(1001, 9, 13, 0)
	setPass(1001, 9, 14, 0)
	setPass(1001, 10, 0, 1)
	setPass(1001, 10, 1, 1)
	setPass(1001, 10, 2, 1)
	setPass(1001, 10, 3, 1)
	setPass(1001, 10, 4, 1)
	setPass(1001, 10, 5, 1)
	setPass(1001, 10, 6, 1)
	setPass(1001, 10, 7, 1)
	setPass(1001, 10, 8, 1)
	setPass(1001, 10, 9, 0)
	setPass(1001, 10, 10, 0)
	setPass(1001, 10, 11, 0)
	setPass(1001, 10, 12, 0)
	setPass(1001, 10, 13, 0)
	setPass(1001, 10, 14, 0)
	setPass(1001, 11, 0, 1)
	setPass(1001, 11, 1, 1)
	setPass(1001, 11, 2, 1)
	setPass(1001, 11, 3, 1)
	setPass(1001, 11, 4, 1)
	setPass(1001, 11, 5, 1)
	setPass(1001, 11, 6, 1)
	setPass(1001, 11, 7, 1)
	setPass(1001, 11, 8, 1)
	setPass(1001, 11, 9, 0)
	setPass(1001, 11, 10, 0)
	setPass(1001, 11, 11, 0)
	setPass(1001, 11, 12, 0)
	setPass(1001, 11, 13, 0)
	setPass(1001, 11, 14, 0)
	setPass(1001, 12, 0, 1)
	setPass(1001, 12, 1, 1)
	setPass(1001, 12, 2, 1)
	setPass(1001, 12, 3, 1)
	setPass(1001, 12, 4, 1)
	setPass(1001, 12, 5, 1)
	setPass(1001, 12, 6, 1)
	setPass(1001, 12, 7, 1)
	setPass(1001, 12, 8, 1)
	setPass(1001, 12, 9, 0)
	setPass(1001, 12, 10, 0)
	setPass(1001, 12, 11, 0)
	setPass(1001, 12, 12, 0)
	setPass(1001, 12, 13, 0)
	setPass(1001, 12, 14, 0)
	setPass(1001, 13, 0, 1)
	setPass(1001, 13, 1, 1)
	setPass(1001, 13, 2, 1)
	setPass(1001, 13, 3, 1)
	setPass(1001, 13, 4, 1)
	setPass(1001, 13, 5, 1)
	setPass(1001, 13, 6, 1)
	setPass(1001, 13, 7, 1)
	setPass(1001, 13, 8, 1)
	setPass(1001, 13, 9, 0)
	setPass(1001, 13, 10, 0)
	setPass(1001, 13, 11, 0)
	setPass(1001, 13, 12, 0)
	setPass(1001, 13, 13, 0)
	setPass(1001, 13, 14, 0)
	setPass(1001, 14, 0, 1)
	setPass(1001, 14, 1, 1)
	setPass(1001, 14, 2, 1)
	setPass(1001, 14, 3, 1)
	setPass(1001, 14, 4, 1)
	setPass(1001, 14, 5, 1)
	setPass(1001, 14, 6, 1)
	setPass(1001, 14, 7, 1)
	setPass(1001, 14, 8, 1)
	setPass(1001, 14, 9, 0)
	setPass(1001, 14, 10, 0)
	setPass(1001, 14, 11, 0)
	setPass(1001, 14, 12, 0)
	setPass(1001, 14, 13, 0)
	setPass(1001, 14, 14, 0)
	setPass(1001, 15, 0, 1)
	setPass(1001, 15, 1, 1)
	setPass(1001, 15, 2, 1)
	setPass(1001, 15, 3, 1)
	setPass(1001, 15, 4, 1)
	setPass(1001, 15, 5, 1)
	setPass(1001, 15, 6, 1)
	setPass(1001, 15, 7, 1)
	setPass(1001, 15, 8, 1)
	setPass(1001, 15, 9, 0)
	setPass(1001, 15, 10, 0)
	setPass(1001, 15, 11, 0)
	setPass(1001, 15, 12, 0)
	setPass(1001, 15, 13, 0)
	setPass(1001, 15, 14, 0)
	setPass(1001, 16, 0, 1)
	setPass(1001, 16, 1, 1)
	setPass(1001, 16, 2, 1)
	setPass(1001, 16, 3, 1)
	setPass(1001, 16, 4, 1)
	setPass(1001, 16, 5, 1)
	setPass(1001, 16, 6, 1)
	setPass(1001, 16, 7, 1)
	setPass(1001, 16, 8, 1)
	setPass(1001, 16, 9, 1)
	setPass(1001, 16, 10, 0)
	setPass(1001, 16, 11, 0)
	setPass(1001, 16, 12, 0)
	setPass(1001, 16, 13, 0)
	setPass(1001, 16, 14, 0)
end,
}
cosmos_officefloor3 = {
action = function(npc)
	setTile(1001, 0, 0, 29611)
	setTile(1001, 0, 1, 29615)
	setTile(1001, 0, 2, 29628)
	setTile(1001, 0, 3, 29645)
	setTile(1001, 0, 4, 29660)
	setTile(1001, 0, 5, 29662)
	setTile(1001, 0, 6, 29664)
	setTile(1001, 0, 7, 29666)
	setTile(1001, 0, 8, 29338)
	setTile(1001, 0, 9, 29344)
	setTile(1001, 0, 10, 29342)
	setTile(1001, 0, 11, 29344)
	setTile(1001, 0, 12, 29342)
	setTile(1001, 0, 13, 29344)
	setTile(1001, 0, 14, 29346)
	setTile(1001, 1, 0, 29611)
	setTile(1001, 1, 1, 29616)
	setTile(1001, 1, 2, 29629)
	setTile(1001, 1, 3, 29646)
	setTile(1001, 1, 4, 29661)
	setTile(1001, 1, 5, 29662)
	setTile(1001, 1, 6, 29665)
	setTile(1001, 1, 7, 29667)
	setTile(1001, 1, 8, 29340)
	setTile(1001, 1, 9, 29321)
	setTile(1001, 1, 10, 29333)
	setTile(1001, 1, 11, 29321)
	setTile(1001, 1, 12, 29333)
	setTile(1001, 1, 13, 29321)
	setTile(1001, 1, 14, 29348)
	setTile(1001, 2, 0, 29611)
	setTile(1001, 2, 1, 29617)
	setTile(1001, 2, 2, 29630)
	setTile(1001, 2, 3, 29647)
	setTile(1001, 2, 4, 29660)
	setTile(1001, 2, 5, 29662)
	setTile(1001, 2, 6, 29664)
	setTile(1001, 2, 7, 29667)
	setTile(1001, 2, 8, 29339)
	setTile(1001, 2, 9, 29333)
	setTile(1001, 2, 10, 29321)
	setTile(1001, 2, 11, 29333)
	setTile(1001, 2, 12, 29321)
	setTile(1001, 2, 13, 29333)
	setTile(1001, 2, 14, 29347)
	setTile(1001, 3, 0, 29611)
	setTile(1001, 3, 1, 29618)
	setTile(1001, 3, 2, 29631)
	setTile(1001, 3, 3, 29648)
	setTile(1001, 3, 4, 29661)
	setTile(1001, 3, 5, 29663)
	setTile(1001, 3, 6, 29665)
	setTile(1001, 3, 7, 29667)
	setTile(1001, 3, 8, 29340)
	setTile(1001, 3, 9, 29321)
	setTile(1001, 3, 10, 29333)
	setTile(1001, 3, 11, 29321)
	setTile(1001, 3, 12, 29333)
	setTile(1001, 3, 13, 29321)
	setTile(1001, 3, 14, 29348)
	setTile(1001, 4, 0, 29611)
	setTile(1001, 4, 1, 29619)
	setTile(1001, 4, 2, 29632)
	setTile(1001, 4, 3, 29649)
	setTile(1001, 4, 4, 29660)
	setTile(1001, 4, 5, 29662)
	setTile(1001, 4, 6, 29664)
	setTile(1001, 4, 7, 29667)
	setTile(1001, 4, 8, 29339)
	setTile(1001, 4, 9, 29333)
	setTile(1001, 4, 10, 29321)
	setTile(1001, 4, 11, 29333)
	setTile(1001, 4, 12, 29321)
	setTile(1001, 4, 13, 29333)
	setTile(1001, 4, 14, 29347)
	setTile(1001, 5, 0, 29612)
	setTile(1001, 5, 1, 29620)
	setTile(1001, 5, 2, 29633)
	setTile(1001, 5, 3, 29650)
	setTile(1001, 5, 4, 29661)
	setTile(1001, 5, 5, 29662)
	setTile(1001, 5, 6, 29665)
	setTile(1001, 5, 7, 29667)
	setTile(1001, 5, 8, 29340)
	setTile(1001, 5, 9, 29321)
	setTile(1001, 5, 10, 29333)
	setTile(1001, 5, 11, 29321)
	setTile(1001, 5, 12, 29333)
	setTile(1001, 5, 13, 29321)
	setTile(1001, 5, 14, 29348)
	setTile(1001, 6, 0, 29613)
	setTile(1001, 6, 1, 29621)
	setTile(1001, 6, 2, 29634)
	setTile(1001, 6, 3, 29651)
	setTile(1001, 6, 4, 29660)
	setTile(1001, 6, 5, 29662)
	setTile(1001, 6, 6, 29664)
	setTile(1001, 6, 7, 29667)
	setTile(1001, 6, 8, 29339)
	setTile(1001, 6, 9, 29333)
	setTile(1001, 6, 10, 29321)
	setTile(1001, 6, 11, 29333)
	setTile(1001, 6, 12, 29321)
	setTile(1001, 6, 13, 29333)
	setTile(1001, 6, 14, 29347)
	setTile(1001, 7, 0, 29614)
	setTile(1001, 7, 1, 29622)
	setTile(1001, 7, 2, 29635)
	setTile(1001, 7, 3, 29652)
	setTile(1001, 7, 4, 29661)
	setTile(1001, 7, 5, 29662)
	setTile(1001, 7, 6, 29665)
	setTile(1001, 7, 7, 29667)
	setTile(1001, 7, 8, 29340)
	setTile(1001, 7, 9, 29321)
	setTile(1001, 7, 10, 29333)
	setTile(1001, 7, 11, 29321)
	setTile(1001, 7, 12, 29333)
	setTile(1001, 7, 13, 29321)
	setTile(1001, 7, 14, 29348)
	setTile(1001, 8, 0, 29614)
	setTile(1001, 8, 1, 29623)
	setTile(1001, 8, 2, 29636)
	setTile(1001, 8, 3, 29653)
	setTile(1001, 8, 4, 29660)
	setTile(1001, 8, 5, 29662)
	setTile(1001, 8, 6, 29664)
	setTile(1001, 8, 7, 29667)
	setTile(1001, 8, 8, 29339)
	setTile(1001, 8, 9, 29333)
	setTile(1001, 8, 10, 29321)
	setTile(1001, 8, 11, 29333)
	setTile(1001, 8, 12, 29321)
	setTile(1001, 8, 13, 29333)
	setTile(1001, 8, 14, 29347)
	setTile(1001, 9, 0, 29611)
	setTile(1001, 9, 1, 29624)
	setTile(1001, 9, 2, 29637)
	setTile(1001, 9, 3, 29654)
	setTile(1001, 9, 4, 29661)
	setTile(1001, 9, 5, 29663)
	setTile(1001, 9, 6, 29665)
	setTile(1001, 9, 7, 29667)
	setTile(1001, 9, 8, 29340)
	setTile(1001, 9, 9, 29321)
	setTile(1001, 9, 10, 29333)
	setTile(1001, 9, 11, 29321)
	setTile(1001, 9, 12, 29333)
	setTile(1001, 9, 13, 29321)
	setTile(1001, 9, 14, 29348)
	setTile(1001, 10, 0, 29611)
	setTile(1001, 10, 1, 29616)
	setTile(1001, 10, 2, 29638)
	setTile(1001, 10, 3, 29655)
	setTile(1001, 10, 4, 29660)
	setTile(1001, 10, 5, 29662)
	setTile(1001, 10, 6, 29664)
	setTile(1001, 10, 7, 29667)
	setTile(1001, 10, 8, 29339)
	setTile(1001, 10, 9, 29333)
	setTile(1001, 10, 10, 29321)
	setTile(1001, 10, 11, 29333)
	setTile(1001, 10, 12, 29321)
	setTile(1001, 10, 13, 29333)
	setTile(1001, 10, 14, 29347)
	setTile(1001, 11, 0, 29611)
	setTile(1001, 11, 1, 29616)
	setTile(1001, 11, 2, 29639)
	setTile(1001, 11, 3, 29656)
	setTile(1001, 11, 4, 29661)
	setTile(1001, 11, 5, 29663)
	setTile(1001, 11, 6, 29665)
	setTile(1001, 11, 7, 29667)
	setTile(1001, 11, 8, 29340)
	setTile(1001, 11, 9, 29321)
	setTile(1001, 11, 10, 29333)
	setTile(1001, 11, 11, 29321)
	setTile(1001, 11, 12, 29333)
	setTile(1001, 11, 13, 29321)
	setTile(1001, 11, 14, 29348)
	setTile(1001, 12, 0, 29611)
	setTile(1001, 12, 1, 29616)
	setTile(1001, 12, 2, 29640)
	setTile(1001, 12, 3, 29657)
	setTile(1001, 12, 4, 29660)
	setTile(1001, 12, 5, 29662)
	setTile(1001, 12, 6, 29664)
	setTile(1001, 12, 7, 29667)
	setTile(1001, 12, 8, 29339)
	setTile(1001, 12, 9, 29333)
	setTile(1001, 12, 10, 29321)
	setTile(1001, 12, 11, 29333)
	setTile(1001, 12, 12, 29321)
	setTile(1001, 12, 13, 29333)
	setTile(1001, 12, 14, 29347)
	setTile(1001, 13, 0, 29611)
	setTile(1001, 13, 1, 29616)
	setTile(1001, 13, 2, 29641)
	setTile(1001, 13, 3, 29658)
	setTile(1001, 13, 4, 29661)
	setTile(1001, 13, 5, 29662)
	setTile(1001, 13, 6, 29665)
	setTile(1001, 13, 7, 29667)
	setTile(1001, 13, 8, 29340)
	setTile(1001, 13, 9, 29321)
	setTile(1001, 13, 10, 29333)
	setTile(1001, 13, 11, 29321)
	setTile(1001, 13, 12, 29333)
	setTile(1001, 13, 13, 29321)
	setTile(1001, 13, 14, 29348)
	setTile(1001, 14, 0, 29611)
	setTile(1001, 14, 1, 29616)
	setTile(1001, 14, 2, 29642)
	setTile(1001, 14, 3, 29659)
	setTile(1001, 14, 4, 29660)
	setTile(1001, 14, 5, 29663)
	setTile(1001, 14, 6, 29664)
	setTile(1001, 14, 7, 29667)
	setTile(1001, 14, 8, 29339)
	setTile(1001, 14, 9, 29333)
	setTile(1001, 14, 10, 29321)
	setTile(1001, 14, 11, 29333)
	setTile(1001, 14, 12, 29321)
	setTile(1001, 14, 13, 29333)
	setTile(1001, 14, 14, 29347)
	setTile(1001, 15, 0, 29611)
	setTile(1001, 15, 1, 29616)
	setTile(1001, 15, 2, 29643)
	setTile(1001, 15, 3, 29659)
	setTile(1001, 15, 4, 29661)
	setTile(1001, 15, 5, 29662)
	setTile(1001, 15, 6, 29665)
	setTile(1001, 15, 7, 29667)
	setTile(1001, 15, 8, 29340)
	setTile(1001, 15, 9, 29321)
	setTile(1001, 15, 10, 29333)
	setTile(1001, 15, 11, 29321)
	setTile(1001, 15, 12, 29333)
	setTile(1001, 15, 13, 29321)
	setTile(1001, 15, 14, 29348)
	setTile(1001, 16, 0, 29611)
	setTile(1001, 16, 1, 29616)
	setTile(1001, 16, 2, 29644)
	setTile(1001, 16, 3, 29659)
	setTile(1001, 16, 4, 29660)
	setTile(1001, 16, 5, 29662)
	setTile(1001, 16, 6, 29665)
	setTile(1001, 16, 7, 29667)
	setTile(1001, 16, 8, 29341)
	setTile(1001, 16, 9, 29345)
	setTile(1001, 16, 10, 29343)
	setTile(1001, 16, 11, 29345)
	setTile(1001, 16, 12, 29343)
	setTile(1001, 16, 13, 29345)
	setTile(1001, 16, 14, 29349)
end,
}



--[[

	Search Commands
	Map:		:getObjectsMap(#map, #type)
	Screen:		:getObject(#map, #x, #y)

--			:talk(0, "") -- White Speech Bubble
--			:talk(1, "") -- Yellow Speech Bubble
--			:talk(2, "") -- Dark Blue Speech Bubble
--			:talk(3, "") -- Light Blue Speech Bubble

--			:msg(0, "") -- Whisper Chat Box
--			:msg(2, "") -- Status Box
--			:msg(3, "") -- Status Box
--			:msg(4, "") -- Shout Chat Box
--			:msg(5, "") -- System Chat Box
--			:msg(8, "") -- Small Popup
--			:msg(11, "") -- Group Chat Box
--			:msg(12, "") -- Clan Chat Box

	Max Lines
		player:sendMinitext("12345678912345678912345678")
							"-=(-=(-=(-=(--)=-)=-)=-)=-"
							"     You have one already."

		player:dialogSeq({npcA, "123456789-123456789-123456789-"}, 1)
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"
								"123456789-123456789-123456789-"

		player:msg(8, "----------------------------------------", player.ID)

		sendMinitext
			"--------------------------"
		dialogSeq
			"------------------------------"
		Msg8
			"----------------------------------------"


-- PLAYER.CHECKEQUIP & INV FOR WEAPON - Will ADD if you have none.
	elseif (lspeech == "test3") then
		local w_yname = Item(######).yname
		local w_id = Item(######).id
		local cWeap = player:getEquippedItem(EQ_WEAP)
		local cWeapid = cWeap.id

		if (cWeap == nil) then
			if (player:hasItem("..w_yname..",1) ~= true) then
				player:addItem("..w_yname..", 1)
			else
					player:sendMinitext(" ((You have one already.))")
			end
		else
			if (tonumber(cWeapid) == w_id) then
				player:sendMinitext("   ((You're wearing one.))")
			else
				if (player:hasItem(""..w_yname.."",1) ~= true) then
					player:addItem("..w_yname..", 1)
				else
					player:sendMinitext(" ((You have one already.))")
				end
			end
		end
-- PLAYER.CHECKEQUIP & INV FOR WEAPON - Will REMOVE if you have one.
	elseif (lspeech == "test2") then

		local w_yname = Item(######).yname
		local w_id = Item(######).id
		local cWeap = player:getEquippedItem(EQ_WEAP)
		local cWeapid = cWeap.id

		if (cWeap == nil) then
			if (player:hasItem("..w_yname..",1) == true) then
				player:removeItem("..w_yname..", 1)
			else
				player:sendMinitext(" ((You have one already.))")
			end
		else
			if (tonumber(cWeap.id) == Item(40310).id) then
				player:sendMinitext("   ((You're wearing one.))")

			else
				if (player:hasItem("..w_yname..",1) == true) then
					player:removeItem("..w_yname..", 1)
				else
					player:sendMinitext(" ((You have one already.))")
				end
			end
		end

-- Subpaths ::

	-- Guild Master Code
		elseif (mainMenu == "- Warrior Subpaths") then
			if (player.quest["warrior_pickSubpath"] >= 2) then
				player:dialogSeq({npcA, "Have you picked one yet?"}, 0)	
			elseif (player.quest["warrior_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Gladiator") == true) then
					if (player:hasLegend("repSubQ_Knight") == true) then
						player.quest["warrior_pickSubpath"] = player.quest["warrior_pickSubpath"] + 1
						player:dialogSeq({npcA, "Well, I see you've learned from both of the paths.",
						npcA, "Take some time and contemplate, which of these two paths you feel most akin to.",
						npcA, "Once you've made your decision head back to that paths representative and seek admittance.",
						npcA, "Good job, and good luck "..player.name.."."}, 0)
					else
						player:dialogSeq({npcA, "You haven't visited both representatives yet!",
							npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
					end
				else
					player:dialogSeq({npcA, "You haven't visited both representatives yet!",
						npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
				end
			elseif (player.quest["warrior_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({npcA, "So, you're interested in joining a Subpath are you?",
				npcA, "There are two within each main path. For the fighters, warriors of the Empire, you can either become a Knight or Gladiator."}, 1)
				player.lastClick = NPC(136).ID
				player:dialogSeq({npcB, "The Knights.\n\nThey fight for justice, the ones who are at the front line. Ready to defend and protect the Empire and its people."}, 1)
				player.lastClick = NPC(135).ID
				player:dialogSeq({npcB, "The Gladiators.\n\nSavage tacticians, known for slaughtering all in their sight. They're hungry for bloodshed and eager to lay waste to those who challenge them."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["warrior_pickSubpath"] = player.quest["warrior_pickSubpath"] + 1 	
				player:dialogSeq({npcA, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
		elseif (mainMenu == "- Rogue Subpaths") then
			if (player.quest["rogue_pickSubpath"] >= 2) then
				player:dialogSeq({npcA, "Have you picked one yet?"}, 0)	
			elseif (player.quest["rogue_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Archer") == true) then
					if (player:hasLegend("repSubQ_Shadow") == true) then
						player.quest["rogue_pickSubpath"] = player.quest["rogue_pickSubpath"] + 1
						player:dialogSeq({npcA, "Well, I see you've learned from both of the paths.",
						npcA, "Take some time and contemplate, which of these two paths you feel most akin to.",
						npcA, "Once you've made your decision head back to that paths representative and seek admittance.",
						npcA, "Good job, and good luck "..player.name.."."}, 0)
					else
						player:dialogSeq({npcA, "You haven't visited both representatives yet!",
							npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
					end
				else
					player:dialogSeq({npcA, "You haven't visited both representatives yet!",
						npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
				end

			elseif (player.quest["rogue_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({npcA, "So, you're interested in joining a Subpath are you?",
				npcA, "There are two within each main path. For the nimble, rogues of the Empire, you can either become a Shadow or Archer."}, 1)
				player.lastClick = NPC(134).ID
				player:dialogSeq({npcB, "The Shadows.\n\nSecluded and surprisingly scarce. They are the assassins of Han, trained in the silent art of killing.. a deadly combatant."}, 1)
				player.lastClick = NPC(133).ID
				player:dialogSeq({npcB, "The Archers.\n\nAgile huntsmen and profound foragers. Most often seen with a bow, they are masters of archery."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["rogue_pickSubpath"] = player.quest["rogue_pickSubpath"] + 1 	
				player:dialogSeq({npcA, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
		elseif (mainMenu == "- Mage Subpaths") then
			if (player.quest["mage_pickSubpath"] >= 2) then
				player:dialogSeq({npcA, "Have you picked one yet?"}, 0)	
			elseif (player.quest["mage_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Elementalist") == true) then
					if (player:hasLegend("repSubQ_Seer") == true) then
						player.quest["mage_pickSubpath"] = player.quest["mage_pickSubpath"] + 1
						player:dialogSeq({npcA, "Well, I see you've learned from both of the paths.",
						npcA, "Take some time and contemplate, which of these two paths you feel most akin to.",
						npcA, "Once you've made your decision head back to that paths representative and seek admittance.",
						npcA, "Good job, and good luck "..player.name.."."}, 0)
					else
						player:dialogSeq({npcA, "You haven't visited both representatives yet!",
							npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
					end
				else
					player:dialogSeq({npcA, "You haven't visited both representatives yet!",
						npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
				end
			elseif (player.quest["mage_pickSubpath"] == 0) then
				player:dialogSeq({npcA, "So, you're interested in joining a Subpath are you?",
				npcA, "There are two within each main path. For the magicians, mages of the Empire you can either become a Seer or Elementalist."}, 1)
				player.dialogType = 1
				player.lastClick = NPC(127).ID
				player:dialogSeq({npcB, "The Seers are a group of mystics, known for their Divine powers and indepth sight-skillings."}, 1)
				player.lastClick = NPC(132).ID
				player:dialogSeq({npcB, "The Elementalist people are ones who focus on the elements of the lands. Most known for their works with Fire and Ice."}, 1)
				player.lastClick = NPC(113).ID
				player.dialogType = 0
				player.quest["mage_pickSubpath"] = player.quest["mage_pickSubpath"] + 1 	
				player:dialogSeq({npcA, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end
		elseif (mainMenu == "- Poet Subpaths") then
			if (player.quest["poet_pickSubpath"] >= 2) then
				player:dialogSeq({npcA, "Have you picked one yet?"}, 0)	
			elseif (player.quest["poet_pickSubpath"] == 1) then
				if (player:hasLegend("repSubQ_Druid") == true) then
					if (player:hasLegend("repSubQ_Bard") == true) then
						player.quest["poet_pickSubpath"] = player.quest["poet_pickSubpath"] + 1
						player:dialogSeq({npcA, "Well, I see you've learned from both of the paths.",
						npcA, "Take some time and contemplate, which of these two paths you feel most akin to.",
						npcA, "Once you've made your decision head back to that paths representative and seek admittance.",
						npcA, "Good job, and good luck "..player.name.."."}, 0)
					else
						player:dialogSeq({npcA, "You haven't visited both representatives yet!",
							npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
					end
				else
					player:dialogSeq({npcA, "You haven't visited both representatives yet!",
						npcA, "Come back to me ONLY when you've met with both and completed both tasks."}, 0)
				end

			elseif (player.quest["poet_pickSubpath"] == 0) then
				player.dialogType = 1
				player:dialogSeq({npcA, "So, you're interested in joining a Subpath are you?",
				npcA, "There are two within each main path. For the healers, poets of the Empire you can either become a Bard or Druid."}, 1)
				player.lastClick = NPC(129).ID
				player:dialogSeq({npcB, "The Druid people are one with the earth, they devote themselves to binding their lives with large Ent-like creatures."}, 1)
				player.lastClick = NPC(131).ID
				player:dialogSeq({npcB, "The Bards on the other hand, are known for their musical gifts. They are the ones who use songs, chants and other mediums for spiritual and fighting purposes."}, 1)
				player.dialogType = 0
				player.lastClick = NPC(113).ID
				player.quest["poet_pickSubpath"] = player.quest["poet_pickSubpath"] + 1 	
				player:dialogSeq({npcA, "Seek out both representatives for each path and complete a small task for them. Once you've done this come back and see me."}, 0)
			end

	-- Quest Status
		elseif (lspeech == "warriorcheck") then
			player:talk(0, "rQ_Knight Q: "..player.quest["rQ_Knight"].."")
			player:talk(0, "rQ_KnightEscort Q: "..player.quest["rQ_KnightEscort"].."")
			player:talk(0, "warrior_pickSubpath Q = "..player.quest["warrior_pickSubpath"].."")	
			player:talk(0, "rQ_Gladiator Q: "..player.quest["rQ_Gladiator"].."")
			player:sendMinitext("Registries Reset.")
		elseif (lspeech == "roguecheck") then
			player:talk(0, "rQ_Archer Q: "..player.quest["rQ_Archer"].."")
			player:talk(0, "rQ_ArcherFawn Q: "..player.quest["rQ_ArcherFawn"].."")
			player:talk(0, "rogue_pickSubpath Q = "..player.quest["rogue_pickSubpath"].."")	
			player:talk(0, "rQ_Shadow Q: "..player.quest["rQ_Shadow"].."")
		elseif (lspeech == "magecheck") then
			player:talk(0, "rQ_Seer Q: "..player.quest["rQ_Seer"].."")
			player:talk(0, "rQ_Seer R: "..player.registry["rQ_Seer"].."")
			player:talk(0, "rQ_Elementalist Q: "..player.quest["rQ_Elementalist"].."")
			player:talk(0, "rQ_Elementalist R:" ..player.registry["rQ_Elementalist"].."")
			player:talk(0, "rQ_seerT1 R:"..player.registry["rQ_seerT1"].."")
			player:talk(0, "rQ_seerT2 R:"..player.registry["rQ_seerT2"].."")
			player:talk(0, "rQ_seerT3 R:"..player.registry["rQ_seerT3"].."")
			player:talk(0, "mage_pickSubpath Q:"..player.quest["mage_pickSubpath"].."")
			player:talk(0, "rQ_elementalistT1 R:"..player.registry["rQ_elementalistT1"].."")
			player:talk(0, "rQ_elementalistT2 R:"..player.registry["rQ_elementalistT2"].."")
			player:talk(0, "rQ_elementalistT3 R:"..player.registry["rQ_elementalistT3"].."")
			player:talk(0, "rQ_elementalistT4 R:"..player.registry["rQ_elementalistT3"].."")
		elseif (lspeech == "poetcheck") then
			player:talk(0, "rQ_Bard Q: "..player.quest["rQ_Bard"].."")
			player:talk(0, "rQ_Bard R: "..player.registry["rQ_Bard"].."")
			player:talk(0, "rQ_Druid Q: "..player.quest["rQ_Druid"].."")
			player:talk(0, "rQ_Druid R:" ..player.registry["rQ_Druid"].."")
			player:talk(0, "rQBardnpc1 R:"..player.registry["rQBardnpc1"].."")
			player:talk(0, "rQBardnpc2 R:"..player.registry["rQBardnpc2"].."")
			player:talk(0, "rQBardnpc3 R:"..player.registry["rQBardnpc3"].."")
			player:talk(0, "rQBardnpc4 R:"..player.registry["rQBardnpc4"].."")
			player:talk(0, "poet_pickSubpath Q:"..player.quest["poet_pickSubpath"].."")
		elseif (lspeech == "warriorreset") then
			player.quest["rQ_Knight"] = 0
			player.quest["rQ_KnightEscort"] = 0
			player.quest["warrior_pickSubpath"] = 0
			player.quest["rQ_Gladiator"] = 0
			player:removeLegendbyName("repSubQ_Knight")
			player:removeLegendbyName("repSubQ_Gladiator")
			player:sendMinitext("Registries Reset.")
		elseif (lspeech == "roguereset") then
			player.quest["rQ_Archer"] = 0
			player.quest["rQ_ArcherFawn"] = 0
			player.quest["rQ_Shadow"] = 0
			player.quest["rogue_pickSubpath"] = 0
			player:removeLegendbyName("repSubQ_Archer")
			player:removeLegendbyName("repSubQ_Shadow")
			player:sendMinitext("Registries Reset.")
		elseif (lspeech == "magereset") then
			player.quest["rQ_Seer"] = 0
			player.registry["rQ_Seer"] = 0
			player.quest["rQ_Elementalist"] = 0
			player.registry["rQ_Elementalist"] = 0
			player.registry["rQ_seerT1"] = 0
			player.registry["rQ_seerT2"] = 0
			player.registry["rQ_seerT3"] = 0
			player.quest["mage_pickSubpath"] = 0
			player.registry["rQ_elementalistT1"] = 0
			player.registry["rQ_elementalistT2"] = 0
			player.registry["rQ_elementalistT3"] = 0
			player.registry["rQ_elementalistT4"] = 0
			player:sendMinitext("Registries Reset.")
		elseif (lspeech == "poetreset") then
			player.quest["rQ_Bard"] = 0
			player.registry["rQ_Bard"] = 0
			player.quest["rQ_Druid"] = 0
			player.registry["rQ_Druid"] = 0
			player.registry["rQBardnpc1"] = 0
			player.registry["rQBardnpc2"] = 0
			player.registry["rQBardnpc3"] = 0
			player.registry["rQBardnpc4"] = 0
			player.quest["poet_pickSubpath"] = 0
			player:sendMinitext("Registries Reset.")

	-- Legend Marks
		elseif (lspeech == "testcode0") then
			player:addLegend("Has learned about the Knight path.", "repSubQ_Knight", 3, 1)
			player:addLegend("Has learned about the Gladiator path.", "repSubQ_Gladiator", 3, 1)
			player:addLegend("Has learned about the Shadow path.", "repSubQ_Shadow", 3, 1)
			player:addLegend("Has learned about the Archer path.", "repSubQ_Archer", 3, 1)
			player:addLegend("Has learned about the Elementalist path.", "repSubQ_Elementalist", 3, 1)
			player:addLegend("Has learned about the Seer path.", "repSubQ_Seer", 3, 1)
			player:addLegend("Has learned about the Druid path.", "repSubQ_Druid", 3, 1)
			player:addLegend("Has learned about the Bard path.", "repSubQ_Bard", 3, 1)
		elseif (lspeech == "testcode1") then
			player:removeLegendbyName("repSubQ_Knight")
			player:removeLegendbyName("repSubQ_Gladiator")
			player:removeLegendbyName("repSubQ_Shadow")
			player:removeLegendbyName("repSubQ_Archer")
			player:removeLegendbyName("repSubQ_Elementalist")
			player:removeLegendbyName("repSubQ_Seer")
			player:removeLegendbyName("repSubQ_Druid")
			player:removeLegendbyName("repSubQ_Bard")
		elseif (lspeech == "testcode2") then
			player:addLegend("Inner potential of the Knight discovered. "..curT().."", "Knight_Joined", 149, 1)
			player:addLegend("Inner potential of the Gladiator discovered. "..curT().."", "Gladiator_Joined", 51, 1)
			player:addLegend("Inner potential of the Shadow discovered. "..curT().."", "Shadow_Joined", 22, 1)
			player:addLegend("Inner potential of the Archer discovered. "..curT().."", "Archer_Joined", 212, 1)
			player:addLegend("Inner potential of the Elementalist discovered. "..curT().."", "Elementalist_Joined", 145, 1)
			player:addLegend("Inner potential of the Seer discovered. "..curT().."", "Seer_Joined", 202, 1)
			player:addLegend("Inner potential of the Druid discovered. "..curT().."", "Druid_Joined", 130, 1)
			player:addLegend("Inner potential of the Bard discovered. "..curT().."", "Bard_Joined", 96, 1)
		elseif (lspeech == "testcode3") then
			player:removeLegendbyName("Knight_Joined")
			player:removeLegendbyName("Gladiator_Joined")
			player:removeLegendbyName("Shadow_Joined")
			player:removeLegendbyName("Archer_Joined")
			player:removeLegendbyName("Elementalist_Joined")
			player:removeLegendbyName("Seer_Joined")
			player:removeLegendbyName("Bard_Joined")
			player:removeLegendbyName("Druid_Joined")
]]--

