-- BASE CRATE
	branch_crate = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=0}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = { }
					table.insert(opts,"Elm")
					table.insert(opts,"Birch")
					table.insert(opts,"Maple")
					table.insert(opts,"Cherry")
					table.insert(opts,"Oak")
				
			local choice=player:menuString3("Which would you like to store?", opts)
				if (choice == "Elm") then
					if(player:hasItem("branch_elm",100) ~= true) then
						player:sendMinitext("You need a full bundle of Elm before you can store this material.")
						return
					end
					player:removeItem("branch_elm",100)
					player:removeItem("branch_crate",1)
					player:sendMinitext("You stuff your Elm into the empty crate.")
					player:addItem("crate_elmi",1)


				elseif (choice == "Birch") then
					if (player:hasItem("branch_birch",100) ~= true) then
						player:sendMinitext("You need a full bundle of Birch before you can store this material.")
						return
					end
					player:removeItem("branch_birch",100)
					player:removeItem("branch_crate",1)
					player:sendMinitext("You stuff your Birch into the empty crate.")
					player:addItem("crate_birchi",1)

				elseif (choice == "Maple") then
					if (player:hasItem("branch_maple",100) ~= true) then
						player:sendMinitext("You need a full bundle of Maple before you can store this material.")
						return
					end
					player:removeItem("branch_maple",100)
					player:removeItem("branch_crate",1)
					player:sendMinitext("You stuff your Maple into the empty crate.")
					player:addItem("crate_maplei",1)

				elseif (choice == "Cherry") then
					if (player:hasItem("branch_cherry",100) ~= true) then
						player:sendMinitext("You need a full bundle of Cherry before you can store this material.")
						return
					end
					player:removeItem("branch_cherry",100)
					player:removeItem("branch_crate",1)
					player:sendMinitext("You stuff your Cherry into the empty crate.")
					player:addItem("crate_cherryi",1)

				elseif (choice == "Oak") then
					if (player:hasItem("branch_oak",100) ~= true) then
						player:sendMinitext("You need a full bundle of Oak before you can store this material.")
						return
					end
					player:removeItem("branch_oak",100)
					player:removeItem("branch_crate",1)
					player:sendMinitext("You stuff your Oak into the empty crate.")
					player:addItem("crate_oaki",1)

				elseif (choice == "Nothing.") then
					return
				end
		end)
	}

-- ELM CRATE
	crate_elmi = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=15}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_elm",100) ~= true) then
						player:sendMinitext("You need a full bundle of Elm before you can store this material.")
						return
					end
					player:removeItem("branch_elm",100)
					player:removeItem("crate_elmi",1)
					player:sendMinitext("You stuff more Elm Branches into the crate.")
					player:addItem("crate_elmii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_elm",101) >= 1) then
						player:sendMinitext("You have too many Elm Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_elmi",1)
					player:addItem("branch_crate",1)
					player:sendMinitext("You have removed a bushel of Elm Branches from your crate.")
					player:addItem("branch_elm",100)
				end
		end)
	}
	crate_elmii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=15}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0

			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_elm",100) ~= true) then
						player:sendMinitext("You need a full bundle of Elm before you can store this material.")
						return
					end
					player:removeItem("branch_elm",100)
					player:removeItem("crate_elmii",1)
					player:sendMinitext("You stuff more Elm Branches into the crate.")
					player:addItem("crate_elmiii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_elm",101) >= 1) then
						player:sendMinitext("You have too many Elm Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_elmii",1)
					player:addItem("crate_elmi",1)
					player:sendMinitext("You have removed a bushel of Elm Branches from your crate.")
					player:addItem("branch_elm",100)
				end
		end)
	}
	crate_elmiii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=15}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_elm",100) ~= true) then
						player:sendMinitext("You need a full bundle of Elm before you can store this material.")
						return
					end
					player:removeItem("branch_elm",100)
					player:removeItem("crate_elmiii",1)
					player:sendMinitext("You stuff more Elm Branches into the crate.")
					player:addItem("crate_elmiv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_elm",101) >= 1) then
						player:sendMinitext("You have too many Elm Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_elmiii",1)
					player:addItem("crate_elmii",1)
					player:sendMinitext("You have removed a bushel of Elm Branches from your crate.")
					player:addItem("branch_elm",100)
				end
		end)
	}
	crate_elmiv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=15}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_elm",100) ~= true) then
						player:sendMinitext("You need a full bundle of Elm before you can store this material.")
						return
					end
					player:removeItem("branch_elm",100)
					player:removeItem("crate_elmiv",1)
					player:sendMinitext("You stuff more Elm Branches into the crate.")
					player:addItem("crate_elmv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_elm",101) >= 1) then
						player:sendMinitext("You have too many Elm Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_elmiv",1)
					player:addItem("crate_elmiii",1)
					player:sendMinitext("You have removed a bushel of Elm Branches from your crate.")
					player:addItem("branch_elm",100)
				end
		end)
	}
	crate_elmv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=15}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
		        local opts = { }
					
			player:dialogSeq({t,"By clicking next, you will remove a bushel of Elm from this crate."},1)
				if (player:hasItem("branch_elm",101) >= 1) then
					player:sendMinitext("You have too many Elm Branches in your inventory to take any more out.")
					return
				end

			player:removeItem("crate_elmv",1)
			player:addItem("crate_elmiv",1)
			player:sendMinitext("You have removed a bushel of Elm Branches from your crate.")
			player:addItem("branch_elm",100)
		end)
	}
