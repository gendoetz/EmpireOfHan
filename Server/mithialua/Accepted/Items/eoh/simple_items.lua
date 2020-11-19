rabbit_meat = {
use = function(player)
	player:sendAction(8, 14)
	player:addHealth2(20)
end
}

acorn = {
use = function(player)
	player:sendAction(8, 14)
	player:addHealth2(5)
end
}