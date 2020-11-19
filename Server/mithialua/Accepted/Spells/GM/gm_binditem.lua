gm_binditem = {
cast = async(function(player,target)
	local t = {graphic = convertGraphic(654,"monster"),color=15}
	
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	if(player:getInventoryItem(0)~=nil) then
		local item=player:getInventoryItem(0)
		local name=player:input("Who's ID#?")
		--item.owner_id=player.ID
		item.owner=name
		player:updateInv()
	else
		player:sendMinitext("No item in slot a.")
	end
end),

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Bonds the item in the -a- slot to the name you choose. Bonded items can only be used by the character named."}
	return level, items, itemAmounts, description
end
}  