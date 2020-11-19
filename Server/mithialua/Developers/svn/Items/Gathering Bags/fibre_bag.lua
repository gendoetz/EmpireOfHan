fibre_bag = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
		local opts = { }
				table.insert(opts,"Wool")
				table.insert(opts,"Merino")
				table.insert(opts,"Angora")
				table.insert(opts,"Cashmere")
				table.insert(opts,"Silk")
			
		local choice=player:menuString3("Which would you like to store?", opts)

			if (choice == "Wool") then
				if(player:hasItem("fibre_wool",100) ~= true) then
					player:sendMinitext("You need a full bundle of Wool before you can store this material.")
					return
				end
				player:removeItem("fibre_wool",100)
				player:removeItem("fibre_bag",1)
				player:sendMinitext("You stuff your Wool into the empty bag.")
				player:addItem("bag_wooli",1)

			elseif (choice == "Merino") then
				if (player:hasItem("fibre_merino",100) ~= true) then
					player:sendMinitext("You need a full bundle of Merino before you can store this material.")
					return
				end
				player:removeItem("fibre_merino",100)
				player:removeItem("fibre_bag",1)
				player:sendMinitext("You stuff your Merino into the empty bag.")
				player:addItem("bag_merinoi",1)

			elseif (choice == "Angora") then
				if (player:hasItem("fibre_angora",100) ~= true) then
					player:sendMinitext("You need a full bundle of Angora before you can store this material.")
					return
				end
				player:removeItem("fibre_angora",100)
				player:removeItem("fibre_bag",1)
				player:sendMinitext("You stuff your Angora into the empty bag.")
				player:addItem("bag_angorai",1)

			elseif (choice == "Cashmere") then
				if (player:hasItem("fibre_cashmere",100) ~= true) then
					player:sendMinitext("You need a full bundle of Cashmere before you can store this material.")
					return
				end
				player:removeItem("fibre_cashmere",100)
				player:removeItem("fibre_bag",1)
				player:sendMinitext("You stuff your Cashmere into the empty bag.")
				player:addItem("bag_cashmerei",1)

			elseif (choice == "Silk") then
				if (player:hasItem("fibre_silk",100) ~= true) then
					player:sendMinitext("You need a full bundle of Silk before you can store this material.")
					return
				end
				player:removeItem("fibre_silk",100)
				player:removeItem("fibre_bag",1)
				player:sendMinitext("You stuff your Silk into the empty bag.")
				player:addItem("bag_silki",1)

			elseif (choice == "Nothing.") then
				return
			end
	end)
	}

-- WOOL BAG
bag_wooli = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=2}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_wool",100) ~= true) then
					player:sendMinitext("You need a full bundle of Wool before you can store this material.")
					return
				end
				player:removeItem("fibre_wool",100)
				player:removeItem("bag_wooli",1)
				player:sendMinitext("You stuff more Wool into the bag.")
				player:addItem("bag_woolii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_wool",101) >= 1) then
					player:sendMinitext("You have too much Wool in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_wooli",1)
				player:addItem("fibre_bag",1)
				player:sendMinitext("You have removed some Wool from your bag.")
				player:addItem("fibre_wool",100)
			end
	end)
}
bag_woolii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=2}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0

		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_wool",100) ~= true) then
					player:sendMinitext("You need a full bundle of Wool before you can store this material.")
					return
				end
				player:removeItem("fibre_wool",100)
				player:removeItem("bag_woolii",1)
				player:sendMinitext("You stuff more Wool into the bag.")
				player:addItem("bag_wooliii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_wool",101) >= 1) then
					player:sendMinitext("You have too much Wool in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_woolii",1)
				player:addItem("bag_wooli",1)
				player:sendMinitext("You have removed some Wool from your bag.")
				player:addItem("fibre_wool",100)
			end
	end)
}
bag_wooliii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=2}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_wool",100) ~= true) then
					player:sendMinitext("You need a full bundle of Wool before you can store this material.")
					return
				end
				player:removeItem("fibre_wool",100)
				player:removeItem("bag_wooliii",1)
				player:sendMinitext("You stuff more Wool into the bag.")
				player:addItem("bag_wooliv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_wool",101) >= 1) then
					player:sendMinitext("You have too much Wool in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_wooliii",1)
				player:addItem("bag_woolii",1)
				player:sendMinitext("You have removed some Wool from your bag.")
				player:addItem("fibre_wool",100)
			end
	end)
}
bag_wooliv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=2}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_wool",100) ~= true) then
					player:sendMinitext("You need a full bundle of Wool before you can store this material.")
					return
				end
				player:removeItem("fibre_wool",100)
				player:removeItem("bag_wooliv",1)
				player:sendMinitext("You stuff more Wool into the bag.")
				player:addItem("bag_woolv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_wool",101) >= 1) then
					player:sendMinitext("You have too much Wool in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_wooliv",1)
				player:addItem("bag_wooliii",1)
				player:sendMinitext("You have removed some Wool from your bag.")
				player:addItem("fibre_wool",100)
			end
	end)
}
bag_woolv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=2}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Wool from this bag."},1)
			if (player:hasItem("fibre_wool",101) >= 1) then
				player:sendMinitext("You have too much Wool in your inventory to take any more out.")
				return
			end

		player:removeItem("bag_woolv",1)
		player:addItem("bag_wooliv",1)
		player:sendMinitext("You have removed some Wool from your bag.")
		player:addItem("fibre_wool",100)
	end)
}

