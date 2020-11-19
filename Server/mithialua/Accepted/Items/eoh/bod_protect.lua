bod_protect = {
use = async(function(player)
	local astra = {graphic = convertGraphic(3329, "item"), color = 0}
	local gfx = {graphic = convertGraphic(654,"monster"),color=15}

	player.npcGraphic = astra.graphic
	player.npcColor = astra.color
	player.dialogType = 0

	if(player.state==1) then
		player:sendMinitext("You cannot do that while dead.")
		return
	elseif (player.state == 3) then
		player:sendMinitext("Can't do that while riding.")
		return
	end

	--local item = player:getInventoryItem(player.invSlot)

	local menuchoice = player:menuString3("The Astra Orb contains a magical enchantment that protects items from shattering upon a soul's departure to the void. Do you wish to protect an item?", {"Yes", "No"})
	if (menuchoice == "Yes") then
		local itemTable = {}
		local found = 0

		for i = 0, player.maxInv do
		local nItem = player:getInventoryItem(i)
		
		if (nItem ~= nil and nItem.id > 0) then
				if (#itemTable > 0) then
					found = 0

					if (nItem.id == 349) then
						found = 1
					end
					
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
					if (nItem.id ~= 349) then
						table.insert(itemTable, nItem.id)
					end
				end
			end
		end
		player.npcGraphic = gfx.graphic
		player.npcColor = gfx.color
		player.dialogType = 0
		local choice = player:sell("The magic within the orb speaks to you: What item will you protect?", itemTable)
		local dItem = player:getInventoryItem(choice - 1)

			if (dItem.breakondeath ~= 1) then
				player:dialogSeq({astra, "Protection of this item is unnecessary, it will not shatter upon death."}, 1)
				return
			end
			if (dItem.breakondeath == 1) then
				if (player:hasItem("bod_protect", 1) == true) then
					player:removeItem("bod_protect", 1)
					dItem.protectnum = dItem.protectnum + 1
					player:updateInv()
					player:dialogSeq({astra, "Your item has been protected from shattering."}, 1)
				else
					player:dialogSeq({astra, "You have no Astra Orb to use..."}, 1)
				end
			end
	end
end),
}