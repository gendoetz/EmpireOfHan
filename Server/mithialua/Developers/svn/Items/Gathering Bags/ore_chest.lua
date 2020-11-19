ore_chest = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=1}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = { }
				table.insert(opts,"Tin")
				table.insert(opts,"Copper")
				table.insert(opts,"Iron")
				table.insert(opts,"Platinum")
				table.insert(opts,"Titanium")


			
		local choice=player:menuString3("Which would you like to store?", opts)
			if (choice == "Copper") then
				if(player:hasItem("copper_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Copper ore before you can store this material.")
					return
				end
				player:removeItem("copper_ore",100)
				player:removeItem("ore_chest",1)
				player:sendMinitext("You stuff your Copper Ore into the empty chest.")
				player:addItem("chest_copperi",1)


			elseif (choice == "Tin") then
				if (player:hasItem("tin_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Tin ore before you can store this material.")
					return
				end
				player:removeItem("tin_ore",100)
				player:removeItem("ore_chest",1)
				player:sendMinitext("You stuff your Tin Ore into the empty chest.")
				player:addItem("chest_tini",1)

			elseif (choice == "Iron") then
				if (player:hasItem("iron_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Iron ore before you can store this material.")
					return
				end
				player:removeItem("iron_ore",100)
				player:removeItem("ore_chest",1)
				player:sendMinitext("You stuff your Iron Ore into the empty chest.")
				player:addItem("chest_ironi",1)

			elseif (choice == "Platinum") then
				if (player:hasItem("platinum_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Platinum ore before you can store this material.")
					return
				end
				player:removeItem("platinum_ore",100)
				player:removeItem("ore_chest",1)
				player:sendMinitext("You stuff your Platinum Ore into the empty chest.")
				player:addItem("chest_platinumi",1)

			elseif (choice == "Titanium") then
				if (player:hasItem("titanium_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Titanium ore before you can store this material.")
					return
				end
				player:removeItem("titanium_ore",100)
				player:removeItem("ore_chest",1)
				player:sendMinitext("You stuff your Titanium Ore into the empty chest.")
				player:addItem("chest_titaniumi",1)

			elseif (choice == "Nothing.") then
				return
			end
	end)
}



		-- COPPER

chest_copperi = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("copper_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Copper ore before you can store this material.")
					return
				end
				player:removeItem("copper_ore",100)
				player:removeItem("chest_copperi",1)
				player:sendMinitext("You add another load of Copper Ore into the chest.")
				player:addItem("chest_copperii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("copper_ore",101) >= 1) then
					player:sendMinitext("You have too much Copper Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_copperi",1)
				player:addItem("ore_chest",1)
				player:sendMinitext("You have removed some Copper Ore from your chest.")
				player:addItem("copper_ore",100)
			end
	end)
}

chest_copperii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("copper_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Copper ore before you can store this material.")
					return
				end
				player:removeItem("copper_ore",100)
				player:removeItem("chest_copperii",1)
				player:sendMinitext("You add another load of Copper Ore into the chest.")
				player:addItem("chest_copperiii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("copper_ore",101) >= 1) then
					player:sendMinitext("You have too much Copper Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_copperii",1)
				player:addItem("chest_copperi",1)
				player:sendMinitext("You have removed some Copper Ore from your chest.")
				player:addItem("copper_ore",100)
			end
	end)
}


chest_copperiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("copper_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Copper ore before you can store this material.")
					return
				end
				player:removeItem("copper_ore",100)
				player:removeItem("chest_copperiii",1)
				player:sendMinitext("You add another load of Copper Ore into the chest.")
				player:addItem("chest_copperiv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("copper_ore",101) >= 1) then
					player:sendMinitext("You have too much Copper Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_copperiii",1)
				player:addItem("chest_copperii",1)
				player:sendMinitext("You have removed some Copper Ore from your chest.")
				player:addItem("copper_ore",100)
			end
	end)
}



