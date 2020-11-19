dreamweaver = {
check = function(player)
	if (player.gmLevel >= 50) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

magistrate = {
check = function(player)
	if (player.gmLevel >= 20 or player.registry["magistrate"] >= 1) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

laws = {
check = function(player)
	if (player.gmLevel >= 50) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

gm_knowledge = {
check = function(player)
	if (player.gmLevel >= 20) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

arena_board = {
check = function(player)
	if (player.registry["carnagehost"] >= 1) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

the_scholars = {
check = function(player)
	if (player.gmLevel >= 20) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

inspiration = {
check = function(player)
	if (player.gmLevel >= 20) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

guide = {
check = function(player)
	if (player.gmLevel >= 20) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}

stone_tablet = {
check = function(player)
	if (player.gmLevel >= 20) then
		player.boardDel = 1
		player.boardWrite = 1
	end
end
}