twisted_blade_e = {
	on_hit = function(player,target)
		local attack_chance = math.random(1,20)
		

		if(attack_chance == 5) then
				local mobTarget = getTargetFacing(player, BL_MOB)
				local pcTarget = getTargetFacing(player, BL_PC)
				local threat
				local damage = player.health * 1.25
				local healthCost = (player.health * .33)
				local magicCost = (player.magic * .05)
				local minHealth = 100
				local minMagic = 500

				if (not player:canCast(1, 1, 0)) then
					return
				end
				
				if (player.health < minHealth or player.health - healthCost <= 0) then
					player:sendMinitext("Not enough vita.")
					return
				end
				
				if (player.magic < minMagic) then
					player:sendMinitext("Not enough mana.")
					return
				end
				
				if (mobTarget ~= nil) then
				player:sendAction(1, 20)
				player:sendMinitext("You use Twist of Fate.")
				player:playSound(60)

					player.health = player.health - healthCost
					player.magic = player.magic - magicCost
					player:sendStatus()

					mobTarget:sendAnimation(6, 0)
					mobTarget.attacker = player.ID
					threat = mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 2)
					player:addThreat(mobTarget.ID, threat)
					
					if (#player.group > 1) then
						mobTarget:setGrpDmg(player.ID, threat)
					else
						mobTarget:setIndDmg(player.ID, threat)
					end
					
					mobTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
				elseif (pcTarget ~= nil) then
					if (player:canPK(pcTarget)) then
						pcTarget:sendAnimation(6, 0)
						player:sendAction(1, 20)
						player:sendMinitext("You use Twist of Fate.")
						player:playSound(60)

						player.health = player.health - healthCost
						player.magic = player.magic - magicCost
						player:sendStatus()
						pcTarget.attacker = player.ID
						pcTarget:removeHealthExtend(damage, 1, 1, 1, 1, 0)
						pcTarget:sendMinitext(player.name.." uses Twist of Fate on you.")
					end
				end
		end
	end
}