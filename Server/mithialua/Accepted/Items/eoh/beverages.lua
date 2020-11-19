pinyan_soju = {
use = function(player)
	local magicGiven = 50
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("pinyan_soju", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		--player.magic = player.magic + magicGiven
		--player:sendStatus()
		player:addMagic(magicGiven)
	end
end
}

pinyan_soju2 = {
use = function(player)
	local magicGiven = 100
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("pinyan_soju2", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		--player.magic = player.magic + magicGiven
		--player:sendStatus()
		player:addMagic(magicGiven)
	end
end
}

smooth_podoju = {
use = function(player)
	local magicGiven = 150
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("smooth_podoju", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		--player.magic = player.magic + magicGiven
		--player:sendStatus()
		player:addMagic(magicGiven)
	end
end
}

dark_fae_cider = {
use = function(player)
	local magicGiven = 200
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("dark_fae_cider", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		--player.magic = player.magic + magicGiven
		--player:sendStatus()
		player:addMagic(magicGiven)
	end
end
}

pirate_drink1 = {
use = function(player)
	local magicGiven = 500
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("pirate_drink1", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		--player.magic = player.magic + magicGiven
		--player:sendStatus()
		player:addMagic(magicGiven)
	end
end
}