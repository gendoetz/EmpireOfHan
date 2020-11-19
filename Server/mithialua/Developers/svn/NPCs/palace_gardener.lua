palace_gardener = {
click = async(function(player, npc)
	local p_gardener = {graphic = 0, color = 0}
	local bulb = {graphic = convertGraphic(4117, "item"), color = 6}
		player.npcGraphic = p_gardener.graphic
		player.npcColor = p_gardener.color
		player.dialogType = 1

	local repeat_timer = 172800
	
	if (player.registry["repeat_palace_garden"] ~= 0) then
		if (player.registry["repeat_palace_garden"] >= os.time()) then
			player:dialogSeq({p_gardener, "Thanks again darling. I will probably need more bulbs again once I plant these so check in with me in a couple days!"}, 1)
			return
		end
	end

	local opts = { }
		table.insert(opts,"Sure, I'd love to help.")
		table.insert(opts,"No, I have better things to do.")

	if (player.level >= 67) then
		if (player.quest["palace_garden"] == 0) then
			player:dialogSeq({p_gardener, "Oh goodness me! Do not sneak up on me like that!",
				p_gardener, "Oh my, I'm very sorry. That was rude of me, my name is Leikeu. I'm the gardener who looks after all the flora here in the palace.",
				p_gardener, "I wasn't anticipating anyone to be touring the garden yet. It's not quite finished and looks well, extremely disheveled to say the least.",
				p_gardener, "Usually it's abundant with blooming flowers that captivate the eye, however as of late our supply of bulbs from the Vogt Forest is dwindling at an exceedingly fast pace.",
				p_gardener, "Normally I would ask the travelling merchants in town for aide, but not many are strong enough to venture to where the bulbs can be cultivated."}, 1)

				local choice=player:menuString("Might you be able to offer a bit of your time and assistance?", opts)
					if (choice == "Sure, I'd love to help.") then
						player:dialogSeq({p_gardener, "Wonderful! The bulbs can be found south of the Kingdom in the Vogt Forest.",
							p_gardener, "Be cautious though, inside the meadow lurks three magical sisters. They seem to have casted a great magical spell that changed the once harmless flowers into ravaging monsters.",
							bulb, "Slay the enchanted flowers and collect 20 bulbs for me, that should be enough to replenish these flower beds."}, 1)
							player.quest["palace_garden"] = 1
					elseif (choice == "No, I have better things to do.") then
						player:dialogSeq({p_gardener, "Oh, well I'm sorry to bother you. Please enjoy the garden at your leisure."}, 1)
						return
					end
		elseif (player.quest["palace_garden"] == 1) then
			if (player:hasItem("flower_bulb", 20) == true) then
				player:dialogSeq({p_gardener, "That was quick! How did you get them so fast?!",
					p_gardener, "With these we should be able to have a wonderful garden once more.",
					p_gardener, "Thank you for all of your help, I know this isn't much but it is all I can offer you for now.."}, 1)
						player:removeItem("flower_bulb", 20)
						player.quest["palace_garden"] = 0
						player.registry["repeat_palace_garden"] = os.time() + repeat_timer
						player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
						player:addGold(5000)
						player:giveXP(2500000)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 5000\nExp: 2500000\nImperial Standing: +1", player.ID)

			else
			player:dialogSeq({p_gardener, "You don't seem to have all of the bulbs, please bring me 20 from the Floradine Flower cavern."}, 1)
			end
		end	
	else
		player:dialogSeq({p_gardener, "...you see a woman oblivious to her surroundings, humming to herself as she wanders between the flower beds..."}, 1)
	end
end),

action = function(npc)
palace_gardener.move(npc)
end,

move = function(npc)

	local oldside = npc.side
	local checkmove = math.random(0,10)


	if ((npc.x - npc.startX) >= 5) then
		npc.side=3
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.x - npc.startX) <= -5) then
		npc.side=1
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) >= 5) then
		npc.side=0
		npc:sendSide()
		npc:move()
		return
	end
	if ((npc.y - npc.startY) <= -5) then
		npc.side=2
		npc:sendSide()
		npc:move()
		return
	end

	if(checkmove >= 4) then
		npc.side=math.random(0,3)
		npc:sendSide()
		if(npc.side == oldside) then
			npc:move()
		end
	else
		npc:move()
	end
end,

}