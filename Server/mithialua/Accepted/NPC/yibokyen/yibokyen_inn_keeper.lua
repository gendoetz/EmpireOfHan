yibokyen_inn_keeper = {
click = async(function(player,npc)
	yibokyen_inn_keeper.main_menuFunc(player, npc)
end),

main_menuFunc = function(player,npc)
	local t={graphic=convertGraphic(npc.look,"monster"),color=npc.lookColor}
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

	if(#opts~=0) then
		local menuOption=player:menuString(""..welcomemsg[rwelcome],opts)
		if(menuOption=="Buy") then
			player:buyExtend(buymsg[rbuy],{34, 58, 61, 39, 473})
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Sell") then
			player:sellExtend(sellmsg[rsell],{34, 58, 61, 39, 60, 473, 176})
			yibokyen_inn_keeper.main_menuFunc(player, npc)
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
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Deposit Item") then
			player:showBankAdd("What do you wish to deposit?")
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Withdraw Item") then
			player:showBank("What do you wish to withdraw?")
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Deposit Money") then
			player:bankAddMoney()
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Withdraw Money") then
			player:bankWithdrawMoney(t)
			yibokyen_inn_keeper.main_menuFunc(player, npc)
		end
	end
end,
}