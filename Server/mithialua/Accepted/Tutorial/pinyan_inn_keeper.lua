pinyan_inn_keeper = {
click = async(function(player,npc)
	local t={graphic=convertGraphic(14,"monster"),color=35}
	local apple = {graphic = convertGraphic(10, "item"), color = 0}
	local opts = { }

	local welcomemsg = {"Welcome to my inn. How can I help you?",
	"Welcome!","Welcome, how may I help you?",
	"Welcome, we have the finest sheets!",
	"Welcome "..player.name..". Would you like to rest for the night?"}

	local rwelcome = math.random(#welcomemsg)
	local buymsg = {"What do you wish to buy?","What do you wish to buy today?","What would you like to buy?","What can I offer you?"}
	local rbuy = math.random(#buymsg)
	local sellmsg = {"What do you wish to sell?","What would you like to sell?","What would you like to sell today?"}
	local rsell = math.random(#sellmsg)
	--local offer_items = {}
	--	if (player.sex == 0) then
	--		offer_items = {190000001,190000007,190000013,190000019}
	--	else
	--		offer_items = {190000002,190000008,190000014,190000020}
	--	end
	
	player.npcGraphic=t.graphic
	player.npcColor=t.color
	player.dialogType = 0
	table.insert(opts,"Buy")
	table.insert(opts,"Sell")
	table.insert(opts,"Bind")
	table.insert(opts,"Deposit Item")
	table.insert(opts,"Withdraw Item")
	table.insert(opts,"Deposit Money")
	table.insert(opts,"Withdraw Money")
	table.insert(opts,"An apple a day...")


	if(#opts~=0) then
		local menuOption=player:menuString(""..welcomemsg[rwelcome],opts)
		if(menuOption=="Buy") then
			player:buyExtend(buymsg[rbuy],{34, 58, 39, 38})
		elseif(menuOption=="Sell") then
			player:sellExtend(sellmsg[rsell],{34, 58, 39, 38})
		elseif(menuOption=="Bind") then
				local menuOptionBind=player:menuString("Do you wish to bind to here?",{"Yes", "No"})
					if(menuOptionBind=="Yes") then
						if (player.bind ~= 1) then
							player:sendMinitext("You cannot bind here.")
							return
						else
							player.registry["bindMap"] = player.m
							player.registry["bindX"] = player.x
							player.registry["bindY"] = player.y
							player:dialogSeq({t,"You are now bound here. The return spell will bring you to this location."},1)
						end
					elseif(menuOptionBind=="No") then
						player:dialogSeq({t,"So be it."},1)
					end
		elseif(menuOption=="Deposit Item") then
			player:showBankAdd("What do you wish to deposit?")
		elseif(menuOption=="Withdraw Item") then
			player:showBank("What do you wish to withdraw?")
		elseif(menuOption=="Deposit Money") then
			player:bankAddMoney()
		elseif(menuOption=="Withdraw Money") then
			player:bankWithdrawMoney(t)
		elseif(menuOption=="An apple a day...") then
			if (player.quest["P_anapple"] == 0) then
				player:dialogSeq({t, "Hi there! Do you think you could do me a favor hunny?",
				t, "Ever since the witch has corrupted the woods, I haven't been able to venture into the orchard to pick apples. *Linyi frowns*",
				apple, "There is one tree that still bears fruit and has avoided corruption; and as a matter of fact the apples it produces are some of the best in the kingdom!",
				apple, "If you could bring me back some apples that would be really wonderful, about 12 would do!"}, 1)
				player.quest["P_anapple"] = 1
			elseif (player.quest["P_anapple"] == 1) then
				if (player:hasItem("red_P_apple", 12) == true) then
					player:dialogSeq({t, "WOW!  Those apples look delicious!  Thanks a bunch, or should a say bushel? Tehehe!"}, 1)
					player:removeItem("red_P_apple", 12)
						player:addGold(600)
						player:giveXP(7500)
						onCalcTNL(player)
						player:msg(8, "Rewards:\nGold: 600\nExp: 7500", player.ID)
						player.quest["P_anapple"] = 2
				else
					player:dialogSeq({t, "If you could bring me back some apples from the eastern Pinyan woods that would be really wonderful, about 12 would do!"}, 1)
				end
			elseif (player.quest["P_anapple"] == 2) then
				player:dialogSeq({t, "Thanks again for the apples sweetie!"}, 1)
			end
		end
	end
end),

shakeappletree = async(function(player)
	local apple = {graphic = convertGraphic(10, "item"), color = 0}
	if (player:hasItem("red_P_apple", 12) == true) then
		return
	end
	local checkapples = player:getObjectsInMap(28, BL_ITEM)
	local applenumber = 0
	if (#checkapples > 0) then
		for i = 1, #checkapples do
			if (checkapples[i].id == 40) then
			applenumber = applenumber + 1
			end
		end
	end
	if (applenumber == 0) then
		player:dialogSeq({apple, "You notice a healthy apple tree and give it a shake!"}, 1)
		repeat
		local checkapples = player:getObjectsInMap(28, BL_ITEM)
		local applenumber = 0
		if (#checkapples > 0) then
			for i = 1, #checkapples do
				if (checkapples[i].id == 40) then
				applenumber = applenumber + 1
				end
			end
		end
		if (applenumber <= 5) then
		local ranx = math.random(0, 3)
		local rany = math.random(32, 37)
		player:dropItemXY(40, 1, 28, ranx, rany, player.id)
		end
		until (applenumber >= 6)
		player:dialogSeq({apple, "It looks like you have shaken free 6 apples, pick them up and shake again when no more remain on the ground!"}, 1)
	end
end),


action = function(npc, player)
	local str = {
	"Linyi: There are so many handsome soldiers that stay here..",
	"Linyi: My hair is so red!",
	"Linyi: My sister is a real WITCH! No really.. she's green and loves red apples.."
	}
	local rstr = math.random(#str)
	if (math.random(88) == 8) then
		npc:talk(0,""..str[rstr])
	end
end
}