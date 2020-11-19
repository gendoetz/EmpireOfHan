lib_bossarmor = {
use = async(function(player)
	local itemB = {graphic = convertGraphic(2774, "item"), color = 30}
	local itemM = {graphic = convertGraphic(1166, "item"), color = 30}
	local itemF = {graphic = convertGraphic(1171, "item"), color = 30}

	local itemGiven = tonumber(player.sex)

	player:dialogSeq({itemB, "You begin to unravel the carefully folded fabric.."}, 1)

		if (itemGiven == 0) then
			player:removeItem("lib_bossarmor", 1)
			player:addItem("lib_bossarmorM", 1)
			player:dialogSeq({itemM, "..as you completely unfurl the cloth, you see it resembles a robe in your size."}, 0)
		elseif (itemGiven == 1) then
			player:removeItem("lib_bossarmor", 1)
			player:addItem("lib_bossarmorF", 1)
			player:dialogSeq({itemF, "..as you completely unfurl the cloth, you see it resembles a gown in your size."}, 0)
		end
end),

}