chest_copperiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("copper_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Copper ore before you can store this material.")
					return
				end
				player:removeItem("copper_ore",100)
				player:removeItem("chest_copperiv",1)
				player:sendMinitext("You add another load of Copper Ore into the chest.")
				player:addItem("chest_copperv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("copper_ore",101) >= 1) then
					player:sendMinitext("You have too much Copper Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_copperiv",1)
				player:addItem("chest_copperiii",1)
				player:sendMinitext("You have removed some Copper Ore from your chest.")
				player:addItem("copper_ore",100)
			end
	end)
}



chest_copperv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Copper from this bag."},1)
			if (player:hasItem("copper_ore",101) >= 1) then
				player:sendMinitext("You have too much Copper Ore in your inventory to take any more out.")
				return
			end

		player:removeItem("chest_copperv",1)
		player:addItem("chest_copperiv",1)
		player:sendMinitext("You have removed some Copper Ore from your chest.")
		player:addItem("copper_ore",100)
	end)
}



		-- TIN


chest_tini = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=16}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("tin_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Tin ore before you can store this material.")
					return
				end
				player:removeItem("tin_ore",100)
				player:removeItem("chest_tini",1)
				player:sendMinitext("You add another load of Tin Ore into the chest.")
				player:addItem("chest_tinii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("tin_ore", 10101) >= 1) then
					player:sendMinitext("You have too much Tin Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_tini",1)
				player:addItem("ore_chest",1)
				player:sendMinitext("You have removed some Tin Ore from your chest.")
				player:addItem("tin_ore",100)
			end
	end)
}


chest_tinii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=16}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("tin_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Tin ore before you can store this material.")
					return
				end
				player:removeItem("tin_ore",100)
				player:removeItem("chest_tinii",1)
				player:sendMinitext("You add another load of Tin Ore into the chest.")
				player:addItem("chest_tiniii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("tin_ore",101) >= 1) then
					player:sendMinitext("You have too much Tin Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_tinii",1)
				player:addItem("chest_tini",1)
				player:sendMinitext("You have removed some Tin Ore from your chest.")
				player:addItem("tin_ore",100)
			end
	end)
}


chest_tiniii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=16}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("tin_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Tin ore before you can store this material.")
					return
				end
				player:removeItem("tin_ore",100)
				player:removeItem("chest_tiniii",1)
				player:sendMinitext("You add another load of Tin Ore into the chest.")
				player:addItem("chest_tiniv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("tin_ore",101) >= 1) then
					player:sendMinitext("You have too much Tin Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_tiniii",1)
				player:addItem("chest_tinii",1)
				player:sendMinitext("You have removed some Tin Ore from your chest.")
				player:addItem("tin_ore",100)
			end
	end)
}



chest_tiniv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=16}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("tin_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Tin ore before you can store this material.")
					return
				end
				player:removeItem("tin_ore",100)
				player:removeItem("chest_tiniv",1)
				player:sendMinitext("You add another load of Tin Ore into the chest.")
				player:addItem("chest_tinv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("tin_ore",101) >= 1) then
					player:sendMinitext("You have too much Tin Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_tiniv",1)
				player:addItem("chest_tiniii",1)
				player:sendMinitext("You have removed some Tin Ore from your chest.")
				player:addItem("tin_ore",100)
			end
	end)
}



chest_tinv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=16}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Tin from this bag."},1)
			if (player:hasItem("tin_ore",101) >= 1) then
				player:sendMinitext("You have too much Tin Ore in your inventory to take any more out.")
				return
			end

		player:removeItem("chest_tinv",1)
		player:addItem("chest_tiniv",1)
		player:sendMinitext("You have removed some Tin Ore from your chest.")
		player:addItem("tin_ore",100)
	end)
}



		-- IRON


chest_ironi = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=10}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("iron_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Iron ore before you can store this material.")
					return
				end
				player:removeItem("iron_ore",100)
				player:removeItem("chest_ironi",1)
				player:sendMinitext("You add another load of Iron Ore into the chest.")
				player:addItem("chest_ironii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("iron_ore",101) >= 1) then
					player:sendMinitext("You have too much Iron Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_ironi",1)
				player:addItem("ore_chest",1)
				player:sendMinitext("You have removed some Iron Ore from your chest.")
				player:addItem("iron_ore",100)
			end
	end)
}

