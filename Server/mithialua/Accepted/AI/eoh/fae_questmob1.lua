fae_questmob1 = {
on_healed = function(mob, healer)
	--mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob,attacker)
	--mob.attacker = attacker.ID
	--mob:sendHealth(attacker.damage, attacker.critChance)
	--attacker.damage = 0
	fae_questmob1.move(mob, target)
end,
	
move = function(mob,target)
	local nearbyplayer = mob:getObjectsInSameMap(BL_PC)
	local range = 2
	
	--mob:talk(2,"zaptime: "..mob.registry["zapCastTime"].." wither aethers "..mob.registry["zapCastTime"] + aethers.." os time: "..os.time())

		if (#nearbyplayer > 0) then
			for i = 1, #nearbyplayer do
				if (distance(mob, nearbyplayer[i]) <= range) then
						if (nearbyplayer[i]:hasItem("dark_fae_cider", 1) == true or nearbyplayer[i]:hasItem("fae_herbs", 1) == true) then
							nearbyplayer[i]:removeItem("dark_fae_cider", 1)
							nearbyplayer[i]:removeItem("fae_herbs", 5)
							nearbyplayer[i]:sendAnimation(201, 0)
							mob:talk(0,"Kalbog Spirit: Tehehe I'll take that off your hands!")
						end
				end
			end
		end

		mob.side=math.random(0,3)
		mob:sendSide()
end,

attack=function(mob,target)
	fae_questmob1.move(mob, target)
	return
end,

after_death=function(mob, player)

end
}