-- MERINO BAG
bag_merinoi = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_merino",100) ~= true) then
					player:sendMinitext("You need a full bundle of Merino before you can store this material.")
					return
				end
				player:removeItem("fibre_merino",100)
				player:removeItem("bag_merinoi",1)
				player:sendMinitext("You stuff more Merino into the bag.")
				player:addItem("bag_merinoii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_merino",101) >= 1) then
					player:sendMinitext("You have too much Merino in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_merinoi",1)
				player:addItem("fibre_bag",1)
				player:sendMinitext("You have removed some Merino from your bag.")
				player:addItem("fibre_merino",100)
			end
	end)
}
bag_merinoii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_merino",100) ~= true) then
					player:sendMinitext("You need a full bundle of Merino before you can store this material.")
					return
				end
				player:removeItem("fibre_merino",100)
				player:removeItem("bag_merinoii",1)
				player:sendMinitext("You stuff more Merino into the bag.")
				player:addItem("bag_merinoiii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_merino",101) >= 1) then
					player:sendMinitext("You have too much Merino in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_merinoii",1)
				player:addItem("bag_merinoi",1)
				player:sendMinitext("You have removed some Merino from your bag.")
				player:addItem("fibre_merino",100)
			end
	end)
}
bag_merinoiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_merino",100) ~= true) then
					player:sendMinitext("You need a full bundle of Merino before you can store this material.")
					return
				end
				player:removeItem("fibre_merino",100)
				player:removeItem("bag_merinoiii",1)
				player:sendMinitext("You stuff more Merino into the bag.")
				player:addItem("bag_merinoiv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_merino",101) >= 1) then
					player:sendMinitext("You have too much Merino in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_merinoiii",1)
				player:addItem("bag_merinoii",1)
				player:sendMinitext("You have removed some Merino from your bag.")
				player:addItem("fibre_merino",100)
			end
	end)
}
bag_merinoiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_merino",100) ~= true) then
					player:sendMinitext("You need a full bundle of Merino before you can store this material.")
					return
				end
				player:removeItem("fibre_merino",100)
				player:removeItem("bag_merinoiv",1)
				player:sendMinitext("You stuff more Merino into the bag.")
				player:addItem("bag_merinov",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_merino",101) >= 1) then
					player:sendMinitext("You have too much Merino in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_merinoiv",1)
				player:addItem("bag_merinoiii",1)
				player:sendMinitext("You have removed some Merino from your bag.")
				player:addItem("fibre_merino",100)
			end
	end)
}
bag_merinov = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=0}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Merino from this bag."},1)
			if (player:hasItem("fibre_merino",101) >= 1) then
				player:sendMinitext("You have too much Merino in your inventory to take any more out.")
				return
			end

		player:removeItem("bag_merinov",1)
		player:addItem("bag_merinoiv",1)
		player:sendMinitext("You have removed some Merino from your bag.")
		player:addItem("fibre_merino",100)
	end)
}

