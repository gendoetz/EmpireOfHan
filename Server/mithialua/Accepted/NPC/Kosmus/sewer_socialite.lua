sewer_socialite = {
click = async(function(player, npc)
	local npcS = {graphic = convertGraphic(70, "monster"), color = 5}
	local rat = {graphic = convertGraphic(2012, "item"), color = 17}
	local gator = {graphic = convertGraphic(2014, "item"), color = 28}

	player.npcGraphic = npcS.graphic
	player.npcColor = npcS.color
	player.dialogType = 0
	
	--You had the entire statement enclosed in the if = 0, which means once a character gets to 1, they can never access this portion of the script again
	if (player.quest["sewer_passage"] == 0) then
		local opts = { }
		table.insert(opts,"Sure, no problem!")
		table.insert(opts,"I'd rather not..")

			local choice=player:menuString2("Sorry, I'm just taking a break. If you gather a few items for me, I'd be willing to move. What do you say?", opts)
			if(choice=="Sure, no problem!") then
				player:dialogSeq({npcS, "Excellent! There's only two things I need..",
				rat, "The first thing I need is the heart of the biggest rat you can find. I heard some rather loud screeches coming from the path to the left, try searching around there.",
				gator, "The second thing I need is fairly difficult to get, it's a rather uncommon species of animal you see. I require the eye of an Albino Alligator..", -- forgot a comma here
				npcS, "Bring both of these back to me and I'll be sure to get out of your way!"}, 1)
				player.quest["sewer_passage"] = 1
				return -- Return throws them out of loop back to nothing, they wont get the still havent found message
			elseif(choice=="I'd rather not..") then
				player:dialogSeq({npcS, "That's alright, be careful on your travels!"}, 1) -- You had a bracket here instead of a paranthesis, and a bracket needed to come before the comma
				return -- return allows you to stop all the remaining code below this if they say no.
			end
	end --you need this end here, or you stop them from passing this area

	if (player.quest["sewer_passage"] == 1) then -- You forgot a then after this statement
			if (player:hasItem("mutated_heart", 1) == true and player:hasItem("alligator_eye", 1) == true) then --use and to require two statements to be true, AND, OR, ~= (not equal)
			--if (player:hasItem("alligator_eye", 1) == true) then  this would never work, cant open two if statement without closing one
				player:dialogSeq({npcS, "Perfect! Just what I was looking for..",
				npcS, "*shuffles out of your way*"}, 1) -- Parenthesis not a bracket
				player:removeItem("mutated_heart", 1)
				player:removeItem("alligator_eye", 1) -- you had takeItem, its removeItem
				--warp characters to map 574 (12, 3)
				for i = 1, #player.group do
					if (player.m == Player(player.group[i]).m) then
					Player(player.group[i]):warp(574,12,3)
					end
				end
				player.quest["sewer_passage"] = 0
				return
			else
				player:dialogSeq({npcS, "Still haven't found that heart and eye I need have you?"}, 1)
			--added end
			end
	end
end) -- final end closes the click statement you opened. ASYNC function way at the top opens a ( parenthesis, it has to be closed way at the end after the END statment
} --Bracket needs to close a bracket that you opened way at the top for the code, huge leak there.