gm_make_warpList = {
cast = function(player)
	
	player:freeAsync()
	gm_make_warpList.popup(player)

end,

popup = async(function(player)
	local t = {graphic = convertGraphic(1201, "monster"), color = 0}
	local menuOptions = {}


	if (NPC(130).registry["lockedByPlayer"] ~= 0) then
		if (NPC(130).registry["lockedByPlayer"] ~= player.id) then
			player:dialogSeq({t, "You cannot use this function at the moment, currently "..Player(NPC(130).registry["lockedByPlayer"]).name.." has it in use."}, 1)
			return
		end
	end
	
	table.insert(menuOptions, "Map 1 Start") -- Map recording 1
	table.insert(menuOptions, "Map 2 Start") -- Map recording 2
	table.insert(menuOptions, "Compile List") -- Finish 3
	table.insert(menuOptions, "Clear Variables") -- Finish 3
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0


		local choice = player:menuString("Which option?", menuOptions)

		if(choice == "Map 1 Start") then
			NPC(130).registry["lockedByPlayer"] = player.id
				NPC(130).registry["map_recording"] = 1
				NPC(130).registry["mapStart_number"] = player.m
			local direction = player:menuString("Where are you beginning on the map?", {"Top", "Right", "Bottom", "Left"})

			if (direction == "Top") then
				NPC(130).registry["map_begin_direction"] = 1
			elseif (direction == "Right") then
				NPC(130).registry["map_begin_direction"] = 2
			elseif (direction == "Bottom") then
				NPC(130).registry["map_begin_direction"] = 3
			elseif (direction == "Left") then
				NPC(130).registry["map_begin_direction"] = 4
			end
			
		elseif(choice == "Map 2 Start") then
			NPC(130).registry["map_recording"] = 2
			NPC(130).registry["mapEnd_number"] = player.m
		elseif(choice == "Compile List") then
			local mapStartx_table = {}
			local mapStarty_table = {}
			local mapEndx_table = {}
			local mapEndy_table = {}
			local regname
			local Line_StartWarps = ""
			local Line_EndWarps = ""
			local warp_line = ""

			local counter = NPC(130).registry["CoordCounterMap1"]

			for x=1, counter do
				regname="xStart" ..x
				table.insert(mapStartx_table,NPC(130).registry[regname])
				regname="yStart" ..x
				table.insert(mapStarty_table,NPC(130).registry[regname])

				regname="xEnd" ..x
				table.insert(mapEndx_table,NPC(130).registry[regname])
				regname="yEnd" ..x
				table.insert(mapEndy_table,NPC(130).registry[regname])
			end


			for i=1, counter do
				if(mapStartx_table[i] == 9999) then
					mapStartx_table[i] = 0
				end
				if(mapStarty_table[i] == 9999) then
					mapStarty_table[i] = 0
				end
				if(mapEndx_table[i] == 9999) then
					mapEndx_table[i] = 0
				end
				if(mapEndy_table[i] == 9999) then
					mapEndy_table[i] = 0
				end

				if(i == 1) then
					NPC(130):warp(NPC(130).registry["mapStart_number"], 0, 0)
					warp_line = warp_line.."// "..NPC(130).mapTitle.." Map 1 Start\r"
				end

				Line_StartWarps = ""..NPC(130).registry["mapStart_number"]..", "..mapStartx_table[i]..", "..mapStarty_table[i]..", "
				Line_EndWarps = ""..NPC(130).registry["mapEnd_number"]..", "..mapEndx_table[i]..", "..mapEndy_table[i].."\r"

				warp_line = warp_line..""..Line_StartWarps..""..Line_EndWarps..""
			end


					NPC(130):warp(NPC(130).registry["mapEnd_number"], 0, 0)
					warp_line = warp_line.."// "..NPC(130).mapTitle.." Map 2 Start\r"
				

			if(NPC(130).registry["map_begin_direction"] == 1) then
				for i=1, counter do
					if(mapStartx_table[i] == 9999) then
						mapStartx_table[i] = 0
					end
					if(mapStarty_table[i] == 9999) then
						mapStarty_table[i] = 0
					end
					if(mapEndx_table[i] == 9999) then
						mapEndx_table[i] = 0
					end
					if(mapEndy_table[i] == 9999) then
						mapEndy_table[i] = 0
					end

					mapEndy_table[i] = mapEndy_table[i] + 1
					mapStarty_table[i] = mapStarty_table[i] + 1

					Line_StartWarps = ""..NPC(130).registry["mapEnd_number"]..", "..mapEndx_table[i]..", "..mapEndy_table[i]..", "
					Line_EndWarps = ""..NPC(130).registry["mapStart_number"]..", "..mapStartx_table[i]..", "..mapStarty_table[i].."\r"

					warp_line = warp_line..""..Line_StartWarps..""..Line_EndWarps..""
				end
			end

			if(NPC(130).registry["map_begin_direction"] == 3) then
				for i=1, counter do
					if(mapStartx_table[i] == 9999) then
						mapStartx_table[i] = 0
					end
					if(mapStarty_table[i] == 9999) then
						mapStarty_table[i] = 0
					end
					if(mapEndx_table[i] == 9999) then
						mapEndx_table[i] = 0
					end
					if(mapEndy_table[i] == 9999) then
						mapEndy_table[i] = 0
					end

					mapEndy_table[i] = mapEndy_table[i] - 1
					mapStarty_table[i] = mapStarty_table[i] - 1

					Line_StartWarps = ""..NPC(130).registry["mapEnd_number"]..", "..mapEndx_table[i]..", "..mapEndy_table[i]..", "
					Line_EndWarps = ""..NPC(130).registry["mapStart_number"]..", "..mapStartx_table[i]..", "..mapStarty_table[i].."\r"

					warp_line = warp_line..""..Line_StartWarps..""..Line_EndWarps..""
				end
			end

			if(NPC(130).registry["map_begin_direction"] == 2) then
				for i=1, counter do
					if(mapStartx_table[i] == 9999) then
						mapStartx_table[i] = 0
					end
					if(mapStarty_table[i] == 9999) then
						mapStarty_table[i] = 0
					end
					if(mapEndx_table[i] == 9999) then
						mapEndx_table[i] = 0
					end
					if(mapEndy_table[i] == 9999) then
						mapEndy_table[i] = 0
					end

					mapEndx_table[i] = mapEndx_table[i] - 1
					mapStartx_table[i] = mapStartx_table[i] - 1

					Line_StartWarps = ""..NPC(130).registry["mapEnd_number"]..", "..mapEndx_table[i]..", "..mapEndy_table[i]..", "
					Line_EndWarps = ""..NPC(130).registry["mapStart_number"]..", "..mapStartx_table[i]..", "..mapStarty_table[i].."\r"

					warp_line = warp_line..""..Line_StartWarps..""..Line_EndWarps..""
				end
			end

			if(NPC(130).registry["map_begin_direction"] == 4) then
				for i=1, counter do
					if(mapStartx_table[i] == 9999) then
						mapStartx_table[i] = 0
					end
					if(mapStarty_table[i] == 9999) then
						mapStarty_table[i] = 0
					end
					if(mapEndx_table[i] == 9999) then
						mapEndx_table[i] = 0
					end
					if(mapEndy_table[i] == 9999) then
						mapEndy_table[i] = 0
					end

					mapEndx_table[i] = mapEndx_table[i] + 1
					mapStartx_table[i] = mapStartx_table[i] + 1

					Line_StartWarps = ""..NPC(130).registry["mapEnd_number"]..", "..mapEndx_table[i]..", "..mapEndy_table[i]..", "
					Line_EndWarps = ""..NPC(130).registry["mapStart_number"]..", "..mapStartx_table[i]..", "..mapStarty_table[i].."\r"

					warp_line = warp_line..""..Line_StartWarps..""..Line_EndWarps..""
				end
			end

			player:sendMail(""..player.name.."", "Map Warp File", ""..warp_line.."")

			--kill all npc variables
			local counter = NPC(130).registry["CoordCounterMap1"]
			for x=1, counter do
				regname="xStart" ..x
				NPC(130).registry[regname] = 0
				regname="yStart" ..x
				NPC(130).registry[regname] = 0
				regname="xEnd" ..x
				NPC(130).registry[regname] = 0
				regname="yEnd" ..x
				NPC(130).registry[regname] = 0
			end
			NPC(130).registry["CoordCounterMap1"] = 0
			NPC(130).registry["CoordCounterMap2"] = 0
			NPC(130).registry["map_recording"] = 0
			NPC(130).registry["lockedByPlayer"] = 0

		elseif(choice == "Clear Variables") then
			NPC(130).registry["CoordCounterMap1"] = 0
			NPC(130).registry["CoordCounterMap2"] = 0
			NPC(130).registry["map_recording"] = 0
			NPC(130).registry["lockedByPlayer"] = 0
		end
end),
}