-- BIRCH CRATE
	crate_birchi = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=29}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_birch",100) ~= true) then
						player:sendMinitext("You need a full bundle of Birch before you can store this material.")
						return
					end
					player:removeItem("branch_birch",100)
					player:removeItem("crate_birchi",1)
					player:sendMinitext("You stuff more Birch Branches into the crate.")
					player:addItem("crate_birchii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_birch",101) >= 1) then
						player:sendMinitext("You have too many Birch Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_birchi",1)
					player:addItem("branch_crate",1)
					player:sendMinitext("You have removed a bushel of Birch Branches from your crate.")
					player:addItem("branch_birch",100)
				end
		end)
	}
	crate_birchii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=29}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_birch",100) ~= true) then
						player:sendMinitext("You need a full bundle of Birch before you can store this material.")
						return
					end
					player:removeItem("branch_birch",100)
					player:removeItem("crate_birchii",1)
					player:sendMinitext("You stuff more Birch Branches into the crate.")
					player:addItem("crate_birchiii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_birch",101) >= 1) then
						player:sendMinitext("You have too many Birch Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_birchii",1)
					player:addItem("crate_birchi",1)
					player:sendMinitext("You have removed a bushel of Birch Branches from your crate.")
					player:addItem("branch_birch",100)
				end
		end)
	}
	crate_birchiii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=29}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_birch",100) ~= true) then
						player:sendMinitext("You need a full bundle of Birch before you can store this material.")
						return
					end
					player:removeItem("branch_birch",100)
					player:removeItem("crate_birchiii",1)
					player:sendMinitext("You stuff more Birch Branches into the crate.")
					player:addItem("crate_birchiv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_birch",101) >= 1) then
						player:sendMinitext("You have too many Birch Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_birchiii",1)
					player:addItem("crate_birchii",1)
					player:sendMinitext("You have removed a bushel of Birch Branches from your crate.")
					player:addItem("branch_birch",100)
				end
		end)
	}
	crate_birchiv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=29}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_birch",100) ~= true) then
						player:sendMinitext("You need a full bundle of Birch before you can store this material.")
						return
					end
					player:removeItem("branch_birch",100)
					player:removeItem("crate_birchiv",1)
					player:sendMinitext("You stuff more Birch Branches into the crate.")
					player:addItem("crate_birchv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_birch",101) >= 1) then
						player:sendMinitext("You have too many Birch Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_birchiv",1)
					player:addItem("crate_birchiii",1)
					player:sendMinitext("You have removed a bushel of Birch Branches from your crate.")
					player:addItem("branch_birch",100)
				end
		end)
	}
	crate_birchv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=29}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
		        local opts = { }
					
			player:dialogSeq({t,"By clicking next, you will remove a bushel of Birch from this crate."},1)
				if (player:hasItem("branch_birch",101) >= 1) then
					player:sendMinitext("You have too many Birch Branches in your inventory to take any more out.")
					return
				end

			player:removeItem("crate_birchv",1)
			player:addItem("crate_birchiv",1)
			player:sendMinitext("You have removed a bushel of Birch Branches from your crate.")
			player:addItem("branch_birch",100)
		end)
	}
