rep_gladiatormob = {
after_death = function(mob, block) --mob died
	Player(mob.attacker):removeItem("rep_gladiator", 1)
	Player(mob.attacker):addItem("rep_gladiator2", 1)
end,

on_spawn = function(mob)
	mob.registry["mob_life_timer"] = os.time()
	mob.registry["hitability"] = 1
	mob:talk(0, "Are you ready to take the plunge?          (( Say 'Yes' or 'No' ))")
end,

say = function(player, mob)
	local speech = player.speech
	local lspeech = string.lower(speech)
	if (lspeech == "yes") then
			mob.registry["mob_life_timer"] = os.time() + 300
			mob.maxHealth = (Player(mob.owner).maxHealth*1.5) --new max health
			mob.health = (Player(mob.owner).health*1.5) --new current health
			mob.maxMagic = (Player(mob.owner).maxMagic*1.5) --new max magic
			mob.magic = (Player(mob.owner).magic*1.5) --new current magic
			mob.ac = Player(mob.owner).ac --new current ac
			mob.hit = Player(mob.owner).hit --Hit stat
			mob.miss = Player(mob.owner).miss --miss
			mob.baseMiss = Player(mob.owner).baseMiss --base miss (for mob dispel or whatever else)
			mob.pierce = Player(mob.owner).pierce --pierce
			mob.basePierce = Player(mob.owner).basePierce --base pierce (for mob dispel or whatever else)
			mob.level = Player(mob.owner).level --level
			mob.minDam = (Player(mob.owner).minDam*1.5) --min damage
			mob.maxDam = (Player(mob.owner).maxDam*1.5) --max damage
			mob.will = Player(mob.owner).will --will stat
			mob.grace = Player(mob.owner).grace --grace stat
			mob.might = Player(mob.owner).might --might stat
			mob.crit = Player(mob.owner).crit --crit modifier
			mob.critChance = Player(mob.owner).critChance --miss, hit or crit
			mob.critMult = Player(mob.owner).critMult --crit multiplier
			mob:talk(0, "It's On!")
			mob.target = mob.owner
			mob.registry["hitability"] = 0
			mob.owner = 0
			mob.state = MOB_HIT

	elseif (lspeech == "no") then
		mob:delete()
	end
end,

on_healed = function(mob, healer)
end,

on_attacked = function(mob,attacker)	
	if (mob.registry["hitability"] == 1) then
		mob:removeHealthWithoutDamageNumbers(0, 0)
	else
		if (mob.attacker ~= mob.target)  then
		else
			mob.attacker = attacker.ID
			mob:sendHealth(attacker.damage, attacker.critChance)
			attacker.damage = 0
		end
	end
end,
	
move = function(mob, target)

	local found
	local moved = true
	local oldside = mob.side
	local checkmove = math.random(0,10)
	local life_duration = 20

	if (os.time() > mob.registry["mob_life_timer"] + life_duration) then
		mob:removeHealthWithoutDamageNumbers(mob.health)
		return
	end

	if (mob.paralyzed == true or mob.sleep ~= 1) then
		return
	end

	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
	else
		if (mob.state ~= MOB_HIT and target == nil and mob.owner == 0) then
			mob:removeHealthWithoutDamageNumbers(mob.health, 0)
		else
			local owner = mob:getBlock(mob.owner)
			if (target == nil and owner ~= nil) then
				moved=SummonFindCoords(mob,target)	
				if (Player(mob.owner).m ~= mob.m) then
					mob:removeHealthWithoutDamageNumbers(mob.health, 0)
				end
			end
			
			if (target ~= nil) then
				if (not mob.snare and not mob.blind) then
					moved=SummonFindCoords(mob,target)	
					if (Player(mob.target).m ~= mob.m) then
						mob:removeHealthWithoutDamageNumbers(mob.health, 0)
					end
				end
				
				if((moved or mob:moveIntent(target.ID) == 1)) then
					mob.state = MOB_HIT
				end
			end	
		end
	end
	
	if (found == true) then
		mob:talk(0, "Test 1: "..mob.owner.."")
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack=function(mob,target)
	local moved
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then
		return
	end
	
	if (target) then
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then
			target = block
		end

		moved=SummonFindCoords(mob,target)	
		if(moved and mob.target ~= mob.owner) then
			--We are right next to them, so attack!
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end,

}
