opening_scene = {

firstlogin = async(function(player)
	local spiritprogress = player.registry["spirit_progress"]
	local opts = {}
	table.insert(opts,"Yes")
	table.insert(opts,"No")
	local seizures = {}
	table.insert(seizures,"I suffer from seizures.")
	table.insert(seizures,"I do not suffer from seizures.")
	local menuOption, menuOption2
	local cont = 0
	local t={graphic=convertGraphic(838,"monster"),color=0}
	local e={graphic=convertGraphic(1035,"monster"),color=1}
	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.lastClick = F1_NPC
	--player.blind = false
	--player.state = -1
	--player.gfxClone = 1
	--player:updateState()
	
	if (player.registry["spirit_progress"] == 0) then
		player.baseClass = 0
		if (player.registry["firstloginfail"] == 1) then--first login failed
			player:dialogSeq({e,"You try to wake up, but cannot; it seems as if you must finish the dream..."},1)
		end
		
		player:dialogSeq({
		e,"You feel very light and as you open your eyes you see something approaching...",
		e,"...with your eyes still fuzzy you seem to recognize a silhouette...",
		t,"Greetings "..player.name..". I am a spirit of Genesis and my task is to aid you in your journey.",
		t,"I will be loyal to you regardless of your actions.",
		t,"Some say destiny is written, but I believe even if it is written you are still able to make your own choices to shape your own destiny.",
		t,"I believe that some choices not even the gods can foretell as they are incapable of grasping the power of choice.",
		t,"Certain choices you make will affect the world's view of you. Choose wisely as your future is up to you.",
		t,"Now I would like for you to make your first choice. An entity as I am, I was not given a name; but perhaps you can suggest one for me. I will be contacting you often, so this will help with communication."
		},1)
		player.registry["spirit_progress"] = 1
	end

	local f1n = ""
	local triggered = false
	
	if (player.registry["spirit_progress"] == 1) then
		player:dialogSeq({t, "You must give me a name."}, 1)
		
		repeat
			if (triggered) then
				player:dialogSeq({
				t,"My name must be 4-16 characters."},1)
				player.registry["spirit_progress"] = 1
			end
			
			f1n = player:input("What shall I be named?")
			triggered = true
		until (string.len(f1n) > 3 and string.len(f1n) <= 15)
		
		player.f1Name = f1n
		player.registry["spirit_progress"] = 2
	end

	if (player.registry["spirit_progress"] == 2) then
		player:dialogSeq({
		t,"I shall be "..player.f1Name.." from now on.",
		t,"If you are in need of assistance, you may press the [F1] key at any time to call for me."
		},1)
		player.registry["spirit_progress"] = 3
	end

	if (player.registry["spirit_progress"] == 3) then
		player:dialogSeq({
		t,"Now I would like to learn a bit about you."
		},1)
		if(#opts~=0) then
			menuOption = player:menu("Do you suffer from seizures?",opts)
			if(menuOption==1) then --YES
				player.registry["settings_seizure"]=1
				player:dialogSeq({t,"-"..player.f1Name.." writes this on a scroll, and as he finishes it vanishes-"},1)
				cont = 1
			elseif(menuOption==2) then --NO
				menuOption2 = player:menu("Are you sure that you do not suffer from seizures?",seizures)
				if(menuOption2==1) then --I do suffer from seizures
					player.registry["settings_seizure"]=1
					player:dialogSeq({t,"-"..player.f1Name.." writes this on a scroll, and as he finishes it vanishes-",
					t,"I am sorry to hear, I will keep it in mind."},1)
					cont = 1
				elseif(menuOption2==2) then --I do not suffer from seizures
					player:dialogSeq({t,"-"..player.f1Name.." writes this on a scroll, and as he finishes it vanishes-",
					t,"If you do suffer from seizures and made a mistake, please contact a Game Master as soon as possible."},1)
					cont = 1
				end
			end
		end
	end
	if (cont == 1) then
		player.registry["spirit_progress"] = 4
	end

	if (player.registry["spirit_progress"] == 4) then
		player:dialogSeq({
		t,"Now I would like to provide you with some information about this realm.",
		t,"The most important thing to remember is that you are responsible for your own actions.",
		t,"Any action you perform or choice you make may have an impact on how the world views you.",
		t,"Certain tasks do not have a specific ending and you will determine how things will progress. Unlike the gods you have the power to shape your own destiny.",
		t,"Secondly, you are an individual and are free to choose how YOU will progress, both physically and mentally.",
		t,"You are in full control of how your body grows.",
		t,"As you accumulate experience you will gain insight.",
		t,"Might allows you to be stronger in swing and vitality, Will improves the accuracy of your spells and your pool of mana, while Grace increases your accuracy",
		t,"and avoidance while giving you a bit of both vitality and mana."
		},1)
		player.registry["spirit_progress"] = 5
	end
	if (player.registry["spirit_progress"] == 5) then
		player:dialogSeq({
		t,"Now I'm going to search your mind for what has brought you to me."
		},1)
		
		player.registry["spirit_progress"] = 6
	end

	--optional survey
	if (player.registry["spirit_progress"] == 6) then

	end
end)
}
