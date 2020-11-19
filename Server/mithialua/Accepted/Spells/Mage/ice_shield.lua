ice_shield = {
cast=function(player, target)

	if (player.state==1) then
		player:sendMinitext("Spirits can't do that.")
		return
	end
	
	if (player.state==3) then
		player:sendMinitext("You cannot cast this spell on a mount.")
		return
	end
	
	if (player:hasDuration("ice_shield")) then
		player:sendMinitext("That spell is already cast.")
		return
	end

	--if (player:hasDuration("magic_shield")) then
		--player:flushDuration(303)
		--return
	--end	

	local shield = ((player.maxMagic  / 2) * .02) * (player.will / 3)

		local enspellCheck = player:magicDamageMod_enspell(shield)

		shield = enspellCheck
	--local mana_cost = math.floor(50 + (mMana * 0.05) + (3.5 * will/5))
	local dura = 50000
	local aether = 65000
		
	player:sendAction(6,35)
	player:playSound(71)
	player:setAether("ice_shield",aether)
	player:setDuration("ice_shield",dura)
	--if (player.dmgShield < (player.maxHealth * 0.75)) then
	--	player.dmgShield = math.floor(player.dmgShield + (will / 5))
	--end
	player.registry["magic_shielded"] = shield
	player:sendMinitext("You enabled ice shield.")
	player:sendAnimation(99)--56 66 90 98 110 251 295 323
end,

uncast = function(block,caster)
	block.registry["magic_shielded"] = 0
	--local ds = player.dmgShield
	--player.dmgShield = ds - math.floor(ds * 0.1)
	--player:setAether("ice_shield",2000)
	--player:sendMinitext("Your ice shield is at: "..math.floor(player.dmgShield))
	--player:sendAnimation(323,-1)
end,

while_cast = function(block,caster)
	local magicCost = block.maxMagic * .01
	if (block.registry["magic_shielded"] == 0 or block.magic <= magicCost) then
		block:setDuration("ice_shield", 0)
		return
	end
	
	block.magic = block.magic - magicCost
	--player:talk(2,""..player.registry["magic_shielded"].." "..mana_cost)
end,

--passive_on_takingdamage = function(player,caster)
--player:sendAnimation(99)
--end,


on_aethers = function(player)
	--player:sendMinitext("Ice Shield: "..player.dmgShield)
end,

requirements = function(player)
	local level = 40
	local items = {}
	local itemAmounts = {}
	local description = {"Shields your body from damage but slowly drains your mana."}
	return level, items, itemAmounts, description
end
}
