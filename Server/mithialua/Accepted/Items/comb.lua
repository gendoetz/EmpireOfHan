t_comb22 = {
use = function(player)
	player:freeAsync()
	--if (player.level >= 50) then
		async(styling2.click(player, Item("comb")))
	--else
	--	player:msg(0, "You are not skilled enough to do that.", player.ID)
	--end
end
}

hair_dye22 = {
use = function(player)
	player:freeAsync()
	--if (player.level >= 50) then
		async(styling_dye.click(player, Item("hair_dye")))
	--else
	--	player:msg(0, "You are not skilled enough to do that.", player.ID)
	--end
end
}

face_putty22 = {
use = function(player)
	player:freeAsync()
	--if (player.level >= 50) then
		async(styling_face.click(player, Item("face_putty")))
	--else
	--	player:msg(0, "You are not skilled enough to do that.", player.ID)
	--end
end
}