ambush = {
cast = function(player)
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local npcTarget = getTargetFacing(player, BL_NPC)
	local weapon = player:getEquippedItem(EQ_WEAP)

	local milios = player.registry["ambushTimer"]
	local ambushTimer = (player.attackSpeed * 1000) / 120
	player.registry["cur_ostime"] = ((os.time() * 1000) + timeMS())

	--if not (ambushTimer + milios < player.registry["cur_ostime"]) then
	--	return
	--end
	
	if (not player:canCast(1, 1, 0)) then
		return
	end
	
	if (weapon ~= nil and weapon.yname == "fishing_pole") then
		player:sendMinitext("You would get entangled with the line.")
		return
	end

		if (mobTarget ~= nil) then
			if (mobTarget.mobID == 100 or mobTarget.mobID == 64 or mobTarget.mobID == 81) then
				player:sendMinitext("You attempt to ambush and look like a fool.")
			return
			end
		end


		if (mobTarget ~= nil) then
			if (mobTarget.mobID >= 10000 and mobTarget.mobID <= 10015) then
				player:sendMinitext("You attempt to ambush and look like a fool.")
			return
			end
		end
	
	if (mobTarget ~= nil) then
		--player.attackSpeed = 20
		if (ambushTimer + milios < player.registry["cur_ostime"] and canAmbush(player, mobTarget)) then

			player.registry["ambushTimer"] = ((os.time() * 1000) + timeMS())
			player:swing()
		end
	elseif (pcTarget ~= nil) then

		--player.attackSpeed = 20
		if (ambushTimer + milios < player.registry["cur_ostime"] and canAmbush(player, pcTarget)) then

			--local atimer = (player.attackSpeed * 1000) / 50
			player.registry["ambushTimer"] = ((os.time() * 1000) + timeMS())
			player:swing()
		end
	elseif (npcTarget ~= nil and canAmbush(player, npcTarget)) then

		--player.attackSpeed = 20
		if (ambushTimer + milios < player.registry["cur_ostime"] and canAmbush(player, npcTarget)) then

			--local atimer = (player.attackSpeed * 1000) / 50
			player.registry["ambushTimer"] = ((os.time() * 1000) + timeMS())
			player:swing()
		end
	end

	--player:talk(0,"Cur Timer: "..player.registry["cur_ostime"])
	--player:talk(0,"Attack Timer: "..ambushTimer + milios)
	player.registry["ambushTimer"] = ((os.time() * 1000) + timeMS())
end,

requirements = function(player)
	local level = 25
	local items = {}
	local itemAmounts = {}
	local description = {"Ambush allows you to leap over a nearby monster or person and do damage in the process."}
	return level, items, itemAmounts, description
end
}