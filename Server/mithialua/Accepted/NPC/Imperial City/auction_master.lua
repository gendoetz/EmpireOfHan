auction_master = {
	click =async(function(player,npc)

	local t={graphic=convertGraphic(877,"monster"),color=0}
	local auctioneditems = {}
	local itemsicon = {}
	local itemcount = {}
	local itemtext = {}
	local itemdisc = {}
	local sellbuy = {}
	local ownitems ={}
	local criterias = {}
	local itemsbyname = {}
	local itemsbycost = {}
	local earningschoice = {}
	local findItemname

	local anyang_items = {349, 348, 421, 422, 423, 424}
	local anyang_amount = {5, 1, 1, 1, 1, 1}

    player.npcGraphic=t.graphic
	player.npcColor=t.color


		for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
			if (player.mapRegistry["auctionhouse"..i.."id"] ~= 0) then
				if(player.mapRegistry["auctionhouse"..i.."timelimit"]<os.time() and player.mapRegistry["auctionhouse"..i.."timelimit"]) then
						local itemname = player.mapRegistry["auctionhouse"..i.."id"]
						local itemcount = player.mapRegistry["auctionhouse"..i.."count"]
						local sellerid = player.mapRegistry["auctionhouse"..i.."sellerid"]
						player.mapRegistry["auctionhouse"..i.."id"]=0
						player.mapRegistry["auctionhouse"..i.."price"]=0
						player.mapRegistry["auctionhouse"..i.."count"]=0
						player.mapRegistry["sellerid"..sellerid.."usedslots"]=player.mapRegistry["sellerid"..sellerid.."usedslots"]-1
						player.mapRegistry["auctionhouse"..i.."sellerid"]=0
						player.mapRegistry["auctionhouse"..i.."timelimit"]=0
						
						player:sendParcel(sellerid, sellerid, itemname, itemcount, 0, "", 0)

				end
			end
		end

	player.mapRegistry["sellerid"..player.ID.."maxslots"] = 5

	table.insert(sellbuy,"Items For Sale")
	table.insert(sellbuy,"Sale Search")
	table.insert(sellbuy,"- Sell Item")
	table.insert(sellbuy,"- Cancel Item Sale")

	table.insert(sellbuy," ")
	table.insert(sellbuy,"Collect Money")
	table.insert(sellbuy," ")
	table.insert(sellbuy,"An Yang Exchange")

	table.insert(criterias,"Item Name")
	table.insert(criterias,"Cost Range")

	table.insert(earningschoice,"Money")
	table.insert(earningschoice,"Items")
	
	local menuChoice=player:menuString("How can I help you?",sellbuy)


	if(menuChoice=="Items For Sale") then
		table.insert(auctioneditems,"Item Name (Amount) - Cost")
		table.insert(auctioneditems,"--------------------------------------")
		for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
			if(player.mapRegistry["auctionhouse"..i.."id"]>0 and player.mapRegistry["auctionhouse"..i.."count"]>0 and player.mapRegistry["auctionhouse"..i.."price"]>0 and player.mapRegistry["auctionhouse"..i.."sellerid"]>0 and (player.mapRegistry["auctionhouse"..i.."timelimit"]>os.time() or player.mapRegistry["auctionhouse"..i.."timelimit"]==0)) then
				table.insert(auctioneditems, Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins")
				
			end
		end

		if(#auctioneditems==0) then
			player:dialogSeq({t,"No items are currently being sold, sorry."})
			return
		end

		local choice=player:menuString2("You are viewing all items currently for sale.", auctioneditems)

		for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
			if(choice == Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins") then
			local itemname=player.mapRegistry["auctionhouse"..i.."id"]
			local itemprice=player.mapRegistry["auctionhouse"..i.."price"]
			local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
			local itemsellerid=player.mapRegistry["auctionhouse"..i.."sellerid"]
			if(player.mapRegistry["auctionhouse"..i.."sellerid"]==player.ID) then
				player:dialogSeq({t,"You may not buy your own items."})
			end	
			player:dialogSeq({t,"You are about to pay "..player.mapRegistry["auctionhouse"..i.."price"].." coins for "..player.mapRegistry["auctionhouse"..i.."count"].." "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name..". Are you certain of your decision? If You are, click next to proceed."},1)
				if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
					local salewithdrawchoice=player:menuString2("Where to you wish to direct the item? ((Attention: If you choose inventory and you do not have enough space to hold everything, the rest of the items will fall on the ground!))",{"Inventory","Bank"})
					if(salewithdrawchoice=="Inventory") then
						if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
							player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
							if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
								player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
							end
							if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
								player.mapRegistry["auctionhouse"..i.."id"]=0
								player.mapRegistry["auctionhouse"..i.."price"]=0
								player.mapRegistry["auctionhouse"..i.."count"]=0
								player.mapRegistry["auctionhouse"..i.."sellerid"]=0
								player.mapRegistry["auctionhouse"..i.."timelimit"]=0
								player:addItem(itemname,itemcount)
								player.money=player.money-itemprice
								player:sendStatus()
							else
								player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
							end
						else
							player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
						end
					elseif(salewithdrawchoice=="Bank") then
						if(Item(itemname).depositable == true) then
								player:dialogSeq({t,"This item can't be banked."})
						end
						if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
							local itemname=player.mapRegistry["auctionhouse"..i.."id"]
							local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
							player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
							if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
								player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
							end
							if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
								player.mapRegistry["auctionhouse"..i.."id"]=0
								player.mapRegistry["auctionhouse"..i.."price"]=0
								player.mapRegistry["auctionhouse"..i.."count"]=0
								player.mapRegistry["auctionhouse"..i.."sellerid"]=0
								player.mapRegistry["auctionhouse"..i.."timelimit"]=0
								player.money=player.money-itemprice
								player:sendStatus()

								local bankItemTable = player:checkBankItems()

								if (#bankItemTable >= 256) then
									player:dialogSeq({"You have too many items deposited."})
									return
								end
		
								player:bankDeposit(itemname, itemcount, 0, "", 0)
								player:dialogSeq({t,"The item has been transfered to your bank"})
							else
								player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
							end
						else
							player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
						end
					end
				else
					player:dialogSeq({t,"You do not have enough money."})
				end
			end
		end

	elseif(menuChoice=="Collect Money") then
		player:dialogSeq({t,"This tool allows you to collect profits from sales."},1)


				if(player.mapRegistry["sellerid"..player.ID.."total"]>=0) then

					for i=1,player.mapRegistry["ahauctioncurrentnumber"] do

						if(player.mapRegistry["ahauction"..i.."sellerid"]==player.ID and os.time()>=player.mapRegistry["ahauction"..i.."endingtime"] and player.mapRegistry["ahauction"..i.."price"]>0 and player.mapRegistry["ahauction"..i.."currentbidderid"]~=0) then
							player.mapRegistry["sellerid"..player.ID.."total"]=player.mapRegistry["sellerid"..player.ID.."total"]+player.mapRegistry["ahauction"..i.."price"]
							if(player.mapRegistry["ahauction"..i.."sellerid"]==player.ID) then
								--local itemsellerid=player.mapRegistry["ahauction"..i.."sellerid"]
								player.mapRegistry["sellerid"..player.ID.."ahusedslots"]=player.mapRegistry["sellerid"..player.ID.."ahusedslots"]-1
							end
							player.mapRegistry["ahauction"..i.."price"]=0
							player.mapRegistry["ahauction"..i.."sellerid"]=0
							--player.mapRegistry["ahauctioncurrentnumber"] = player.mapRegistry["ahauctioncurrentnumber"]-1
						end

					end
					local tot=player.mapRegistry["sellerid"..player.ID.."total"]
					player:dialogSeq({t,"I am currently holding "..player.mapRegistry["sellerid"..player.ID.."total"].." coins from your sale(s) and failed bids. Click next if you want to collect them now."},1)
					player.money=player.money+tot
					player.mapRegistry["sellerid"..player.ID.."total"]=player.mapRegistry["sellerid"..player.ID.."total"]-tot
					player:sendStatus()
				else
					player:dialogSeq({t,"I am sorry, but none of the gold I am holding belongs to you."})
				end

	elseif(menuChoice=="- Sell Item") then
		if(player.level<25) then
				player:dialogSeq({t,"You must be at least level 25 to use the auction house services."})
				return
		end
		--if(player.gmLevel<99) then
			if(player.mapRegistry["sellerid"..player.ID.."usedslots"]>=player.mapRegistry["sellerid"..player.ID.."maxslots"]+1) then
					player:dialogSeq({t,"You are currently only allowed to put up "..(player.mapRegistry["sellerid"..player.ID.."maxslots"]+1).." item(s) for sale at the same time."})
					return
			end
		--end
			
		local withdrawchoice=player:menuString2("Where do you wish to select your item from ?",{"Inventory", "Bank"})--,"Bank"})
		if(withdrawchoice=="Inventory") then
			local sellList= { }
			local amount=0
	
			for x=0,25 do
				local item=nil
				item=player:getInventoryItem(x)
				if(item ~= nil) then
					if(item.dura==item.maxDura) then
						if(item.depositable == false and item.droppable == false and item.exchangeable == false and item.owner == 0 and item.protectnum == 0) then
								table.insert(sellList,x)
						end
					end
				end
			end
			if(#sellList==0) then
				player:dialogSeq({t,"You have nothing you can sell."})
			return end
	
			local choice=player:sell2("What do you wish to put on sale?",sellList)
			local item=player:getInventoryItem(choice-1)

			     if(item.amount>1) then
					amount=math.abs(tonumber(math.ceil(player:input("How many do you wish to put on sale?"))))
					if(amount==0) then
						player:dialogSeq({t,"You can not do that!"})
					end

					if(amount>4000000000 or not player:hasItem(item.id,amount) == true) then 
						player:dialogSeq({t,"You do not possess that many!"})
					end
					
					
			     else
					amount=1
			     end

			local price=math.abs(tonumber(math.ceil(player:input("How much do you wish to put that lot on sale for?"))))

			if (price > 999999999) then
				price = 999999999
			end

			if(player:hasItem(item.id,amount) ~= true) then
				player:dialogSeq({t,"Cannot be sold."})
				return
			end
			local nchoice=player:menuString2("Are you sure you wish to put "..amount.." "..item.name.." for sale at a price of "..price.." coins?",{"Yes","No"})
			if(nchoice=="Yes" and player:hasItem(item.id,amount) == true) then
				for x=1,player.mapRegistry["auctionhousecurrentnumber"] do
					if(player.mapRegistry["auctionhouse"..x.."id"]==0 and player.mapRegistry["auctionhouse"..x.."price"]==0 and player.mapRegistry["auctionhouse"..x.."count"]==0 and player.mapRegistry["auctionhouse"..x.."sellerid"]==0 and player.mapRegistry["auctionhouse"..x.."timelimit"]==0) then
						player.mapRegistry["auctionhouse"..x.."id"]=item.id
						player.mapRegistry["auctionhouse"..x.."price"]=price
						player.mapRegistry["auctionhouse"..x.."count"]=amount
						player.mapRegistry["auctionhouse"..x.."sellerid"]=player.ID
						player.mapRegistry["auctionhouse"..x.."timelimit"]=os.time()+(60*60*24*7)
						--player.mapRegistry["auctionhouse"..x.."timelimit"]=os.time()+30
						player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..player.ID.."usedslots"]+1
						player:updateInv()
						player:sendStatus()
						player:removeItem(item.id,amount)
						player:dialogSeq({t,"Your item can now be bought."})
						return
					end
				end
					player.mapRegistry["auctionhousecurrentnumber"]=player.mapRegistry["auctionhousecurrentnumber"]+1
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."id"]=item.id
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."price"]=price
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."count"]=amount
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."sellerid"]=player.ID
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."timelimit"]=os.time()+(60*60*24*7)
					--player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."timelimit"]=os.time()+30
					player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..player.ID.."usedslots"]+1
					player:updateInv()
					player:sendStatus()
					player:removeItem(item.id,amount)
					player:dialogSeq({t,"Your item can now be bought."})
			else
				player:dialogSeq({t,"No problem..."})
			end
		
		elseif(withdrawchoice=="Bank") then
			local bankItemTable = player:checkBankItems()
			local bankCountTable = player:checkBankAmounts()
			local bankOwnerTable = player:checkBankOwners()
			local bankEngraveTable = player:checkBankEngraves()
			local bankProtectTable = player:checkBankProtects()
			local found = 0
			local amount = 0
			local counter = 0
			local next = next

			if (#bankItemTable > 0) then

				for i = 1, #bankItemTable do
					if (bankItemTable[i] == 0) then
						counter = #bankItemTable
						
						for j = i, counter do
							table.remove(bankItemTable, i)
							table.remove(bankCountTable, i)
							table.remove(bankOwnerTable, i)
							table.remove(bankEngraveTable, i)
							table.remove(bankProtectTable, i)
						end
						
						break
					end
				end

			end

			if (next(bankItemTable) == 0) then
				player:dialogSeq({t,"Your bank is currently empty."})
				return false
			end
			local temp = player:bBank("Which item do you want to sell?", bankItemTable, bankCountTable, {}, {})

			for i = 1, 255 do
				if (bankItemTable[i] == temp and bankEngraveTable[i] == "" and bankOwnerTable[i] == 0 and bankProtectTable[i] == 0) then
					found = i
					break
				end
			end

			if (found == 0) then
				player:dialogSeq({t,"Sorry, this item can't be sold. ((Item restricted.))"})
			end
			
			if(Item(bankItemTable[found]).droppable == true) then
				player:dialogSeq({t,"Sorry, this item can't be sold. ((Item is either non droppable or non exchangeable))"})
			end
			if(Item(bankItemTable[found]).exchangeable == true) then
				player:dialogSeq({t,"Sorry, this item can't be sold. ((Item is either non droppable or non exchangeable))"})
			end

			

			if(Item(bankItemTable[found]).maxAmount>1) then
				amount=player:input("How many do you want to put for sale?")
				amount=math.ceil(math.abs(tonumber(amount)))
				if(amount==0) then
					player:dialogSeq({t,"You can not do that!"})
				end

				if(amount>bankCountTable[found]) then amount=bankCountTable[found] end
			else
				amount=1
			end

			local price=math.abs(tonumber(math.ceil(player:input("How much do you wish to put that lot on sale for?"))))
			local nchoice=player:menuString2("Are you sure you wish to put "..amount.." "..Item(bankItemTable[found]).name.." for sale at a price of "..price.." coins?",{"Yes","No"})
			if(nchoice=="Yes") then
				for x=1,player.mapRegistry["auctionhousecurrentnumber"] do
					if(player.mapRegistry["auctionhouse"..x.."id"]==0 and player.mapRegistry["auctionhouse"..x.."price"]==0 and player.mapRegistry["auctionhouse"..x.."count"]==0 and player.mapRegistry["auctionhouse"..x.."sellerid"]==0) then
						player.mapRegistry["auctionhouse"..x.."id"]=Item(bankItemTable[found]).id
						player.mapRegistry["auctionhouse"..x.."price"]=price
						player.mapRegistry["auctionhouse"..x.."count"]=amount
						player.mapRegistry["auctionhouse"..x.."sellerid"]=player.ID
						player.mapRegistry["auctionhouse"..x.."timelimit"]=os.time()+(60*60*24*7)
						--player.mapRegistry["auctionhouse"..x.."timelimit"]=os.time()+60
						player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..player.ID.."usedslots"]+1

						player:bankWithdraw(bankItemTable[found], amount, bankOwnerTable[found], bankEngraveTable[found], bankProtectTable[found])

						player:updateInv()
						player:sendStatus()
						player:dialogSeq({t,"Your item can now be bought."})
						return
					end
				end
					player.mapRegistry["auctionhousecurrentnumber"]=player.mapRegistry["auctionhousecurrentnumber"]+1
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."id"]=Item(bankItemTable[found]).id
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."price"]=price
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."count"]=amount
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."sellerid"]=player.ID
					player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."timelimit"]=os.time()+(60*60*24*7)
					--player.mapRegistry["auctionhouse"..player.mapRegistry["auctionhousecurrentnumber"].."timelimit"]=os.time()+60
					player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..player.ID.."usedslots"]+1

					player:bankWithdraw(bankItemTable[found], amount, bankOwnerTable[found], bankEngraveTable[found], bankProtectTable[found])

					player:updateInv()
					player:sendStatus()
					player:dialogSeq({t,"Your item can now be bought."})
			end
		



		end

	

	elseif(menuChoice=="- Cancel Item Sale") then


		for i=1,player.mapRegistry["auctionhousecurrentnumber"] do

			if(player.mapRegistry["auctionhouse"..i.."sellerid"]==player.ID and player.mapRegistry["auctionhouse"..i.."id"]~=0 and (player.mapRegistry["auctionhouse"..i.."timelimit"]>os.time() or player.mapRegistry["auctionhouse"..i.."timelimit"]==0)) then
				table.insert(ownitems, Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins")
			end
		end

		local choice=player:menuString2("Here are the items you left with me for sale: ",ownitems)

		for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
			if(choice==Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins" and player.mapRegistry["auctionhouse"..i.."sellerid"]==player.ID) then
			local itemname=player.mapRegistry["auctionhouse"..i.."id"]
			local itemprice=player.mapRegistry["auctionhouse"..i.."price"]
			local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
			local itemsellerid=player.mapRegistry["auctionhouse"..i.."sellerid"]	
			player:dialogSeq({t,"You are about to withdraw "..player.mapRegistry["auctionhouse"..i.."count"].." "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." from sales. Are you certain of your decision? If You are, click next to proceed."},1)
				local salewithdrawchoice=player:menuString2("Where to you wish to direct the item? ((Attention: If you choose inventory and you do not have enough space to hold everything, the rest of the items will fall on the ground!))",{"Inventory","Bank"})
				if(salewithdrawchoice=="Inventory") then
					if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
						player.mapRegistry["auctionhouse"..i.."id"]=0
						player.mapRegistry["auctionhouse"..i.."price"]=0
						player.mapRegistry["auctionhouse"..i.."count"]=0
						player.mapRegistry["auctionhouse"..i.."sellerid"]=0
						player.mapRegistry["auctionhouse"..i.."timelimit"]=0
						if(player.mapRegistry["sellerid"..player.ID.."usedslots"]>0) then
							player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..player.ID.."usedslots"]-1
						end
						player:addItem(itemname,itemcount)
						player:sendStatus()
					else
						player:dialogSeq({t,"Sorry, but this item has already been sold."})
					end
				elseif(salewithdrawchoice=="Bank") then
					if(Item(itemname).depositable == true) then
							player:dialogSeq({t,"This item can't be banked."})
					end
					moneycount=math.ceil(itemcount/Item(itemname).maxAmount)
					moneyamount=Item(itemname).price*0.10*moneycount
					moneychoice=player:menuString2("The fee is " .. moneyamount .. " do you accept?",{"Yes"},{"No"})
					if(moneychoice=="Yes") then
					if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
							
							local bankItemTable = player:checkBankItems()

							if (#bankItemTable >= 256) then
								player:dialogSeq({"You have too many items deposited."})
								return
							end

							local itemname=player.mapRegistry["auctionhouse"..i.."id"]
							local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
							player.mapRegistry["auctionhouse"..i.."id"]=0
							player.mapRegistry["auctionhouse"..i.."price"]=0
							player.mapRegistry["auctionhouse"..i.."count"]=0
							player.mapRegistry["auctionhouse"..i.."sellerid"]=0
							player.mapRegistry["auctionhouse"..i.."timelimit"]=0
							if(player.mapRegistry["sellerid"..player.ID.."usedslots"]>0) then
								player.mapRegistry["sellerid"..player.ID.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
							end
							
							--HERE
							
	
							player:bankDeposit(itemname, itemcount, 0, "", 0)
							player:dialogSeq({t,"The item has been transfered to your bank"})
					else
						player:dialogSeq({t,"Sorry, but this item has already been sold."})
					end
					end


				end
			end
		end


	elseif(menuChoice=="Sale Search") then


		local criteriachoice=player:menuString2("Which criteria do you wish to use?",criterias)

			if(criteriachoice=="Item Name") then
				local partialname=string.lower(player:input("Please input the partial or total name of the item you are looking for"))
				for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
					if(player.mapRegistry["auctionhouse"..i.."id"]>0 and player.mapRegistry["auctionhouse"..i.."count"]>0 and player.mapRegistry["auctionhouse"..i.."price"]>0 and player.mapRegistry["auctionhouse"..i.."sellerid"]>0 and (player.mapRegistry["auctionhouse"..i.."timelimit"]>os.time() or player.mapRegistry["auctionhouse"..i.."timelimit"]==0)) then
						if(string.find(string.lower(Item(player.mapRegistry["auctionhouse"..i.."id"]).name),partialname)~=nil) then
							table.insert(itemsbyname, Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins")
						end	
					end
				end

				if(#itemsbyname==0) then
						player:dialogSeq({t,"There are currently no items being sold containing the letters : "..partialname.."."})
				elseif(#itemsbyname>0) then
					--local choice=player:menuString2("Items for sale containing the letters "..partialname.." :",itemsbyname)
					local choice=player:menuString2("Items for sale containing the letters "..partialname..".", itemsbyname)

					for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
						--if(choice=="("..i..") : "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins") then
						if(choice == Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins") then
							if(player.mapRegistry["auctionhouse"..i.."sellerid"]==player.ID) then
								player:dialogSeq({t,"You may not buy your own items."})
							end	
							local itemname=player.mapRegistry["auctionhouse"..i.."id"]
							local itemprice=player.mapRegistry["auctionhouse"..i.."price"]
							local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
							local itemsellerid=player.mapRegistry["auctionhouse"..i.."sellerid"]

							player:dialogSeq({t,"You are about to pay "..player.mapRegistry["auctionhouse"..i.."price"].." coins for "..player.mapRegistry["auctionhouse"..i.."count"].." "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name..". Are you certain of your decision? If You are, click next to proceed.((Be careful as if your inventory is full, the items will fall on the floor.))"},1)
								if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
								local salewithdrawchoice=player:menuString2("Where to you wish to direct the item? ((Attention: If you choose inventory and you do not have enough space to hold everything, the rest of the items will fall on the ground!))",{"Inventory","Bank"})
								if(salewithdrawchoice=="Inventory") then
										if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
											player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
											if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
												player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
											end
											if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
												player.mapRegistry["auctionhouse"..i.."id"]=0
												player.mapRegistry["auctionhouse"..i.."price"]=0
												player.mapRegistry["auctionhouse"..i.."count"]=0
												player.mapRegistry["auctionhouse"..i.."sellerid"]=0
												player.mapRegistry["auctionhouse"..i.."timelimit"]=0
												player:addItem(itemname,itemcount)
												player.money=player.money-itemprice
												player:sendStatus()
											else
												player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
											end
										else
											player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
										end
								elseif(salewithdrawchoice=="Bank") then
										if(Item(itemname).depositable == true) then
												player:dialogSeq({t,"This item can't be banked."})
										end
										if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
											local itemname=player.mapRegistry["auctionhouse"..i.."id"]
											local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
											player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
											if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
												player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
											end
											if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
												player.mapRegistry["auctionhouse"..i.."id"]=0
												player.mapRegistry["auctionhouse"..i.."price"]=0
												player.mapRegistry["auctionhouse"..i.."count"]=0
												player.mapRegistry["auctionhouse"..i.."sellerid"]=0
												player.mapRegistry["auctionhouse"..i.."timelimit"]=0
												player.money=player.money-itemprice
												player:sendStatus()

												local bankItemTable = player:checkBankItems()

												if (#bankItemTable >= 256) then
													player:dialogSeq({"You have too many items deposited."})
													return
												end
						
												player:bankDeposit(itemname, itemcount, 0, "", 0)
												player:dialogSeq({t,"The item has been transfered to your bank"})
											else
												player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
											end
										else
											player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
										end
									end
								else
									player:dialogSeq({t,"You do not have enough money."})
								end
						end
					end



				end
			
			elseif(criteriachoice=="Cost Range") then

				local mincost=math.abs(tonumber(math.ceil(player:input("Lowest price possible ? (Enter 0 if you do not wish to limit this parameter)"))))
				local maxcost=math.abs(tonumber(math.ceil(player:input("Highest price possible ? (Enter 0 if you do not wish to limit this parameter)"))))
				if(maxcost==0) then
					maxcost=9999999999
				end


				for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
					if(player.mapRegistry["auctionhouse"..i.."id"]>0 and player.mapRegistry["auctionhouse"..i.."count"]>0 and player.mapRegistry["auctionhouse"..i.."price"]>0 and player.mapRegistry["auctionhouse"..i.."sellerid"]>0 and (player.mapRegistry["auctionhouse"..i.."timelimit"]>os.time() or player.mapRegistry["auctionhouse"..i.."timelimit"]==0)) then
						if(player.mapRegistry["auctionhouse"..i.."price"]>=mincost and player.mapRegistry["auctionhouse"..i.."price"]<=maxcost) then
							table.insert(itemsbycost,Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins")
						end	
					end
				end

				if(#itemsbycost==0) then
						player:dialogSeq({t,"There are currently no items being sold in the range you specified."})
				elseif(#itemsbycost>0) then
					local choice=player:menuString2("Items for sale in the range you specified.", itemsbycost)

					for i=1,player.mapRegistry["auctionhousecurrentnumber"] do
						--if(choice=="("..i..") : "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins") then
						if(choice == Item(player.mapRegistry["auctionhouse"..i.."id"]).name.." ("..player.mapRegistry["auctionhouse"..i.."count"]..") - "..player.mapRegistry["auctionhouse"..i.."price"].." coins") then
							if(player.mapRegistry["auctionhouse"..i.."sellerid"]==player.ID) then
								player:dialogSeq({t,"You may not buy your own items."})
							end	
							local itemname=player.mapRegistry["auctionhouse"..i.."id"]
							local itemprice=player.mapRegistry["auctionhouse"..i.."price"]
							local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
							local itemsellerid=player.mapRegistry["auctionhouse"..i.."sellerid"]	
							player:dialogSeq({t,"You are about to pay "..player.mapRegistry["auctionhouse"..i.."price"].." coins for "..player.mapRegistry["auctionhouse"..i.."count"].." "..Item(player.mapRegistry["auctionhouse"..i.."id"]).name..". Are you certain of your decision? If You are, click next to proceed. ((Be careful as if your inventory is full, the items will fall on the floor.))"},1)
								if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
								local salewithdrawchoice=player:menuString2("Where to you wish to direct the item? ((Attention: If you choose inventory and you do not have enough space to hold everything, the rest of the items will fall on the ground!))",{"Inventory","Bank"})
								if(salewithdrawchoice=="Inventory") then
										if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
											player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
											if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
												player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
											end
											if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
												player.mapRegistry["auctionhouse"..i.."id"]=0
												player.mapRegistry["auctionhouse"..i.."price"]=0
												player.mapRegistry["auctionhouse"..i.."count"]=0
												player.mapRegistry["auctionhouse"..i.."sellerid"]=0
												player.mapRegistry["auctionhouse"..i.."timelimit"]=0
												player:addItem(itemname,itemcount)
												player.money=player.money-itemprice
												player:sendStatus()
											else
												player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
											end
										else
											player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
										end
								elseif(salewithdrawchoice=="Bank") then
										if(Item(itemname).depositable == true) then
												player:dialogSeq({t,"This item can't be banked."})
										end
										if(player.mapRegistry["auctionhouse"..i.."id"]==itemname and player.mapRegistry["auctionhouse"..i.."count"]==itemcount and player.mapRegistry["auctionhouse"..i.."price"]==itemprice and player.mapRegistry["auctionhouse"..i.."sellerid"]==itemsellerid) then
											local itemname=player.mapRegistry["auctionhouse"..i.."id"]
											local itemcount=player.mapRegistry["auctionhouse"..i.."count"]
											player.mapRegistry["sellerid"..itemsellerid.."total"]=player.mapRegistry["sellerid"..itemsellerid.."total"]+itemprice
											if(player.mapRegistry["sellerid"..itemsellerid.."usedslots"]>0) then
												player.mapRegistry["sellerid"..itemsellerid.."usedslots"]=player.mapRegistry["sellerid"..itemsellerid.."usedslots"]-1
											end
											if(player.money>=player.mapRegistry["auctionhouse"..i.."price"]) then
												player.mapRegistry["auctionhouse"..i.."id"]=0
												player.mapRegistry["auctionhouse"..i.."price"]=0
												player.mapRegistry["auctionhouse"..i.."count"]=0
												player.mapRegistry["auctionhouse"..i.."sellerid"]=0
												player.mapRegistry["auctionhouse"..i.."timelimit"]=0
												player.money=player.money-itemprice
												player:sendStatus()

												local bankItemTable = player:checkBankItems()

												if (#bankItemTable >= 256) then
													player:dialogSeq({"You have too many items deposited."})
													return
												end
						
												player:bankDeposit(itemname, itemcount, 0, "", 0)
												player:dialogSeq({t,"The item has been transfered to your bank"})
											else
												player:dialogSeq({t,"Hmm.. your funds seem to have changed.."})
											end
										else
											player:dialogSeq({t,"Sorry, but this item has already been sold or the sale was cancelled"})
										end
									end
								else
									player:dialogSeq({t,"You do not have enough money."})
								end
						end
					end



				end
			end
		elseif (menuChoice=="An Yang Exchange") then
				local anyangchoice=player:buy("Ah, I see you have some An Yang tokens you wish to exchange. Here is what I have to offer. Number of items granted is listed. The cost is one An Yang token.",anyang_items,anyang_amount,{},{})
				if (player:hasItem("rew_token", 1) == true) then
					for i = 1, #anyang_items do
						if (anyang_items[i] == anyangchoice) then
							player:removeItem("rew_token", 1)
							player:addItem(anyangchoice, anyang_amount[i])
						end
					end
				else
					player:dialogSeq({t, "You do not have any An Yang tokens..."}, 0)
					return
				end
		end
	end)
}