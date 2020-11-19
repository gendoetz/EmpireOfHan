player_combat = {
on_healed = function(player, healer)
	player.attacker = healer.ID
	player:sendHealth(healer.damage, healer.critChance)
end,

on_attacked = function(player, attacker)
	if (player:hasDuration("evade") and attacker.critChance == 0) then
		if (math.random(100000) <= 90000) then
			player:setDuration("evade", 0)
			return
		end
	end
	
	if (player:hasDuration("carnage_veil") or player:hasDuration("carnage_resil")) then
		attacker.damage = attacker.damage * .40
	end

	if (attacker.blType == BL_PC) then
		if (attacker.registry["dps_potion"] > 0) then
			attacker.dmgDealt = attacker.dmgDealt + attacker.damage
		end
	end
	
	if (player:hasDuration("intervene")) then
		local casterIDs = player:getCasterID("intervene")
		local interveneBlock = player:getBlock(casterIDs[1])
		
		if (interveneBlock ~= nil) then
			--attacker.damage = attacker.damage / 2
			interveneBlock.attacker = attacker.ID
			interveneBlock:sendHealth(attacker.damage, attacker.critChance)
			interveneBlock:sendStatus()
			return
		end
	end
	
	if (player:hasDuration("deflect")) then
		local damage = attacker.damage * .50
		
		attacker.damage = attacker.damage / 2
		attacker.attacker = player.ID
		attacker:sendHealth(damage, attacker.critChance)
		if (attacker.blType == BL_PC) then
			attacker:sendStatus()
		end
	end

	if (player:hasDuration("transmuting_bulwark")) then
		local bulwarkheal = attacker.damage
		attacker.damage = 0
		--player:addHealth(bulwarkheal)
		player:addHealthExtend(bulwarkheal, 0, 0, 0, 0, 0)
	end

	if (player:hasDuration("phoenix_feather_shield")) then
		attacker.damage = 0
	end

	--old HB
	--if (player:hasDuration("harden_body")) then
	--	attacker.damage = 0
	--	return
	--end

	if (player:hasDuration("harden_body")) then
		if (player.registry["magic_shielded"] > attacker.damage) then
				player.registry["magic_shielded"] = player.registry["magic_shielded"] - attacker.damage
				attacker.damage = 0
				return
		else
				attacker.damage = attacker.damage - player.registry["magic_shielded"]
				player.registry["magic_shielded"] = 0
		end
		attacker.damage = attacker.damage * .70
	end

	if (player:hasDuration("stoneskin")) then
		attacker.damage = 0
		return
	end

	if (player:hasDuration("recoil")) then
		player.registry["recoil_damagestored"] = player.registry["recoil_damagestored"] + (attacker.damage * .25)
	end

	if (player:hasDuration("recoil2")) then
		player.registry["recoil_damagestored"] = player.registry["recoil_damagestored"] + (attacker.damage * .50)
	end

	if (player:hasDuration("ice_shield")) then
		if (player.registry["magic_shielded"] > 0) then
			player:sendAnimation(99)
			if (player.registry["magic_shielded"] > attacker.damage) then
					player.registry["magic_shielded"] = player.registry["magic_shielded"] - attacker.damage
					attacker.damage = 0
					player:sendMinitext("Ice Shield: "..player.registry["magic_shielded"]..".")
			else
					attacker.damage = attacker.damage - player.registry["magic_shielded"]
					player.registry["magic_shielded"] = 0
					player:sendMinitext("Ice Shield: "..player.registry["magic_shielded"]..".")
			end
		end
	end
	--Original two lines below here
	--player.attacker = attacker.ID
	--player:sendHealth(attacker.damage, attacker.critChance)
	if (attacker:hasDuration("amplify")) then
		local damagemod = attacker.damage * .3
		attacker.damage = attacker.damage + damagemod
	end

	player.attacker = attacker.ID
	player:sendHealth(attacker.damage, attacker.critChance)
end
}