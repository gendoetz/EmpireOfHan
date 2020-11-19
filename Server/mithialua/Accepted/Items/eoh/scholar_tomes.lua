magic_tome = {
use = function(player)
	local magicGiven = 1000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("magic_tome", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		player.magic = player.magic + magicGiven
		player:sendStatus()
	end
end
}

healing_tome = {
use = function(player)
	local healthGiven = 2000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasItem("healing_tome", 1) == true) then
		player:deductDuraInv(player.invSlot, 1)
		player:sendAction(7,14)
		player.health = player.health + healthGiven
		player:sendStatus()
	end
end
}

might_tome = {
use = function(player)
	--local aether = 120000
	local duration = 3600000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("might_tome")) then
		player:sendMinitext("That tome is already in effect.")
		return
	end
	
	player:sendAction(7, 20)
	player:setDuration("might_tome", duration)
	player:playSound(28)
	player:sendAnimation(21, 0)
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("Your Might has increased.")
	player:removeItem("might_tome",1)
end,

recast = function(block)
	block.might = block.might + 10
end,

uncast = function(block)
	block:calcStat()
end,
}

grace_tome = {
use = function(player)
	--local aether = 120000
	local duration = 3600000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("grace_tome")) then
		player:sendMinitext("That tome is already in effect.")
		return
	end
	
	player:sendAction(7, 20)
	player:setDuration("grace_tome", duration)
	player:playSound(28)
	player:sendAnimation(21, 0)
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("Your Grace has increased.")
	player:removeItem("grace_tome",1)
end,

recast = function(block)
	block.grace = block.grace + 10
end,

uncast = function(block)
	block:calcStat()
end,
}

will_tome = {
use = function(player)
	--local aether = 120000
	local duration = 3600000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("will_tome")) then
		player:sendMinitext("That tome is already in effect.")
		return
	end
	
	player:sendAction(7, 20)
	player:setDuration("will_tome", duration)
	player:playSound(28)
	player:sendAnimation(21, 0)
	player:sendStatus()
	player:calcStat()
	player:sendMinitext("Your Will has increased.")
	player:removeItem("will_tome",1)
end,

recast = function(block)
	block.will = block.will + 10
end,

uncast = function(block)
	block:calcStat()
end,
}