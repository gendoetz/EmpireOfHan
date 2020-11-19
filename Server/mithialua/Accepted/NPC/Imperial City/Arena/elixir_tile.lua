elixir_tile = {
	click=function(player,npc)
		if(player.armorColor~=63 and player.armorColor~=65) then
				player:sendMinitext("You are not properly dyed to fight!")
				player:warp(7006,14,27)
				return
		end

		if(NPC(84).registry["arena"] == 0) then
			player:sendMinitext("Your host must set an arena.")
			player:warp(7006,14,27)
			return
		end
		
		--if(player.mapRegistry["elixirwararena"]==0) then
		--		player:sendMinitext("The Arena has not been set.")
		--		player:warp(2100,24,24)
		--		return
		--end

		
		--if(player.mapRegistry["elixirwararena"]==1) then
			if(player.armorColor==63) then
				player.registry["elixircolor"]=63
				player:warp(NPC(84).registry["arena"],math.random(3,29),math.random(1,3))
				carnage_veil.cast(player)
			elseif(player.armorColor==65) then
				player.registry["elixircolor"]=65
				player:warp(NPC(84).registry["arena"],math.random(3,29),math.random(37,39))
				carnage_veil.cast(player)
			end
		--end
	end
}