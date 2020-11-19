elixir_bow2 = {
thrown = function(player, target)

	if (player.m <= 7049 or player.m >= 7071) then
		player:sendMinitext("This bow does not work here.")
		return
	end

	local multiTargetDamageMod = 20 --player.damage = player.damage * ((mod - x + 1) / mod) x = targetNumber
	local arrow = 6 --icon for the projectile
	local bowRange = player.mapRegistry["bowrange"]
	local maxTargets = 1 --max targets to acquire and hit, will not exceed bowRange
	local pcList = {} --list of players, only the first is taken
	local targetList = {} --final target list
	local pass = 1 --boolean passcheck
	local i = 0 --counter
	--no ammo
	
	player:playSound(338)
	--cannot shoot
		if(player.registry["elixirarrowsleft"]<=0) then
			player:sendMinitext("You are out of arrows.")
			player:sendAction(1,30)
			return
		end

		if(player.armorColor==7020) then
			player:sendMinitext("You can not shoot arrows when you're hosting.")
			return
		end
	
	--1 and 2 for PK
	repeat
		i = i + 1
		
		if (player.side == 0) then
			pass = getPass(player.m, player.x, player.y - i)
				pcList = player:getObjectsInCell(player.m, player.x, player.y - i, BL_PC)
		elseif (player.side == 1) then
			pass = getPass(player.m, player.x + i, player.y)
				pcList = player:getObjectsInCell(player.m, player.x + i, player.y, BL_PC)
		elseif (player.side == 2) then
			pass = getPass(player.m, player.x, player.y + i)
				pcList = player:getObjectsInCell(player.m, player.x, player.y + i, BL_PC)
		elseif (player.side == 3) then
			pass = getPass(player.m, player.x - i, player.y)
				pcList = player:getObjectsInCell(player.m, player.x - i, player.y, BL_PC)
		end
	until (#pcList > 0 or i > bowRange or pass == 1)
	
	local numTargets = bowRange - i + 1
	
	if (numTargets > maxTargets) then
		numTargets = maxTargets
	end
	
	if (numTargets <= 0) then
		if (player.side == 0) then
			player:throw(player.x, player.y - bowRange, 6, 0, 1)
		elseif (player.side == 1) then
			player:throw(player.x + bowRange, player.y, 7, 0, 1)
		elseif (player.side == 2) then
			player:throw(player.x, player.y + bowRange, 8, 0, 1)
		elseif (player.side == 3) then
			player:throw(player.x - bowRange, player.y, 9, 0, 1)
		end
		
		player:sendMinitext("You did not hit anything.")
		return
	else
		if (#pcList > 0) then
			table.insert(targetList, pcList[1])
			
			for x = 1, numTargets - 1 do
				if (player.side == 0) then
					pcList = player:getObjectsInCell(player.m, targetList[1].x, targetList[1].y - x, BL_PC)
					
					if (#pcList > 0) then
						table.insert(targetList, pcList[1])
					else
						table.insert(targetList, nil)
					end
				elseif (player.side == 1) then
					pcList = player:getObjectsInCell(player.m, targetList[1].x + x, targetList[1].y, BL_PC)
					
					if (#pcList > 0) then
						table.insert(targetList, pcList[1])
					else
						table.insert(targetList, nil)
					end
				elseif (player.side == 2) then
					pcList = player:getObjectsInCell(player.m, targetList[1].x, targetList[1].y + x, BL_PC)
					
					if (#pcList > 0) then
						table.insert(targetList, pcList[1])
					else
						table.insert(targetList, nil)
					end
				elseif (player.side == 3) then
					pcList = player:getObjectsInCell(player.m, targetList[1].x - x, targetList[1].y, BL_PC)
					
					if (#pcList > 0) then
						table.insert(targetList, pcList[1])
					else
						table.insert(targetList, nil)
					end
				end
			end
		end
	end
	
	if (#targetList > 0) then
		for x = 1, #targetList do
			if (targetList[x] ~= nil) then
				if(player.mapRegistry["bowrate"]<math.random(1,100)) then
					player:sendMinitext("You missed!")
					player.registry["elixirarrowsleft"]=player.registry["elixirarrowsleft"]-1
					player:sendMinitext("You have "..player.registry["elixirarrowsleft"].." arrows left.")
					return
				end
				if(targetList[x].armorColor~=7020) then
					if(player.registry["elixircolor"]==63) then
						if(targetList[x].registry["elixircolor"]==65) then
							if(targetList[x].armorColor~=21) then
								targetList[x].registry["elixirkiller"]=player.ID
							end
							targetList[x].armorColor=21
							targetList[x].gfxDye = 21
							player:playSound(352)
						elseif(targetList[x].registry["elixircolor"]==63) then
							targetList[x].armorColor=63
							targetList[x].gfxDye = 63
							player:playSound(352)
						end
					elseif(player.registry["elixircolor"]==65) then
						if(targetList[x].registry["elixircolor"]==65) then
							targetList[x].armorColor=65
							targetList[x].gfxDye = 65
							player:playSound(352)
						elseif(targetList[x].registry["elixircolor"]==63) then
							if(targetList[x].armorColor~=19) then
								targetList[x].registry["elixirkiller"]=player.ID
							end
							targetList[x].armorColor=19
							targetList[x].gfxDye = 19
							player:playSound(352)
						end
					end
					targetList[x].registry["elixirx"]=targetList[x].x
					targetList[x].registry["elixiry"]=targetList[x].y
					targetList[x]:sendStatus()
					targetList[x]:refresh()

					player.registry["elixirarrowsleft"]=player.registry["elixirarrowsleft"]-1
					player:sendMinitext("You have "..player.registry["elixirarrowsleft"].." arrows left.")
				end
			end
		end
		
		player:throw(targetList[#targetList].x, targetList[#targetList].y, arrow + player.side, 0, 1)
		--player:playSound(712)
	else
		if (i ~= 1) then
			if (player.side == 0) then
				player:throw(player.x, player.y - i + 1, 6, 0, 1)
			elseif (player.side == 1) then
				player:throw(player.x + i - 1, player.y, 7, 0, 1)
			elseif (player.side == 2) then
				player:throw(player.x, player.y + i - 1, 8, 0, 1)
			elseif (player.side == 3) then
				player:throw(player.x - i + 1, player.y, 9, 0, 1)
			end
			
			player:sendMinitext("You did not hit anything.")
		else
			player:sendMinitext("You cannot shoot so close to a wall.")
		end
	end
end,

on_hit = function(player, target)

end
}