seer_fortunecookie = {
use = function(player)
	local npcA = {graphic = convertGraphic(1656, "item"), color = 0}

	local fortuneMeanings = {}
		fortuneMeanings[1] = "There is a prospect of a thrilling time ahead for you."
		fortuneMeanings[2] = "The troubles you have now will pass away quickly."
		fortuneMeanings[3] = "Don't bother looking for fault. The reward for finding it is low."
		fortuneMeanings[4] = "The days that make us happy make us wise."
		fortuneMeanings[5] = "Nothing in the world is accomplished without passion."
		fortuneMeanings[6] = "You will be sharing great news with all people you love."
		fortuneMeanings[7] = "Don't find fault, find a remedy."
		fortuneMeanings[8] = "A stranger, is a friend you have not spoken to yet."
		fortuneMeanings[9] = "People who are late are often happier than those who have to wait for them."
		fortuneMeanings[10] = "You have a strong desire for a home and your family interests come first."
		fortuneMeanings[11] = "They say you are stubborn; you call it persistence."
		fortuneMeanings[12] = "An admirer is concealing his/her affection for you."
		fortuneMeanings[13] = "Jealousy is a useless emotion."
		fortuneMeanings[14] = "Emotion is energy in motion."
		fortuneMeanings[15] = "You must try, or hate yourself for not trying."
		fortuneMeanings[16] = "He who seeks will find."
		fortuneMeanings[17] = "You will have good luck and overcome many hardships."
		fortuneMeanings[18] = "Never give up. Always find a reason to keep trying."
		fortuneMeanings[19] = "There are no shortcuts to any place worth going."
		fortuneMeanings[20] = "People in your surroundings will be more cooperative than usual."

	local rFortune = math.random(#fortuneMeanings)
	local cFortune = fortuneMeanings[rFortune]

	player:sendMinitext("Crumbs from the cookie scatter everywhere.")
	player:dialogSeq({npcA, ""..cFortune..""}, 0)

end,
}