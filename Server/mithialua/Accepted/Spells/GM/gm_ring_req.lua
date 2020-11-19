ring_req = {
cast = function(player)
	
	player:freeAsync()
	ring_req.popup(player)

end,

popup = async(function(player)
	local t = {graphic = convertGraphic(1201, "monster"), color = 2}
	local menuOptions = {}
	
	table.insert(menuOptions, "Set Level Req")
	table.insert(menuOptions, "Set HP/MP Req")
	table.insert(menuOptions, "")
	table.insert(menuOptions, "Repeat Last MP/HP Values")


	player.npcGraphic = t.graphic
	player.npcColor = t.color
	player.dialogType = 0
	
		local choice = player:menuString("Which option?", menuOptions)
		if(choice == "Set Level Req") then
			local bondedRing_levelReq = tonumber(player:input("What level is required for this cave?"))
			player.mapRegistry["bondedRing_levelReq"] = bondedRing_levelReq
			player:sendMinitext("Level Requirement registered for map #"..player.m.." as: "..bondedRing_levelReq)
			player.registry["rs_levelReq_lv"] = bondedRing_levelReq
		elseif(choice == "Set HP/MP Req") then
			local bondedRing_vitaReq = tonumber(player:input("What vita is required for this cave?"))
			player.mapRegistry["bondedRing_vitaReq"] = bondedRing_vitaReq
			player:sendMinitext("Vita Requirement registered for map #"..player.m.." as: "..bondedRing_vitaReq)
			player.registry["rs_levelReq_hp"] = bondedRing_vitaReq

			local bondedRing_manaReq = tonumber(player:input("What mana is required for this cave?"))
			player.mapRegistry["bondedRing_manaReq"] = bondedRing_manaReq
			player:sendMinitext("Mana Requirement registered for map #"..player.m.." as: "..bondedRing_manaReq)
			player.registry["rs_levelReq_mp"] = bondedRing_manaReq
		elseif(choice == "Repeat Last MP/HP Values") then
			
			player.mapRegistry["bondedRing_vitaReq"] = player.registry["rs_levelReq_hp"]
			player:sendMinitext("Vita Requirement registered for map #"..player.m.." as: "..player.mapRegistry["bondedRing_vitaReq"])
			
			player.mapRegistry["bondedRing_manaReq"] = player.registry["rs_levelReq_mp"]
			player:sendMinitext("Mana Requirement registered for map #"..player.m.." as: "..player.mapRegistry["bondedRing_manaReq"])
			
		end
end),

requirements = function(player)
	local level = 1
	local items = {}
	local itemAmounts = {}
	local description = {"A spell that sets the ringing requirements for a map. Level 1-99, put 0 if no level requirement. Health/Mana put 0 if this is below a stat cave and is 1-99."}
	return level, items, itemAmounts, description
end
}