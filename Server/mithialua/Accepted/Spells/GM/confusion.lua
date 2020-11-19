confusion = {
cast = function(player, target)
		if(player.state==1) then
			player:sendMinitext("Spirits can't do that.")
			return
		end

		if(target.state==1) then
			player:sendMinitext("This wouldn't be of very much help right now.")
			return
		end

		--if(target.blType==BL_MOB) then
		--	player:sendMinitext("Something went wrong.")
		--	return
		--end

		if(target:hasDuration("Confusion")) then
			player:sendMinitext("Confusion is already in effect.")
			return
		end

			target:sendAnimation(200)
			player:playSound(65)
         
		--if(player.ID~=target.ID) then
		--	target:sendMinitext("You feel dizzy.")
		--end

		if(target.blType==BL_PC) then
                     target:setDuration("confusion",10000)
		     player:sendMinitext("You cast Confusion.")
                     player:sendAction(6,35)   
                     target.drunk = 255    
		end
		if(target.blType==BL_MOB) then
			--target.attacker = nil
			--target.target = nil
			player:setThreat(target.ID, 0)
			target.attacker = nil
			target.target = nil
			player:sendMinitext("You cast Confusion.")
            player:sendAction(6,35)   
		end 
end,

while_cast = function(block)
	block.drunk = 255
	block:sendStatus()
	block:updateState()
end,

uncast = function(block)
	if(block.blType==BL_PC) then
		block:sendMinitext("Your balance has returned.")
	end
	block.drunk = 0
	block:sendStatus()
	block:updateState()
end,

requirements = function(player)

	end       
}