-- ANGORA BAG
bag_angorai = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=14}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_angora",100) ~= true) then
					player:sendMinitext("You need a full bundle of Angora before you can store this material.")
					return
				end
				player:removeItem("fibre_angora",100)
				player:removeItem("bag_angorai",1)
				player:sendMinitext("You stuff more Angora into the bag.")
				player:addItem("bag_angoraii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_angora",101) >= 1) then
					player:sendMinitext("You have too much Angora in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_angorai",1)
				player:addItem("fibre_bag",1)
				player:sendMinitext("You have removed some Angora from your bag.")
				player:addItem("fibre_angora",100)
			end
	end)
}
bag_angoraii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=14}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_angora",100) ~= true) then
					player:sendMinitext("You need a full bundle of Angora before you can store this material.")
					return
				end
				player:removeItem("fibre_angora",100)
				player:removeItem("bag_angoraii",1)
				player:sendMinitext("You stuff more Angora into the bag.")
				player:addItem("bag_angoraiii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_angora",101) >= 1) then
					player:sendMinitext("You have too much Angora in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_angoraii",1)
				player:addItem("bag_angorai",1)
				player:sendMinitext("You have removed some Angora from your bag.")
				player:addItem("fibre_angora",100)
			end
	end)
}
bag_angoraiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=14}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_angora",100) ~= true) then
					player:sendMinitext("You need a full bundle of Angora before you can store this material.")
					return
				end
				player:removeItem("fibre_angora",100)
				player:removeItem("bag_angoraiii",1)
				player:sendMinitext("You stuff more Angora into the bag.")
				player:addItem("bag_angoraiv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_angora",101) >= 1) then
					player:sendMinitext("You have too much Angora in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_angoraiii",1)
				player:addItem("bag_angoraii",1)
				player:sendMinitext("You have removed some Angora from your bag.")
				player:addItem("fibre_angora",100)
			end
	end)
}
bag_angoraiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=14}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_angora",100) ~= true) then
					player:sendMinitext("You need a full bundle of Angora before you can store this material.")
					return
				end
				player:removeItem("fibre_angora",100)
				player:removeItem("bag_angoraiv",1)
				player:sendMinitext("You stuff more Angora into the bag.")
				player:addItem("bag_angorav",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_angora",101) >= 1) then
					player:sendMinitext("You have too much Angora in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_angoraiv",1)
				player:addItem("bag_angoraiii",1)
				player:sendMinitext("You have removed some Angora from your bag.")
				player:addItem("fibre_angora",100)
			end
	end)
}
bag_angorav = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=14}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Angora from this bag."},1)
			if (player:hasItem("fibre_angora",101) >= 1) then
				player:sendMinitext("You have too much Angora in your inventory to take any more out.")
				return
			end

		player:removeItem("bag_angorav",1)
		player:addItem("bag_angoraiv",1)
		player:sendMinitext("You have removed some Angora from your bag.")
		player:addItem("fibre_angora",100)
	end)
}

-- CASHMERE BAG
bag_cashmerei = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=3}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_cashmere",100) ~= true) then
					player:sendMinitext("You need a full bundle of Cashmere before you can store this material.")
					return
				end
				player:removeItem("fibre_cashmere",100)
				player:removeItem("bag_cashmerei",1)
				player:sendMinitext("You stuff more Cashmere into the bag.")
				player:addItem("bag_cashmereii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_cashmere",101) >= 1) then
					player:sendMinitext("You have too much Cashmere in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_cashmerei",1)
				player:addItem("fibre_bag",1)
				player:sendMinitext("You have removed some Cashmere from your bag.")
				player:addItem("fibre_cashmere",100)
			end
	end)
}
bag_cashmereii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=3}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_cashmere",100) ~= true) then
					player:sendMinitext("You need a full bundle of Cashmere before you can store this material.")
					return
				end
				player:removeItem("fibre_cashmere",100)
				player:removeItem("bag_cashmereii",1)
				player:sendMinitext("You stuff more Cashmere into the bag.")
				player:addItem("bag_cashmereiii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_cashmere",101) >= 1) then
					player:sendMinitext("You have too much Cashmere in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_cashmereii",1)
				player:addItem("bag_cashmerei",1)
				player:sendMinitext("You have removed some Cashmere from your bag.")
				player:addItem("fibre_cashmere",100)
			end
	end)
}
bag_cashmereiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=3}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_cashmere",100) ~= true) then
					player:sendMinitext("You need a full bundle of Cashmere before you can store this material.")
					return
				end
				player:removeItem("fibre_cashmere",100)
				player:removeItem("bag_cashmereiii",1)
				player:sendMinitext("You stuff more Cashmere into the bag.")
				player:addItem("bag_cashmereiv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_cashmere",101) >= 1) then
					player:sendMinitext("You have too much Cashmere in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_cashmereiii",1)
				player:addItem("bag_cashmereii",1)
				player:sendMinitext("You have removed some Cashmere from your bag.")
				player:addItem("fibre_cashmere",100)
			end
	end)
}
bag_cashmereiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=3}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_cashmere",100) ~= true) then
					player:sendMinitext("You need a full bundle of Cashmere before you can store this material.")
					return
				end
				player:removeItem("fibre_cashmere",100)
				player:removeItem("bag_cashmereiv",1)
				player:sendMinitext("You stuff more Cashmere into the bag.")
				player:addItem("bag_cashmerev",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_cashmere",101) >= 1) then
					player:sendMinitext("You have too much Cashmere in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_cashmereiv",1)
				player:addItem("bag_cashmereiii",1)
				player:sendMinitext("You have removed some Cashmere from your bag.")
				player:addItem("fibre_cashmere",100)
			end
	end)
}
bag_cashmerev = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=3}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Cashmere from this bag."},1)
			if (player:hasItem("fibre_cashmere",101) >= 1) then
				player:sendMinitext("You have too much Cashmere in your inventory to take any more out.")
				return
			end

		player:removeItem("bag_cashmerev",1)
		player:addItem("bag_cashmereiv",1)
		player:sendMinitext("You have removed some Cashmere from your bag.")
		player:addItem("fibre_cashmere",100)
	end)
}