-- MAPLE CRATE
	crate_maplei = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_maple",100) ~= true) then
						player:sendMinitext("You need a full bundle of Maple before you can store this material.")
						return
					end
					player:removeItem("branch_maple",100)
					player:removeItem("crate_maplei",1)
					player:sendMinitext("You stuff more Maple Branches into the crate.")
					player:addItem("crate_mapleii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_maple",101) >= 1) then
						player:sendMinitext("You have too many Maple Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_maplei",1)
					player:addItem("branch_crate",1)
					player:sendMinitext("You have removed a bushel of Maple Branches from your crate.")
					player:addItem("branch_maple",100)
				end
		end)
	}
	crate_mapleii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_maple",100) ~= true) then
						player:sendMinitext("You need a full bundle of Maple before you can store this material.")
						return
					end
					player:removeItem("branch_maple",100)
					player:removeItem("crate_mapleii",1)
					player:sendMinitext("You stuff more Maple Branches into the crate.")
					player:addItem("crate_mapleiii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_maple",101) >= 1) then
						player:sendMinitext("You have too many Maple Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_mapleii",1)
					player:addItem("crate_maplei",1)
					player:sendMinitext("You have removed a bushel of Maple Branches from your crate.")
					player:addItem("branch_maple",100)
				end
		end)
	}
	crate_mapleiii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_maple",100) ~= true) then
						player:sendMinitext("You need a full bundle of Maple before you can store this material.")
						return
					end
					player:removeItem("branch_maple",100)
					player:removeItem("crate_mapleiii",1)
					player:sendMinitext("You stuff more Maple Branches into the crate.")
					player:addItem("crate_mapleiv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_maple",101) >= 1) then
						player:sendMinitext("You have too many Maple Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_mapleiii",1)
					player:addItem("crate_mapleii",1)
					player:sendMinitext("You have removed a bushel of Maple Branches from your crate.")
					player:addItem("branch_maple",100)
				end
		end)
	}
	crate_mapleiv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_maple",100) ~= true) then
						player:sendMinitext("You need a full bundle of Maple before you can store this material.")
						return
					end
					player:removeItem("branch_maple",100)
					player:removeItem("crate_mapleiv",1)
					player:sendMinitext("You stuff more Maple Branches into the crate.")
					player:addItem("crate_maplev",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_maple",101) >= 1) then
						player:sendMinitext("You have too many Maple Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_mapleiv",1)
					player:addItem("crate_mapleiii",1)
					player:sendMinitext("You have removed a bushel of Maple Branches from your crate.")
					player:addItem("branch_maple",100)
				end
		end)
	}
	crate_maplev = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=1}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
		        local opts = { }
					
			player:dialogSeq({t,"By clicking next, you will remove a bushel of Maple from this crate."},1)
				if (player:hasItem("branch_maple",101) >= 1) then
					player:sendMinitext("You have too many Maple Branches in your inventory to take any more out.")
					return
				end

			player:removeItem("crate_maplev",1)
			player:addItem("crate_mapleiv",1)
			player:sendMinitext("You have removed a bushel of Maple Branches from your crate.")
			player:addItem("branch_maple",100)
		end)
	}
-- CHERRY CRATE
	crate_cherryi = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=2}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_cherry",100) ~= true) then
						player:sendMinitext("You need a full bundle of Cherry before you can store this material.")
						return
					end
					player:removeItem("branch_cherry",100)
					player:removeItem("crate_cherryi",1)
					player:sendMinitext("You stuff more Cherry Branches into the crate.")
					player:addItem("crate_cherryii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_cherry",101) >= 1) then
						player:sendMinitext("You have too many Cherry Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_cherryi",1)
					player:addItem("branch_crate",1)
					player:sendMinitext("You have removed a bushel of Cherry Branches from your crate.")
					player:addItem("branch_cherry",100)
				end
		end)
	}
	crate_cherryii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=2}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_cherry",100) ~= true) then
						player:sendMinitext("You need a full bundle of Cherry before you can store this material.")
						return
					end
					player:removeItem("branch_cherry",100)
					player:removeItem("crate_cherryii",1)
					player:sendMinitext("You stuff more Cherry Branches into the crate.")
					player:addItem("crate_cherryiii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_cherry",101) >= 1) then
						player:sendMinitext("You have too many Cherry Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_cherryii",1)
					player:addItem("crate_cherryi",1)
					player:sendMinitext("You have removed a bushel of Cherry Branches from your crate.")
					player:addItem("branch_cherry",100)
				end
		end)
	}
	crate_cherryiii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=2}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_cherry",100) ~= true) then
						player:sendMinitext("You need a full bundle of Cherry before you can store this material.")
						return
					end
					player:removeItem("branch_cherry",100)
					player:removeItem("crate_cherryiii",1)
					player:sendMinitext("You stuff more Cherry Branches into the crate.")
					player:addItem("crate_cherryiv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_cherry",101) >= 1) then
						player:sendMinitext("You have too many Cherry Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_cherryiii",1)
					player:addItem("crate_cherryii",1)
					player:sendMinitext("You have removed a bushel of Cherry Branches from your crate.")
					player:addItem("branch_cherry",100)
				end
		end)
	}
	crate_cherryiv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=2}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_cherry",100) ~= true) then
						player:sendMinitext("You need a full bundle of Cherry before you can store this material.")
						return
					end
					player:removeItem("branch_cherry",100)
					player:removeItem("crate_cherryiv",1)
					player:sendMinitext("You stuff more Cherry Branches into the crate.")
					player:addItem("crate_cherryv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_cherry",101) >= 1) then
						player:sendMinitext("You have too many Cherry Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_cherryiv",1)
					player:addItem("crate_cherryiii",1)
					player:sendMinitext("You have removed a bushel of Cherry Branches from your crate.")
					player:addItem("branch_cherry",100)
				end
		end)
	}
	crate_cherryv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=2}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
		        local opts = { }
					
			player:dialogSeq({t,"By clicking next, you will remove a bushel of Cherry from this crate."},1)
				if (player:hasItem("branch_cherry",101) >= 1) then
					player:sendMinitext("You have too many Cherry Branches in your inventory to take any more out.")
					return
				end

			player:removeItem("crate_cherryv",1)
			player:addItem("crate_cherryiv",1)
			player:sendMinitext("You have removed a bushel of Cherry Branches from your crate.")
			player:addItem("branch_cherry",100)
		end)
	}
