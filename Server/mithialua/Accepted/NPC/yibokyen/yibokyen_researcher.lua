yibokyen_researcher = {
click = async(function(player, npc)
	local npcT = {graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
	local orb = {graphic = convertGraphic(2626, "item"), color = 2}
	local ice_weaps = {271, 272, 273, 274}
	local ice_weapscost = {1, 1, 1, 1}

	player.npcGraphic = npcT.graphic
	player.npcColor = npcT.color
	player.dialogType = 0
	
	if (player.quest["yibokyen_intro"] == 0) then
		player:dialogSeq({npcT, "Well you don't look familiar...",
		npcT, "You must be new to the northlands, we call our small village Yi Bok Yen--I am Gin Dian the Researcher of northern artifacts. It is nice to see a traveler, new faces are always welcome.",
		npct, "You seem like the type that is up for adventure.. and I am certain you will find plenty of that here in the northlands.",
		npcT, "To be honest, the reason I ventured here was to study the many magical artifacts that are scattered around the frozen ruins.",
		npcT, "The ancient texts discovered here speak of a race that was once capable of untold magics and powers.. but that they became corrupted by an immense thirst for arcane energy.",
		npcT, "Many artifacts have helped me in my studies, perhaps if you find anything you could come show me...",
		npcT, "A bit of a warning though, the lands further north of here are cold, perhaps you should gear up with more appropriate garments at the seamstress.",
		npcT, "Oh.. and one last thing.. beware the frozen spirits, they are a tricky bunch--they reside within the ruins of the frozen palace.",
		npcT, "I would suggest you bring along some companions, you will most likely need their help along the way... good luck!"}, 1)
		player.quest["yibokyen_intro"] = 1
		return
	elseif (player.quest["yibokyen_intro"] == 1) then
		if (player:hasItem("frozen_orb", 1) == true) then
			player:removeItem("frozen_orb", 1)
			player.quest["yibokyen_intro"] = 2
			player:dialogSeq({orb, "Oh my, what is this you have? Simply astounding!",
			npcT, "Hmm.. This will require more research for certain. Perhaps if you bring to be a number of these.. we may be able to do something with them..",
			npcT, "Old texts recovered from the ruins speak of a sealed door within the Frozen Palace that may only be opened by those who wield weapons imbued with the magics of ice.",
			orb, "See if you can discover the door and investigate it, bring to me (5) Frozen Orbs.. I have some research to do while you accomplish that..."}, 1)
			return
		else
			player:dialogSeq({npcT, "Have you found any objects worth my time?"}, 1)
		end
	elseif (player.quest["yibokyen_intro"] == 2) then
		if (player:hasItem("frozen_orb", 5) == true) then
			player:dialogSeq({npcT, "I see you have brought the Frozen Orbs. Have you seen the door though? Search for the door in the Frozen Palace."}, 1)
		else
			player:dialogSeq({npcT, "Hmm.. This will require more research for certain. Perhaps if you bring to be a number of these.. we may be able to do something with them..",
			npcT, "Old texts recovered from the ruins speak of a sealed door within the Frozen Palace that may only be opened by those who wield weapons imbued with the magics of ice.",
			orb, "See if you can discover the door and investigate it, bring to me (5) Frozen Orbs.. I have some research to do while you accomplish that..."}, 1)
		end
	elseif (player.quest["yibokyen_intro"] == 3) then
		player:dialogSeq({npcT, "Ahh! The incantation on the door, perfect that is the last thing we need! I have learned the method by which to forge the weapons, but you must choose.."}, 1)
		local iceweapchoice=player:buy("Which weapon will you forge?",ice_weaps,ice_weapscost,{},{})
			if (player:hasItem("frozen_orb", 5) == true) then
				player.quest["yibokyen_intro"] = 4
				player:removeItem("frozen_orb", 5)
				--player:dialogSeq({"This "..iceweapchoice}, 1)
				player:addItem(iceweapchoice, 1)
			else
				player:dialogSeq({npcT, "You do not have (5) Frozen Orbs..."}, 1)
				return
			end
		player:dialogSeq({npcT, "Beware my friend.. the foe that lies beyond that door could be quite dangerous. Good luck!"}, 1)
	elseif (player.quest["yibokyen_intro"] == 4) then
		local iceweapchoice=player:buy("Which weapon will you forge?",ice_weaps,ice_weapscost,{},{})
			if (player:hasItem("frozen_orb", 5) == true) then
				player:removeItem("frozen_orb", 5)
				player:addItem(iceweapchoice, 1)
			else
				player:dialogSeq({npcT, "You do not have (5) Frozen Orbs..."}, 1)
				return
			end
	end
end)
}