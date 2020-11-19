sell_exp_npc = {
click = function(player, npc)

	if (player.level >= 99) then
		local t = {graphic = convertGraphic(87,"monster"),color=24}
		local opts = {}
		--player.lastClick = npc.ID

		player.npcGraphic=t.graphic
		player.npcColor=t.color
		player.dialogType = 0

		sell_exp_npc.sellexp(player)
	end
end,

sellexp = async(function(player)
	local t = {graphic = convertGraphic(87,"monster"),color=24}
	local opts = {}

	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0

	table.insert(opts,"Training Mind & Body")

	if(#opts ~= 0) then
		local menuOption=player:menuString("Welcome to Pristine Echos, here you may reflect upon your experience gained and grow in knowledge and power. How may I assist you?", opts)
		if(menuOption=="Training Mind & Body") then
			player:sellExperience()
		end
	end
end),
}