gm_map_recordXY = {
cast = function(player)
	local xyCounter1
	local xyCounter2

	if(NPC(130).registry["map_recording"] == 1) then
		xyCounter1 = NPC(130).registry["CoordCounterMap1"] + 1

		NPC(130).registry["xStart"..xyCounter1] = player.x
		NPC(130).registry["yStart"..xyCounter1] = player.y

		if (player.x == 0) then
			NPC(130).registry["xStart"..xyCounter1] = 9999
		end
		if (player.y == 0) then
			NPC(130).registry["yStart"..xyCounter1] = 9999
		end

		NPC(130).registry["CoordCounterMap1"] = NPC(130).registry["CoordCounterMap1"] + 1
	end

	if(NPC(130).registry["map_recording"] == 2) then
		xyCounter2 = NPC(130).registry["CoordCounterMap2"] + 1

		NPC(130).registry["xEnd"..xyCounter2] = player.x
		NPC(130).registry["yEnd"..xyCounter2] = player.y

		if (player.x == 0) then
			NPC(130).registry["xEnd"..xyCounter2] = 9999
		end
		if (player.y == 0) then
			NPC(130).registry["yEnd"..xyCounter2] = 9999
		end

		NPC(130).registry["CoordCounterMap2"] = NPC(130).registry["CoordCounterMap2"] + 1
	end

	player:sendAction(6, 20)
	player:playSound(708)

end,
}

map_maker_npc = {
click = async(function(player, npc)
	local t = {graphic = convertGraphic(1201, "monster"), color = 0}
	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0

	player:dialogSeq({t, "Test"}, 1)
end),
}