-- SILK BAG
bag_silki = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=9}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_silk",100) ~= true) then
					player:sendMinitext("You need a full bundle of Silk before you can store this material.")
					return
				end
				player:removeItem("fibre_silk",100)
				player:removeItem("bag_silki",1)
				player:sendMinitext("You stuff more Silk into the bag.")
				player:addItem("bag_silkii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_silk",101) >= 1) then
					player:sendMinitext("You have too much Silk in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_silki",1)
				player:addItem("fibre_bag",1)
				player:sendMinitext("You have removed some Silk from your bag.")
				player:addItem("fibre_silk",100)
			end
	end)
}
bag_silkii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=9}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_silk",100) ~= true) then
					player:sendMinitext("You need a full bundle of Silk before you can store this material.")
					return
				end
				player:removeItem("fibre_silk",100)
				player:removeItem("bag_silkii",1)
				player:sendMinitext("You stuff more Silk into the bag.")
				player:addItem("bag_silkiii",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_silk",101) >= 1) then
					player:sendMinitext("You have too much Silk in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_silkii",1)
				player:addItem("bag_silki",1)
				player:sendMinitext("You have removed some Silk from your bag.")
				player:addItem("fibre_silk",100)
			end
	end)
}
bag_silkiii = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=9}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_silk",100) ~= true) then
					player:sendMinitext("You need a full bundle of Silk before you can store this material.")
					return
				end
				player:removeItem("fibre_silk",100)
				player:removeItem("bag_silkiii",1)
				player:sendMinitext("You stuff more Silk into the bag.")
				player:addItem("bag_silkiv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_silk",101) >= 1) then
					player:sendMinitext("You have too much Silk in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_silkiii",1)
				player:addItem("bag_silkii",1)
				player:sendMinitext("You have removed some Silk from your bag.")
				player:addItem("fibre_silk",100)
			end
	end)
}
bag_silkiv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=9}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
		local opts = { }
			table.insert(opts,"Add more into your bag.")
			table.insert(opts,"Remove a bundle from your bag.")

		local choice=player:menuString3("Which would you like to do?", opts)
			if (choice == "Add more into your bag.") then
				if(player:hasItem("fibre_silk",100) ~= true) then
					player:sendMinitext("You need a full bundle of Silk before you can store this material.")
					return
				end
				player:removeItem("fibre_silk",100)
				player:removeItem("bag_silkiv",1)
				player:sendMinitext("You stuff more Silk into the bag.")
				player:addItem("bag_silkv",1)

			elseif (choice == "Remove a bundle from your bag.") then
				if (player:hasItem("fibre_silk",101) >= 1) then
					player:sendMinitext("You have too much Silk in your inventory to take any more out.")
					return
				end
				player:removeItem("bag_silkiv",1)
				player:addItem("bag_silkiii",1)
				player:sendMinitext("You have removed some Silk from your bag.")
				player:addItem("fibre_silk",100)
			end
	end)
}
bag_silkv = {
	use = async(function(player)
		local t={graphic=convertGraphic(2232,"item"),color=9}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		
	        local opts = { }
				
		player:dialogSeq({t,"By clicking next, you will remove Silk from this bag."},1)
			if (player:hasItem("fibre_silk",101) >= 1) then
				player:sendMinitext("You have too much Silk in your inventory to take any more out.")
				return
			end

		player:removeItem("bag_silkv",1)
		player:addItem("bag_silkiv",1)
		player:sendMinitext("You have removed some Silk from your bag.")
		player:addItem("fibre_silk",100)
	end)
}