-- OAK CRATE
	crate_oaki = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=13}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_oak",100) ~= true) then
						player:sendMinitext("You need a full bundle of Oak before you can store this material.")
						return
					end
					player:removeItem("branch_oak",100)
					player:removeItem("crate_oaki",1)
					player:sendMinitext("You stuff more Oak Branches into the crate.")
					player:addItem("crate_oakii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_oak",101) >= 1) then
						player:sendMinitext("You have too many Oak Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_oaki",1)
					player:addItem("branch_crate",1)
					player:sendMinitext("You have removed a bushel of Oak Branches from your crate.")
					player:addItem("branch_oak",100)
				end
		end)
	}
	crate_oakii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=13}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_oak",100) ~= true) then
						player:sendMinitext("You need a full bundle of Oak before you can store this material.")
						return
					end
					player:removeItem("branch_oak",100)
					player:removeItem("crate_oakii",1)
					player:sendMinitext("You stuff more Oak Branches into the crate.")
					player:addItem("crate_oakiii",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_oak",101) >= 1) then
						player:sendMinitext("You have too many Oak Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_oakii",1)
					player:addItem("crate_oaki",1)
					player:sendMinitext("You have removed a bushel of Oak Branches from your crate.")
					player:addItem("branch_oak",100)
				end
		end)
	}
	crate_oakiii = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=13}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_oak",100) ~= true) then
						player:sendMinitext("You need a full bundle of Oak before you can store this material.")
						return
					end
					player:removeItem("branch_oak",100)
					player:removeItem("crate_oakiii",1)
					player:sendMinitext("You stuff more Oak Branches into the crate.")
					player:addItem("crate_oakiv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_oak",101) >= 1) then
						player:sendMinitext("You have too many Oak Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_oakiii",1)
					player:addItem("crate_oakii",1)
					player:sendMinitext("You have removed a bushel of Oak Branches from your crate.")
					player:addItem("branch_oak",100)
				end
		end)
	}
	crate_oakiv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=13}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
			local opts = { }
				table.insert(opts,"Add more into your crate.")
				table.insert(opts,"Remove a bundle from your crate.")

			local choice=player:menuString3("Which would you like to do?", opts)
				if (choice == "Add more into your crate.") then
					if(player:hasItem("branch_oak",100) ~= true) then
						player:sendMinitext("You need a full bundle of Oak before you can store this material.")
						return
					end
					player:removeItem("branch_oak",100)
					player:removeItem("crate_oakiv",1)
					player:sendMinitext("You stuff more Oak branches Branches into the crate.")
					player:addItem("crate_oakv",1)

				elseif (choice == "Remove a bundle from your crate.") then
					if (player:hasItem("branch_oak",101) >= 1) then
						player:sendMinitext("You have too many Oak Branches in your inventory to take any more out.")
						return
					end
					player:removeItem("crate_oakiv",1)
					player:addItem("crate_oakiii",1)
					player:sendMinitext("You have removed a bushel of Oak Branches from your crate.")
					player:addItem("branch_oak",100)
				end
		end)
	}
	crate_oakv = {
		use = async(function(player)
			local t={graphic=convertGraphic(3313,"item"),color=13}
			player.npcGraphic = t.graphic
			player.npcColor = t.color
			player.dialogType = 0
			
		        local opts = { }
					
			player:dialogSeq({t,"By clicking next, you will remove a bushel of Oak from this crate."},1)
				if (player:hasItem("branch_oak",101) >= 1) then
					player:sendMinitext("You have too many Oak Branches in your inventory to take any more out.")
					return
				end

			player:removeItem("crate_oakv",1)
			player:addItem("crate_oakiv",1)
			player:sendMinitext("You have removed a bushel of Oak Branches from your crate.")
			player:addItem("branch_oak",100)
		end)
	}