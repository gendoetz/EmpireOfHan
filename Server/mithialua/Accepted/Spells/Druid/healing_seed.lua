healing_seed = {
	cast=function(player,target)
		local aether = 60000

		if(player.magic<player.maxMagic/10) then
			player:sendMinitext("You do not have enough mana.")
			return
		end

		if (not player:canCast(1, 1, 0)) then
			return
		end

		if (player.class ~= 12) then
			player:sendMinitext("Your path is not capable of this magic.")
			player:removeSpell("healing_seed")
			player.registry["learned_healing_seed"] = 0
			return
		end

		if (player.pvp == 1) then
			player:sendMinitext("Your honor forbids this skill in combat of this manner.")
			return
		end

		if (target.state == 1) then
			player:sendMinitext("That cannot save them now.")
			return
		end

		if(target:hasDuration("healing_seed")) then
			player:sendMinitext("A Seed is already blooming on that target")
			return
		end

		--[[local spellaether = 0

		if(player.level>=25 and player.level <= 50) then
			spellaether = 3000
		end

		if(player.level>=50 and player.level <= 75) then
			spellaether = 2000
		end

		if(player.level>=75 and player.level <= 99) then
			spellaether = 1000
		end--]]
		if (target.blType == BL_MOB) then
		player:sendMinitext("You can't cast that on that target.")
		return
		elseif (target.blType == BL_PC) then

		target:sendAnimation(59)
		player:sendAction(6,35)
		player:playSound(70)
		player:sendMinitext("You cast Healing seed.")
		player:setAether("healing_seed", aether)
		target:setDuration("healing_seed",14000,player.ID)
		if(player.ID~=target.ID) then
			target:sendMinitext(player.name .." plants a Healing Seed on you.")
		end
		end

end,


while_cast = function(player, caster)
		if(player.state==1 or player.health==0) then
			return
		end
		--player:sendAnimation(321)
		--player:addHealth2(caster.maxMagic/50)
		player:addHealth2(caster.maxMagic/25)
		player:sendHealth(0, 0)
end,

uncast = function(player,caster)
		if(player.health>0) then
				player:sendAnimation(322)
				player:addHealth2(caster.maxMagic/5)
				player:playSound(67)
				player:sendHealth(0, 0)

		else
			player:sendMinitext("Your injuries are too deep to be healed this way")
		end
end,

requirements=function(player)
	local level = 50
	local items = {}
	local itemAmounts = {}
	local description = {"Healing seed places a heal-over-time on the target that blooms and culminates in a larger burst heal. To learn this spell you must sacrifice (1) Gold Acorn, (5) Tainted Antlers, and 100 gold coins."}
	return level, items, itemAmounts, description
end       
}

