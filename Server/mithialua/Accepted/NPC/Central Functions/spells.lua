function Player.learnSpell(player, t)
	--local t = {graphic = convertGraphic(16, "monster"), color = 9}
	local found
	local spellNames = player:getUnknownSpells()
	local spellName = {}
	local spellYName = {}

	local spellName_T = {}
	local spellYName_T = {}

	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}

	local spellIDs = player:getSpells()

	if (#spellIDs >= 52) then
		player:dialog("You may not learn any more spells, please forget a spell first.", {})
		return false
	end
	
	--player.npcGraphic = 0
	--player.npcColor = 0


	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	--Test sort
	for i = 1, #spellYName do
		local level = 1
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)
		
		if (func ~= nil) then
			level = func(player)
		end
		
		table.insert(spellLevelReq, level)
	end
	
	if (#spellLevelReq > 0) then
		local i = 1
		local level
		local name
		local yname
		
		repeat
			if (i <= #spellLevelReq and (spellLevelReq[i] > player.level or (spellLevelReq[i] ~= nil))) then
				level = table.remove(spellLevelReq, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)
				
				if (level <= player.level) then
					table.insert(spellName_T, 1, name)
					table.insert(spellYName_T, 1, yname)
				end
				
				i = 1
			else
				i = i + 1
			end
		until i > #spellLevelReq
	end

--end test
	
	local c = player:menuString("What would you like to learn?", spellName_T)
	if(c ~= "" ) then
		for x = 1, #spellName_T do
			if(c == spellName_T[x]) then
				local level = 1
				local items = {0}
				local amounts = {100}
				local desc = "A spell"
				local func = assert(loadstring("return "..spellYName_T[x]..".requirements"))(player)
				
				if (func ~= nil) then
					level, items, amounts, desc = func(player)
				end
				
				--table.insert(spellLevelReq, level)
				--table.insert(spellItemReq, items)
				--table.insert(spellItemAmount, amounts)
				--table.insert(spellDesc, desc)
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				--player:dialog("Hi there! Do you think you could do me a favor hunny?", {})
				player:dialogSeq({t, ""..desc[1]..""}, 1)
				--if(not player:dialogSeq(desc, 1)) then
				
				--	return false
				--end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				if (player.level < level) then
						player:dialog("You are not strong enough. Level "..level.. " is required to learn "..spellName_T[x]..".", {})
						return false
				end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				local c = player:menuString("Do you swear to use this for good?", {"Yes", "No"})
				if (c == "Yes" or c == "Yes *evil grin*") then
					
					if (#amounts > 0) then
						if (player:checkItems(items, amounts)) then
							player:removeItems(items, amounts)
						else
							player:dialog("You do not have the required items.", {})
							return false
						end
					end
					
					player.registry["learned_"..spellYName_T[x]] = 1
					player:addSpell(spellYName_T[x])
					player:sendMinitext("Your mind expands as you learn "..spellName_T[x])
					
					if (c == "Yes *evil grin*") then
						player:dialog("I've got my eye on you...",{})
					end
					
				elseif (c == "No") then
					return false
				end
			end
		end	
	end
		
	--if(found > 0) then
		--player:dialogSeq({t, spellDesc[found]}, 1)
		
	--end
end

function Player.learnSpell_base(player, t)
	--local t = {graphic = convertGraphic(16, "monster"), color = 9}
	local found
	local spellNames = player:getUnknownSpells_base()
	local spellName = {}
	local spellYName = {}

	local spellName_T = {}
	local spellYName_T = {}

	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}

	local spellIDs = player:getSpells()

	if (#spellIDs >= 52) then
		player:dialog("You may not learn any more spells, please forget a spell first.", {})
		return false
	end
	
	--player.npcGraphic = 0
	--player.npcColor = 0
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	--Test sort
	for i = 1, #spellYName do
		local level = 1
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)
		
		if (func ~= nil) then
			level = func(player)
		end
		
		table.insert(spellLevelReq, level)
	end
	
	if (#spellLevelReq > 0) then
		local i = 1
		local level
		local name
		local yname
		
		repeat
			if (i <= #spellLevelReq and (spellLevelReq[i] > player.level or (spellLevelReq[i] ~= nil))) then
				level = table.remove(spellLevelReq, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)
				
				if (level <= player.level) then
					table.insert(spellName_T, 1, name)
					table.insert(spellYName_T, 1, yname)
				end
				
				i = 1
			else
				i = i + 1
			end
		until i > #spellLevelReq
	end

--end test
	
	local c = player:menuString("What would you like to learn?", spellName_T)
	if(c ~= "" ) then
		for x = 1, #spellName_T do
			if(c == spellName_T[x]) then
				local level = 1
				local items = {0}
				local amounts = {100}
				local desc = "A spell"
				local func = assert(loadstring("return "..spellYName_T[x]..".requirements"))(player)
				
				if (func ~= nil) then
					level, items, amounts, desc = func(player)
				end
				
				--table.insert(spellLevelReq, level)
				--table.insert(spellItemReq, items)
				--table.insert(spellItemAmount, amounts)
				--table.insert(spellDesc, desc)
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				--player:dialog("Hi there! Do you think you could do me a favor hunny?", {})
				player:dialogSeq({t, ""..desc[1]..""}, 1)
				--if(not player:dialogSeq(desc, 1)) then
				
				--	return false
				--end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				if (player.level < level) then
						player:dialog("You are not strong enough. Level "..level.. " is required to learn "..spellName_T[x]..".", {})
						return false
				end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				local c = player:menuString("Do you swear to use this for good?", {"Yes", "No"})
				if (c == "Yes" or c == "Yes *evil grin*") then
					
					if (#amounts > 0) then
						if (player:checkItems(items, amounts)) then
							player:removeItems(items, amounts)
						else
							player:dialog("You do not have the required items.", {})
							return false
						end
					end
					
					player.registry["learned_"..spellYName_T[x]] = 1
					player:addSpell(spellYName_T[x])
					player:sendMinitext("Your mind expands as you learn "..spellName_T[x])
					
					if (c == "Yes *evil grin*") then
						player:dialog("I've got my eye on you...",{})
					end
					
				elseif (c == "No") then
					return false
				end
			end
		end	
	end
		
	--if(found > 0) then
		--player:dialogSeq({t, spellDesc[found]}, 1)
		
	--end
end

function Player.learnSpell_sub(player, t)
	--local t = {graphic = convertGraphic(16, "monster"), color = 9}
	local found
	local spellNames = player:getUnknownSpells_sub()
	local spellName = {}
	local spellYName = {}

	local spellName_T = {}
	local spellYName_T = {}

	local spellFuncs = {}
	local spellItemReq = {}
	local spellItemAmount={}
	local spellLevelReq = {}
	local spellDesc = {}

	local spellIDs = player:getSpells()

	if (#spellIDs >= 52) then
		player:dialog("You may not learn any more spells, please forget a spell first.", {})
		return false
	end
	
	--player.npcGraphic = 0
	--player.npcColor = 0
	
	for i = 1, #spellNames do
		if (i % 2 == 0 and player.registry["learned_"..spellNames[i]] == 0) then
			table.insert(spellYName, spellNames[i])
		elseif (i % 2 == 1 and player.registry["learned_"..spellNames[i + 1]] == 0) then
			table.insert(spellName, spellNames[i])
		end
	end
	--Test sort
	for i = 1, #spellYName do
		local level = 1
		local func = assert(loadstring("return "..spellYName[i]..".requirements"))(player)
		
		if (func ~= nil) then
			level = func(player)
		end
		
		table.insert(spellLevelReq, level)
	end
	
	if (#spellLevelReq > 0) then
		local i = 1
		local level
		local name
		local yname
		
		repeat
			if (i <= #spellLevelReq and (spellLevelReq[i] > player.level or (spellLevelReq[i] ~= nil))) then
				level = table.remove(spellLevelReq, i)
				name = table.remove(spellName, i)
				yname = table.remove(spellYName, i)
				
				if (level <= player.level) then
					table.insert(spellName_T, 1, name)
					table.insert(spellYName_T, 1, yname)
				end
				
				i = 1
			else
				i = i + 1
			end
		until i > #spellLevelReq
	end

--end test
	
	local c = player:menuString("What would you like to learn?", spellName_T)
	if(c ~= "" ) then
		for x = 1, #spellName_T do
			if(c == spellName_T[x]) then
				local level = 1
				local items = {0}
				local amounts = {100}
				local desc = "A spell"
				local func = assert(loadstring("return "..spellYName_T[x]..".requirements"))(player)
				
				if (func ~= nil) then
					level, items, amounts, desc = func(player)
				end
				
				--table.insert(spellLevelReq, level)
				--table.insert(spellItemReq, items)
				--table.insert(spellItemAmount, amounts)
				--table.insert(spellDesc, desc)
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				--player:dialog("Hi there! Do you think you could do me a favor hunny?", {})
				player:dialogSeq({t, ""..desc[1]..""}, 1)
				--if(not player:dialogSeq(desc, 1)) then
				
				--	return false
				--end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				if (player.level < level) then
						player:dialog("You are not strong enough. Level "..level.. " is required to learn "..spellName_T[x]..".", {})
						return false
				end
				player.npcGraphic = t.graphic
				player.npcColor = t.color
				local c = player:menuString("Do you swear to use this for good?", {"Yes", "No"})
				if (c == "Yes" or c == "Yes *evil grin*") then
					
					if (#amounts > 0) then
						if (player:checkItems(items, amounts)) then
							player:removeItems(items, amounts)
						else
							player:dialog("You do not have the required items.", {})
							return false
						end
					end
					
					player.registry["learned_"..spellYName_T[x]] = 1
					player:addSpell(spellYName_T[x])
					player:sendMinitext("Your mind expands as you learn "..spellName_T[x])
					
					if (c == "Yes *evil grin*") then
						player:dialog("I've got my eye on you...",{})
					end
					
				elseif (c == "No") then
					return false
				end
			end
		end	
	end
		
	--if(found > 0) then
		--player:dialogSeq({t, spellDesc[found]}, 1)
		
	--end
end

function Player.forgetSpell(player)
	local t = {graphic = player.npcGraphic, color = player.npcColor}
	--player.npcGraphic = t.graphic
	--player.npcColor = t.color
	
	local spellNames = player:getSpellName()
	local spellYNames = player:getSpellYName()
	local spellIDs = player:getSpells()
	local placeholder
	local found
	local selection

	selection = player:menuString("What would you like to forget?", spellNames)
	if(selection ~= "" ) then
		for x = 1, #spellNames do
			if(spellNames[x] == selection) then
				found = x
				break
			end
		end	
	end
	selection = player:menuString("Are you sure you wish to forget "..spellNames[found].."?", {"Yes", "No"})
	if(selection == "Yes") then
		player.registry["learned_"..spellYNames[found]] = 0
		player:removeSpell(spellIDs[found])
	end
end

function Player.checkItems(player, items, amounts)
	for x = 1, #items do
		if (items[x] == 0) then
			if (player.money < amounts[x]) then
			    return false
			end
		else
			if (player:hasItem(items[x], amounts[x]) == true) then
			else
				return false
			end
		end
	end
	
	return true
end

function Player.removeItems(player, items, amounts)
	for x = 1, #items do
		if (items[x] == 0) then
			player.money = player.money - amounts[x]
			player:sendStatus()
		else
			player:removeItem(items[x], amounts[x])
		end
	end
end


function Player.canLearnSpell(player, str)
	if (type(str) ~= "string") then
		return false
	end
	local spells = player:getSpells()
	if (#spells < 52) then
		if (player:hasSpell(""..str)) then
			return false
		end
		return true
	else
		return false
	end
end