chest_ironii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=10}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("iron_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Iron ore before you can store this material.")
					return
				end
				player:removeItem("iron_ore",100)
				player:removeItem("chest_ironii",1)
				player:sendMinitext("You add another load of Iron Ore into the chest.")
				player:addItem("chest_ironiii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("iron_ore",101) >= 1) then
					player:sendMinitext("You have too much Iron Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_ironii",1)
				player:addItem("chest_ironi",1)
				player:sendMinitext("You have removed some Iron Ore from your chest.")
				player:addItem("iron_ore",100)
			end
	end)
}


chest_ironiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=10}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("iron_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Iron ore before you can store this material.")
					return
				end
				player:removeItem("iron_ore",100)
				player:removeItem("chest_ironiii",1)
				player:sendMinitext("You add another load of Iron Ore into the chest.")
				player:addItem("chest_ironiv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("iron_ore",101) >= 1) then
					player:sendMinitext("You have too much Iron Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_ironiii",1)
				player:addItem("chest_ironii",1)
				player:sendMinitext("You have removed some Iron Ore from your chest.")
				player:addItem("iron_ore",100)
			end
	end)
}



chest_ironiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=10}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("iron_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Iron ore before you can store this material.")
					return
				end
				player:removeItem("iron_ore",100)
				player:removeItem("chest_ironiv",1)
				player:sendMinitext("You add another load of Iron Ore into the chest.")
				player:addItem("chest_ironv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("iron_ore",101) >= 1) then
					player:sendMinitext("You have too much Iron Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_ironiv",1)
				player:addItem("chest_ironiii",1)
				player:sendMinitext("You have removed some Iron Ore from your chest.")
				player:addItem("iron_ore",100)
			end
	end)
}



chest_ironv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=10}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Iron from this bag."},1)
			if (player:hasItem("iron_ore",101) >= 1) then
				player:sendMinitext("You have too much Iron Ore in your inventory to take any more out.")
				return
			end

		player:removeItem("chest_ironv",1)
		player:addItem("chest_ironiv",1)
		player:sendMinitext("You have removed some Iron Ore from your chest.")
		player:addItem("iron_ore",100)
	end)
}



		-- PLATINUM



chest_platinumi = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=17}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("platinum_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Platinum ore before you can store this material.")
					return
				end
				player:removeItem("platinum_ore",100)
				player:removeItem("chest_platinumi",1)
				player:sendMinitext("You add another load of Platinum Ore into the chest.")
				player:addItem("chest_platinumii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("platinum_ore",101) >= 1) then
					player:sendMinitext("You have too much Platinum Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_platinumi",1)
				player:addItem("ore_chest",1)
				player:sendMinitext("You have removed some Platinum Ore from your chest.")
				player:addItem("platinum_ore",100)
			end
	end)
}


chest_platinumii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=17}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("platinum_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Platinum ore before you can store this material.")
					return
				end
				player:removeItem("platinum_ore",100)
				player:removeItem("chest_platinumii",1)
				player:sendMinitext("You add another load of Platinum Ore into the chest.")
				player:addItem("chest_platinumiii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("platinum_ore",101) >= 1) then
					player:sendMinitext("You have too much Platinum Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_platinumii",1)
				player:addItem("chest_platinumi",1)
				player:sendMinitext("You have removed some Platinum Ore from your chest.")
				player:addItem("platinum_ore",100)
			end
	end)
}


chest_platinumiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=17}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("platinum_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Platinum ore before you can store this material.")
					return
				end
				player:removeItem("platinum_ore",100)
				player:removeItem("chest_platinumiii",1)
				player:sendMinitext("You add another load of Platinum Ore into the chest.")
				player:addItem("chest_platinumiv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("platinum_ore",101) >= 1) then
					player:sendMinitext("You have too much Platinum Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_platinumiii",1)
				player:addItem("chest_platinumii",1)
				player:sendMinitext("You have removed some Platinum Ore from your chest.")
				player:addItem("platinum_ore",100)
			end
	end)
}



