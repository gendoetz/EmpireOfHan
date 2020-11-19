gm_blind = {
cast=function(player,target)
	if(player.state==1) then
		player:sendMinitext("Spirits can't do that.")
		return
	end


	if(target:hasDuration("gm_blind")) then
		player:sendMinitext("Blind is already in effect.")
		return
	end
			

	target:sendAnimation(11)
	player:playSound(65)
	         
	if(player.ID~=target.ID) then
	target:sendMinitext("You have lost your sight.")
	end

	if(target.blType==BL_PC) then
	target:setDuration("gm_blind",100000)
	player:sendMinitext("You cast Blind.")
	player:sendAction(6,35)
	end

	target.blind = 1

end,

while_cast=function(player)
	player.blind = 1
end,

uncast=function(block)
	block:sendMinitext("You can see again.")
	block.blind = 0
	block:updateState()
	block:calcStat()
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Resurrect brings back a target from the dead."}
	return level, items, itemAmounts, description
end
}