pilfer = {
cast = function(player)
	local itemCellBlocks
	local players
	local aether = 1000
	local magicCost = 100
	
	if (not player:canCast(1, 1, 0)) then
		return
	end

	if (player.magic < magicCost) then
		player:sendMinitext("Not enough mana.")
		return
	end

	player:setAether("pilfer", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You use Pilfer.")

	if (player.side == 0) then
		itemCellBlocks = player:getObjectsInCell(player.m, player.x, player.y-1, BL_ITEM)
		players = player:getObjectsInCell(player.m, player.x, player.y-1, BL_PC)
	elseif (player.side == 1) then
		itemCellBlocks = player:getObjectsInCell(player.m, player.x+1, player.y, BL_ITEM)
		players = player:getObjectsInCell(player.m, player.x+1, player.y, BL_PC)
	elseif (player.side == 2) then
		itemCellBlocks = player:getObjectsInCell(player.m, player.x, player.y+1, BL_ITEM)
		players = player:getObjectsInCell(player.m, player.x, player.y+1, BL_PC)
	elseif (player.side == 3) then
		itemCellBlocks = player:getObjectsInCell(player.m, player.x-1, player.y, BL_ITEM)
		players = player:getObjectsInCell(player.m, player.x-1, player.y, BL_PC)
	end

	if (#itemCellBlocks ~= 0 and #players == 0) then

		for i = 1, #itemCellBlocks do
			if (Item(itemCellBlocks[i].id).type ~= 20) then
				if (itemCellBlocks[i].id ~= 36) then
					local timestodo = itemCellBlocks[i].amount

						if (timestodo >= 500 and itemCellBlocks[i].id ~= 0) then
							player:sendMinitext("Too many items to Pilfer.")
							return
						end
						player:talk(2,player.name..": I'll take that...")
						player:pickUp2(itemCellBlocks[i].ID)
				end
			end
		end
	end

end,

requirements = function(player)
	local level = 32
	local items = {}
	local itemAmounts = {}
	local description = {"Pilfer allows you to snag items on the ground in front of you, this ability will not break Invisible or Hide."}
	return level, items, itemAmounts, description
end
}