chest_platinumiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=17}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("platinum_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Platinum ore before you can store this material.")
					return
				end
				player:removeItem("platinum_ore",100)
				player:removeItem("chest_platinumiv",1)
				player:sendMinitext("You add another load of Platinum Ore into the chest.")
				player:addItem("chest_platinumv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("platinum_ore",101) >= 1) then
					player:sendMinitext("You have too much Platinum Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_platinumiv",1)
				player:addItem("chest_platinumiii",1)
				player:sendMinitext("You have removed some Platinum Ore from your chest.")
				player:addItem("platinum_ore",100)
			end
	end)
}



chest_platinumv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=17}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Platinum from this bag."},1)
			if (player:hasItem("platinum_ore",101) >= 1) then
				player:sendMinitext("You have too much Platinum Ore in your inventory to take any more out.")
				return
			end

		player:removeItem("chest_platinumv",1)
		player:addItem("chest_platinumiv",1)
		player:sendMinitext("You have removed some Platinum Ore from your chest.")
		player:addItem("platinum_ore",100)
	end)
}



		-- TITANIUM



chest_titaniumi = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=20}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("titanium_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Titanium ore before you can store this material.")
					return
				end
				player:removeItem("titanium_ore",100)
				player:removeItem("chest_titaniumi",1)
				player:sendMinitext("You add another load of Titanium Ore into the chest.")
				player:addItem("chest_titaniumii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("titanium_ore",101) >= 1) then
					player:sendMinitext("You have too much Titanium Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_titaniumi",1)
				player:addItem("ore_chest",1)
				player:sendMinitext("You have removed some Titanium Ore from your chest.")
				player:addItem("titanium_ore",100)
			end
	end)
}


chest_titaniumii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=20}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("titanium_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Titanium ore before you can store this material.")
					return
				end
				player:removeItem("titanium_ore",100)
				player:removeItem("chest_titaniumii",1)
				player:sendMinitext("You add another load of Titanium Ore into the chest.")
				player:addItem("chest_titaniumiii",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("titanium_ore",101) >= 1) then
					player:sendMinitext("You have too much Titanium Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_titaniumii",1)
				player:addItem("chest_titaniumi",1)
				player:sendMinitext("You have removed some Titanium Ore from your chest.")
				player:addItem("titanium_ore",100)
			end
	end)
}


chest_titaniumiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=20}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("titanium_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Titanium ore before you can store this material.")
					return
				end
				player:removeItem("titanium_ore",100)
				player:removeItem("chest_titaniumiii",1)
				player:sendMinitext("You add another load of Titanium Ore into the chest.")
				player:addItem("chest_titaniumiv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("titanium_ore",101) >= 1) then
					player:sendMinitext("You have too much Titanium Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_titaniumiii",1)
				player:addItem("chest_titaniumii",1)
				player:sendMinitext("You have removed some Titanium Ore from your chest.")
				player:addItem("titanium_ore",100)
			end
	end)
}



chest_titaniumiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=20}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your chest.")
			table.insert(opts,"Remove a bundle from your chest.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your chest.") then
				if(player:hasItem("titanium_ore",100) ~= true) then
					player:sendMinitext("You need a full load of Titanium ore before you can store this material.")
					return
				end
				player:removeItem("titanium_ore",100)
				player:removeItem("chest_titaniumiv",1)
				player:sendMinitext("You add another load of Titanium Ore into the chest.")
				player:addItem("chest_titaniumv",1)

			elseif (choice == "Remove a bundle from your chest.") then
				if (player:hasItem("titanium_ore",101) >= 1) then
					player:sendMinitext("You have too much Titanium Ore in your inventory to take any more out.")
					return
				end
				player:removeItem("chest_titaniumiv",1)
				player:addItem("chest_titaniumiii",1)
				player:sendMinitext("You have removed some Titanium Ore from your chest.")
				player:addItem("titanium_ore",100)
			end
	end)
}



chest_titaniumv = {
	use = async(function(player)
		local t={graphic=convertGraphic(1270,"item"),color=20}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Titanium from this bag."},1)
			if (player:hasItem("titanium_ore",101) >= 1) then
				player:sendMinitext("You have too much Titanium Ore in your inventory to take any more out.")
				return
			end

		player:removeItem("chest_titaniumv",1)
		player:addItem("chest_titaniumiv",1)
		player:sendMinitext("You have removed some Titanium Ore from your chest.")
		player:addItem("titanium_ore",100)
	end)
}
