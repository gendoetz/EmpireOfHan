host_sage = {
		cast=function(player,target)

			if(player.state == 1) then
				player:sendMinitext("Spirits can't do that.")
				return
			end

			if(player.region ~= 5) then
				player:sendMinitext("You cannot use that here.")
				return
			end

			local game_maps = {7001, 7002, 7003, 7005, 7006, 7010, 7011, 7013, 7050, 7051, 7100, 7101, 7102}
			local a
			a=player.question

			player:sendAction(6,22)
			
			for i = 1, #game_maps do
				player:broadcast(game_maps[i],"[Host "..player.name.."]: "..player.question)
			end
		end       
}



