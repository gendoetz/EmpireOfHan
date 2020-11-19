potion_clarity = {
	use = function(player)
		if(player.state==1) then
			player:sendMinitext("Spirits can't do that")
			return
		end

		player:flushAether()
		player:sendMinitext("Your mind clears...")
		player:removeItem("potion_clarity",1)
	end
}

potion_hpregen1 = {
	use = function(player)
	local duration = 20000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("regen1")) then
		player:sendMinitext("That potion is already in effect.")
		return
	end
	player:removeItem("potion_hpregen1",1)
	player:sendAction(7, 20)
	player:setDuration("regen1", duration)
	player:playSound(28)
	player:sendAnimation(21, 0)
	player:sendStatus()
	player:sendMinitext("Your vita begins to regenerate.")
	end
}

potion_mpregen1 = {
	use = function(player)
	local duration = 20000
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (player:hasDuration("refresh1")) then
		player:sendMinitext("That potion is already in effect.")
		return
	end
	player:removeItem("potion_mpregen1",1)
	player:sendAction(7, 20)
	player:setDuration("refresh1", duration)
	player:playSound(28)
	player:sendAnimation(20, 0)
	player:sendStatus()
	player:sendMinitext("Your mana begins to regenerate.")
	end
}