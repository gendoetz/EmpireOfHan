han_inn_keeper = {
click = async(function(player,npc)
	han_inn_keeper.main_menuFunc(player, npc)
end),

main_menuFunc = function(player,npc)
	local t={graphic=convertGraphic(13,"monster"),color=9}
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
	table.insert(opts,"I see dead people...")

	if (player.id == 2) then
		--table.insert(opts,"Item")
	end


	if(#opts~=0) then
		local menuOption=player:menuString(""..welcomemsg[rwelcome],opts)
		if(menuOption=="Buy") then
			player:buyExtend(buymsg[rbuy],{34, 58, 61, 39, 60})
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Sell") then
			player:sellExtend(sellmsg[rsell],{34, 58, 61, 39, 60, 176})
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Item") then
			player:addItem("finem_garb_po", 1, 0, 604)
			player:addItem("finem_garb_po", 1, 0, 0, "*Bra and Panties*")
			player:addItem("finem_garb_po", 1, 0, 604, "*Glittery Sexy Robes*")
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
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Deposit Item") then
			player:showBankAdd("What do you wish to deposit?")
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Withdraw Item") then
			player:showBank("What do you wish to withdraw?")
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Deposit Money") then
			player:bankAddMoney()
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="Withdraw Money") then
			player:bankWithdrawMoney(t)
			han_inn_keeper.main_menuFunc(player, npc)
		elseif(menuOption=="I see dead people...") then
			if (player.quest["H_deadpeople2"] == 0) then
				player:dialogSeq({t, "*Looks at you suspiciously*",
				t, "I am afraid my inn is haunted!  To tell you the truth, I think it is one of the books that is haunted..  Ever since that dark stranger stayed here guests have complained of a chill at night...",
				t, "I just cant bring myself to rent out the far north east room, and the door is locked tight, I get the heebee-jeebees just thinking about going inside.",
				t, "You look like a capable fighter, do you think you could check the book case out?  Here, you'll need my key. ((Hit the 'o' key near the door to go inside)) "}, 1)
				player:addItem("han_inn_key", 1)
				player.quest["H_deadpeople2"] = 1
			elseif (player.quest["H_deadpeople2"] == 1 or player.quest["H_deadpeople2"] == 2) then
					player:dialogSeq({t, "If you could go check that book case out for me, I would really appreciate it!  ((Hit the 'o' key near the door to go inside))"}, 1)
					player.quest["H_deadpeople2"] = 1
			elseif (player.quest["H_deadpeople2"] == 3) then
				player:dialogSeq({t, "A GHOST!?  I knew it! I need to get that shaman in here to cleanse my inn, that dark stranger could have done more damage than I anticipated..."}, 1)
				player:removeItem("han_inn_key", 1)
				player.registry["imperial_standing"] = player.registry["imperial_standing"] + 1
				player:addGold(600)
				player:giveXP(15000)
				onCalcTNL(player)
				player:msg(8, "Rewards:\nGold: 600\nExp: 15000\nImperial Standing: +1", player.ID)
				player.quest["H_deadpeople2"] = 4
			elseif (player.quest["H_deadpeople2"] == 4) then
				player:dialogSeq({t, "Ghosts do not belong in my inn!  Thanks for your help "..player.name.."."}, 1)
			end
		end
	end
end,

book_han_inn = async(function(player)
	local ghost = {graphic=convertGraphic(167,"monster"),color=3}
	
	player:dialogSeq({ghost, "You feel a sharp chill and notice a shadow appear."}, 1)
	player:spawn(30, 25, 3, 1)
	player.quest["H_deadpeople2"] = 3

end)
}

H_questghost = {	
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob)
	mob_ai_basic.move(mob, target)
end,

attack=function(mob,target)
	mob_ai_basic.attack(mob, target)
end,

after_death = function(mob, player)
player.quest["H_deadpeople2"] = 3
end,

on_spawn = function(mob)
	mob.side = 1
	mob:sendSide()
	mob:talk(0, "Dusty Ghost: Boo!")
end,
}