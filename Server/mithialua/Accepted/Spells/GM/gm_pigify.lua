gm_pigify = {
cast=function(player,target)
                if(player.state==1) then
			player:sendMinitext("Spirits can't do that.")
			return
		end

		if(target.state==1) then
			player:sendMinitext("This wouldn't be of very much help right now.")
			return
		end

		
	
		if(target.blType==BL_MOB) then
			player:sendMinitext("Something went wrong.")
			return
		end

		if(target:hasDuration("gm_pigify")) then
			player:sendMinitext("Pig is already in effect.")
			return
		end
		

		target:sendAnimation(13)
        player:playSound(65)
         
		if(player.ID~=target.ID) then
			target:sendMinitext("Oink oink oink!")
		end
		if(target.blType==BL_PC) then
			target:setDuration("gm_pigify", 100000)
			player:sendMinitext("You cast Pig.")
			player:sendAction(6,35)       
			target.state = 4
			target.disguise = math.random(1,1031)
			target.registry["morphedanimal"]=target.disguise
			target.disguiseColor = math.random(0,20)
			target:sendStatus()  
			target:updateState()
		end
end,

--while_cast = function(player)
--			player.state=4
--			player.disguise=player.registry["morphedanimal"]
--end,
	
uncast=function(player)
	player:sendMinitext("You have returned to normal.")
	player.registry["morphedanimal"]=0
		if (player.state ~= 1) then
			player.state=0
		end
	player.disguise=0
	player:sendAnimation(13)	
	player:sendStatus()  
	player:updateState()  
end,
	
requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Pigify turns a player into a cute little pig where they are less annoying and all the more improved."}
	return level, items, itemAmounts, description
end    
}
