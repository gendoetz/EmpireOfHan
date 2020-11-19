love_r_koh = {
use = function(player)
	if(player.state==1) then
		player:sendMinitext("You cannot do that while dead.")
		return
	elseif (player.state == 3) then
		player:sendMinitext("Can't do that while riding.")
		return
	end

	if(player.region==100) then
		player:sendMinitext("You cannot do that while in jail.")
		return
	end

	if(player.region==5) then
		player:sendMinitext("You cannot do that while in an event.")
		return
	end

	if (player.spouse ~= 0) then
		local playerpartner = Player(player.spouse)

		if(playerpartner == nil) then
			player:sendMinitext("They are not online.")
			return
		end

		if(playerpartner.state == 1) then
			player:sendMinitext("You cannot do that while your partner is dead.")
			return
		end

		if(playerpartner.region == 100) then
			player:sendMinitext("You cannot do that while your partner is in jail.")
		return
		end

		if(playerpartner.region == 5) then
			player:sendMinitext("Your partner is in an event at this time.")
			return
		end

		if (playerpartner.m == 518 or playerpartner.m == 585 or playerpartner.m == 586 or playerpartner.m == 587) then
			player:sendMinitext("That doesn't work.")
			return
		end

		--if (playerpartner.region == 1) then
		--	player:sendMinitext("Your bonded partner is in a restricted place.")
		--	return
		--end

		--check level
		if (playerpartner.mapRegistry["bondedRing_levelReq"] > 0 and playerpartner.mapRegistry["bondedRing_levelReq"] > player.level) then
			player:sendMinitext("Your bonded partner is in a place too dangerous for you.")
			return
		end

		--check vita/mana requirements
		if (playerpartner.mapRegistry["bondedRing_vitaReq"] > player.maxHealth and playerpartner.mapRegistry["bondedRing_manaReq"] > player.maxMagic) then
			player:sendMinitext("Your bonded partner is in a place too dangerous for you.")
			return
		end

		if (playerpartner.mapRegistry["bondedRing_levelReq"] == 0 and playerpartner.mapRegistry["bondedRing_vitaReq"] == 0 and playerpartner.mapRegistry["bondedRing_manaReq"] == 0) then
			player:sendMinitext("Your bonded partner is in a place the magic of this ring cannot reach.")
			return
		end

		if (player.registry["love_r_timer"] < os.time()) then
			if (player:hasItem("love_r_koh",1) == true) then
				if(playerpartner.spouse == player.id and (player.region ~= 5 or playerpartner.region ~= 5)) then
					player:deductDuraInv(player.invSlot, 1)
					--player.registry["love_r_timer"] = os.time() + 300
					player.registry["love_r_timer"] = os.time() + 10
					canAmbush(player, Player(player.spouse))
				else
					player:sendMinitext("This will not work now.")
				end
			end
		else
			local timeremaining = (math.floor(player.registry["love_r_timer"] - os.time()))
			local ftimeremaining = math.modf(timeremaining)
			player:sendMinitext("You must wait before using this item again. "..ftimeremaining.." seconds left.")
		end
	else
		player:sendMinitext("You are not bonded with anyone.")
	end
end
}