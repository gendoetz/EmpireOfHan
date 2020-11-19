seer_tarotcard = {
use = async(function(player)
	local Seer = {graphic = convertGraphic(1659, "item"), color = 704}
		player.npcGraphic = Seer.graphic
		player.npcColor = Seer.color
		player.dialogType = 0

-- CARD TABLES
	local card_table = {}
		for i = 1, 140 do
			table.insert(card_table, i) -- i = a number, this code inserts 1, and then 2, and then 3, until 5 into a table named card_table
		end
	local card_names = {}
		card_names[1] = "Knight of Wands"
		card_names[2] = "Queen of Wands"
		card_names[3] = "Prince of Wands"
		card_names[4] = "Princess of Wands"
		card_names[5] = "Knight of Cups"
		card_names[6] = "Queen of Cups"
		card_names[7] = "Prince of Cups"
		card_names[8] = "Princess of Cups"
		card_names[9] = "Knight of Swords"
		card_names[10] = "Queen of Swords"
		card_names[11] = "Prince of Swords"
		card_names[12] = "Princess of Swords"
		card_names[13] = "Knight of Disks"
		card_names[14] = "Queen of Disks"
		card_names[15] = "Prince of Disks"
		card_names[16] = "Princess of Disks"
		card_names[17] = "The Fool"
		card_names[18] = "The Fool (R)"
		card_names[19] = "The Magus"
		card_names[20] = "The Magus (R)"
		card_names[21] = "The High Priestess"
		card_names[22] = "The High Priestess (R)"
		card_names[23] = "The Empress"
		card_names[24] = "The Empress (R)"
		card_names[25] = "The Emperor"
		card_names[26] = "The Emperor (R)"
		card_names[27] = "The Hierophant"
		card_names[28] = "The Hierophant (R)"
		card_names[29] = "The Lovers"
		card_names[30] = "The Lovers (R)"
		card_names[31] = "The Chariot"
		card_names[32] = "The Chariot (R)"
		card_names[33] = "Adjustment"
		card_names[34] = "Adjustment (R)"
		card_names[35] = "The Hermit"
		card_names[36] = "The Hermit (R)"
		card_names[37] = "Fortune"
		card_names[38] = "Fortune (R)"
		card_names[39] = "Lust"
		card_names[40] = "Lust (R)"
		card_names[41] = "The Hanged Man"
		card_names[42] = "The Hanged Man (R)"
		card_names[43] = "Death"
		card_names[44] = "Death (R)"
		card_names[45] = "Art"
		card_names[46] = "Art (R)"
		card_names[47] = "The Devil"
		card_names[48] = "The Devil (R)"
		card_names[49] = "The Tower"
		card_names[50] = "The Tower (R)"
		card_names[51] = "The Star"
		card_names[52] = "The Star (R)"
		card_names[53] = "The Moon"
		card_names[54] = "The Moon (R)"
		card_names[55] = "The Sun"
		card_names[56] = "The Sun (R)"
		card_names[57] = "The Aeon"
		card_names[58] = "The Aeon (R)"
		card_names[59] = "The Universe"
		card_names[60] = "The Universe (R)"
		card_names[61] = "Ace of Wands"
		card_names[62] = "Ace of Wands (R)"
		card_names[63] = "Two of Wands"
		card_names[64] = "Two of Wands (R)"
		card_names[65] = "Three of Wands"
		card_names[66] = "Three of Wands (R)"
		card_names[67] = "Four of Wands"
		card_names[68] = "Four of Wands (R)"
		card_names[69] = "Five of Wands"
		card_names[70] = "Five of Wands (R)"
		card_names[71] = "Six of Wands"
		card_names[72] = "Six of Wands (R)"
		card_names[73] = "Seven of Wands"
		card_names[74] = "Seven of Wands (R)"
		card_names[75] = "Eight of Wands"
		card_names[76] = "Eight of Wands (R)"
		card_names[77] = "Nine of Wands"
		card_names[78] = "Nine of Wands (R)"
		card_names[79] = "Ten of Wands"
		card_names[80] = "Ten of Wands (R)"
		card_names[81] = "Ace of Cups"
		card_names[82] = "Ace of Cups (R)"
		card_names[83] = "Two of Cups"
		card_names[84] = "Two of Cups (R)"
		card_names[85] = "Three of Cups"
		card_names[86] = "Three of Cups (R)"
		card_names[87] = "Four of Cups"
		card_names[88] = "Four of Cups (R)"
		card_names[89] = "Five of Cups"
		card_names[90] = "Five of Cups (R)"
		card_names[91] = "Six of Cups"
		card_names[92] = "Six of Cups (R)"
		card_names[93] = "Seven of Cups"
		card_names[94] = "Seven of Cups (R)"
		card_names[95] = "Eight of Cups"
		card_names[96] = "Eight of Cups (R)"
		card_names[97] = "Nine of Cups"
		card_names[98] = "Nine of Cups (R)"
		card_names[99] = "Ten of Cups"
		card_names[100] = "Ten of Cups (R)"
		card_names[101] = "Ace of Swords"
		card_names[102] = "Ace of Swords (R)"
		card_names[103] = "Two of Swords"
		card_names[104] = "Two of Swords (R)"
		card_names[105] = "Three of Swords"
		card_names[106] = "Three of Swords (R)"
		card_names[107] = "Four of Swords"
		card_names[108] = "Four of Swords (R)"
		card_names[109] = "Five of Swords"
		card_names[110] = "Five of Swords (R)"
		card_names[111] = "Six of Swords"
		card_names[112] = "Six of Swords (R)"
		card_names[113] = "Seven of Swords"
		card_names[114] = "Seven of Swords (R)"
		card_names[115] = "Eight of Swords"
		card_names[116] = "Eight of Swords (R)"
		card_names[117] = "Nine of Swords"
		card_names[118] = "Nine of Swords (R)"
		card_names[119] = "Ten of Swords"
		card_names[120] = "Ten of Swords (R)"
		card_names[121] = "Ace of Disks"
		card_names[122] = "Ace of Disks (R)"
		card_names[123] = "Two of Disks"
		card_names[124] = "Two of Disks (R)"
		card_names[125] = "Three of Disks"
		card_names[126] = "Three of Disks (R)"
		card_names[127] = "Four of Disks"
		card_names[128] = "Four of Disks (R)"
		card_names[129] = "Five of Disks"
		card_names[130] = "Five of Disks (R)"
		card_names[131] = "Six of Disks"
		card_names[132] = "Six of Disks (R)"
		card_names[133] = "Seven of Disks"
		card_names[134] = "Seven of Disks (R)"
		card_names[135] = "Eight of Disks"
		card_names[136] = "Eight of Disks (R)"
		card_names[137] = "Nine of Disks"
		card_names[138] = "Nine of Disks (R)"
		card_names[139] = "Ten of Disks"
		card_names[140] = "Ten of Disks (R)"
	local card_meanings = {}
		card_meanings[1] = "Active, aggressive, angry, assertive, competitive, confident, dynamic, impulsive, initiating, irritable, narrow-minded, pioneering, short-tempered, violent. A leader."
		card_meanings[2] = "Altruistic, controlling, commanding, detached, frank, honest, idealistic, impatient, impressionable, loyal, restless."
		card_meanings[3] = "Ambitious, attention-seeking, attractive, bold, charismatic, dramatic, egotistical, generous, noble, pompous, proud, self-confident, strong."
		card_meanings[4] = "Avenging, daring, freedom-loving, impulsive, independent, irrational, nonconforming, temperamental, unruly, unstable."
		card_meanings[5] = "Emotional, empathic, moody, hypersensitive, nurturing, overcautious, paternal, protective, romantic, supportive, tenacious."
		card_meanings[6] = "Calm, compassionate, emotional, inattentive, intuitive, maternal, observant, passive, receptive, sensitive, spiritual, sympathetic, understanding, unrealistic, unreliable."
		card_meanings[7] = "Compulsive, focused, intense, introverted, irritable, jealous, magnetic, passionate, passive-aggressive, secretive, skeptical, willful."
		card_meanings[8] = "Accepting, childish, emotionally unstable, gracious, graceful, imaginative, intuitive, loving, social, unrealistic."
		card_meanings[9] = "Ambiguous, compromising, cooperative, detached, impartial, inconsistent, indecisive, impatient, persuasive, tactful, tolerant."
		card_meanings[10] = "Analytical, cold, communicative, curious, intelligent, logical, open-minded, quick-thinking, unreliable, witty."
		card_meanings[11] = "Extremist, freedom-loving, humanitarian, individualistic, imaginative, intellectual, intelligent, inventive, scatterbrained, superficial, tolerant, unfocused."
		card_meanings[12] = "Argumentative, cautious, crafty, defensive, fearful, instinctive, judgemental, reactive, self-preserving."
		card_meanings[13] = "Analytical, constructive, critical, discriminating, humble, orderly, perfectionistic, practical, pragmatic, tedious, thrifty, unsympathetic."
		card_meanings[14] = "Ambitious, cautious, conservative, determined, fertile, industrious, solitary, materialistic, reserved, serious, uncompromising, virile."
		card_meanings[15] = "Dependable, gentle, hardworking, materialistic, patient, possessive, self-indulgent, sensual, slow-moving, stable, steady, stubborn."
		card_meanings[16] = "Confident, enduring, inflexible, persistent, practical, premeditative, self-disciplined, sensual, stable."
		card_meanings[17] = "The Fool symbolizes creation, birth and the beginning of an endeavor. New ideas arise, potential is realized, and plans are made when the Fool appears."
		card_meanings[18] = "Reversed, the Fool indicates the futility and insanity of acting on these ideas without a realistic assessment of the means to implement them. Mania occurs when a person is divorced from reality."
		card_meanings[19] = "The Magus fulfills the definition of magic: the science and art of causing change to occur in conformity with will. The caduceus is indicative of the creative force of the directed will that causes change in the world around us."
		card_meanings[20] = "Reversed, the Magus's will is weak, ineffectual, and unfocused. Lack of skill or a person who claims to have skills they do not actually possess."
		card_meanings[21] = "The Priestess resembles purity of mind, body or spirit - the state of purity that facilitates the qualities of intuition, understanding, and gnosis in many different spiritual and religious traditions."
		card_meanings[22] = "Reversed, the Priestess brings corruption of the pure and denial of the spiritual. There may be conflict between spiritual principles and the material world, or manipulation of spiritual beliefs for material gain."
		card_meanings[23] = "The Empress indicates emotional well-being and satisfaction. Maternal instincts, empathy and nurturing behavior are all qualities of her being."
		card_meanings[24] = "Reversed, the Empress degrades into vanity, hedonism, and sexual or emotional manipulation. Barrenness and emotional pain are certain."
		card_meanings[25] = "The Emperor reigns with power and control over other people and yourself. Signifying paternal instincts and the enforcement of rules and regulations."
		card_meanings[26] = "Reversed, the Emperor becomes an instigator of war, aggression, cruelty, and violence. The inability to enforce rules or brings structure to the situation."
		card_meanings[27] = "The Hierophant is an initiating priest and enlightened teacher, dictating instruction and exoteric knowledge. Endurance, patience and physical labor."
		card_meanings[28] = "Reversed, the Hierophant signifies false knowledge and mistaken beliefs. Unwilling to learn or apply what is learned. Laziness, inertia and resistance to change."
		card_meanings[29] = "The Lovers signify analysis and carefully looking at all aspects of a situation, they make very calculated notes before any decision."
		card_meanings[30] = "Reversed, the Lovers lack of knowledge. They instead make impulsive or uninformed decisions. Quarrels, disagreements and arguments are held."
		card_meanings[31] = "The Chariot resembles victory and triumph over adversity. Action, moving forward with plans or taking advantage of opportunities."
		card_meanings[32] = "Reversed, the Chariot bows to defeat. Failure from taking action or being unprepared, with a lack of self-control one may find themselves leading towards violence."
		card_meanings[33] = "Adjustment, the readings are obvious. Equilibrium, balance and adjustment. A woman or man coming to maturity, becoming or being responsible for ones actions."
		card_meanings[34] = "Reversed, Adjustment indicates imbalance and falsehood. Delay in receiving justice, or a judgement against the querent. A lack of responsibility and maturity."
		card_meanings[35] = "The Hermit, indicates illumination. Darkness is dispelled, and that which was hidden is revealed. Isolation, removing oneself from a situation in order to gain new insight."
		card_meanings[36] = "Reversed, the Hermit conceals facts, obfuscating the truth. It may be time to break the secrecy, to be more social, and to interact with others."
		card_meanings[37] = "Fortune shows that favorable development is within your possession, in situations in which an element of chance is involved and the outcome is uncertain. Taking control of ones Fate/Destiny and acting upon unexpected opportunities."
		card_meanings[38] = "Reversed, Fortune brings bad luck and dark omens. You may be at the mercy of circumstances beyond your control."
		card_meanings[39] = "Lust, not to be confused with Love, resembles the energy and power in a person or situation. Sexual union and power are indicated, it may also signify the conception of a child."
		card_meanings[40] = "Reversed, Lust becomes unstable and dissipates. A weakness or inability to control this energy, due to a lack of enthusiasm and passion for the matter at hand."
		card_meanings[41] = "The Hanged Man, redemption may be at hand. There may be an opportunity to redeem yourself in a situation, to repair what has been damaged, or to restore what has been lost."
		card_meanings[42] = "Reversed, the Hanged Man are clear; sacrifice, suffering, and punishment. Your world may be literally turned upside down."
		card_meanings[43] = "Death, indicates the natural change in life. The natural progression of life through creation, death, and incarnation of all living beings. Signifying the passage of time and its effects. A logical development is forming."
		card_meanings[44] = "Reversed, Death admits to decay and stagnation. You may be trying to force something to happen faster than planned or normally possible, resulting in unnecessary waste or even failure."
		card_meanings[45] = "Art, resembling union and synthesis. Signifying team work and cooperation, combining resources to accomplish a particular purpose or goal. Moderation, a healthy balance between two opposites or extremes."
		card_meanings[46] = "Reversed, Art is the clash of opposites. The fire boils away the water, and the water extinguishes the fire. A lack of self-restraint that leads to a harmful imbalance."
		card_meanings[47] = "The Devil, an instinctual creative impulse is afoot. Drive, determination and ambition all dwell in this card. Sexual attraction and arousal that compels us to form relationships and procreate."
		card_meanings[48] = "Reversed, the Devil's instincts take over. The temptations become too much to resist. Infidelity, impulsive and compulsive behavior may lead you to act without thinking. Actions that will later be regretted."
		card_meanings[49] = "The Tower, a sudden and unexpected change. An often traumatic event that leads to a better situation in the long run. Purification through destruction, an old building being torn down so a new structure may take its place."
		card_meanings[50] = "Reversed, the Tower symbolizes danger, injury and disaster. Usually of the physical nature. A clash between emotions and intellect may bring about confusion and pain."
		card_meanings[51] = "The Star indicates hope and faith, beliefs fostered by the spiritual concepts of reincarnation, renewal, and the beneficent nature of the universe. Meditation, reflection, methods of exploring and examining your inner self."
		card_meanings[52] = "Reversed, the Star is skeptical and disbelief is its nature. Deception, easily taken advantage of and a fear of ones true self emerges."
		card_meanings[53] = "The Moon symbolizes illusion and delusion. Unconscious desires and repressed feelings may interfere with the situation at hand. Demons manifest as neurosis, depression and insanity."
		card_meanings[54] = "Reversed, the Moon signifies acknowledging and dealing with the demons of the unconscious mind. Descending into the darkness to fight either alone or with the help of family and friends."
		card_meanings[55] = "The Sun, resembling freedom and emancipation. Released from obligation or debt, allowed to make your own decisions or empowered to pursue your own destiny. Riches, glory and success all in time."
		card_meanings[56] = "Reversed, the Sun indicates your loss of freedom and choice. Material and emotional stress may be interfering with your happiness and health. Poverty and shame."
		card_meanings[57] = "The Aeon presents life changing situations. Ones that will have a significant impact on your life, such as a near-death experience changing your perspective on life."
		card_meanings[58] = "Reversed, the Aeon has a negative impact on ones life. Self-destructive lifestyles, a personal defeat or failing to meet personal goals. Psychological issues or trauma may also be at play."
		card_meanings[59] = "The Universe signifies the full manifestation and completion of a situation or project. It may also indicate it is time to finish what you've started. Practical use of knowledge and learning determine your outcome."
		card_meanings[60] = "Reversed, the Universe means a failure to bring completion and closer to a situation. Reluctance to recognize that a situation has ended, a refusal to let go, give up, and move on."
		card_meanings[61] = "Energy. Strength. The creative impulse. A natural force as opposed to invoke force."
		card_meanings[62] = "The means of realizing the well-dignified interpretations are blocked by surrounding cards.."
		card_meanings[63] = "Dominion. Power. Influence over another. Harnessing and controlling the direction of energy or force."
		card_meanings[64] = "Dictatorship. Revenge. Obstinacy. Turbulence."
		card_meanings[65] = "Creation. Birth. Established strength. Success of initial struggle. Realization of hope. Possibly pride, nobility, or power."
		card_meanings[66] = "Conceit. Arrogance. Delusions of grandeur, strength, or accomplishment."
		card_meanings[67] = "Completion, usually of a labor of love and will. It may mean conclusion or rest after labor, depending on the situation."
		card_meanings[68] = "A labor forced or undesired. A monumental labor far from completion and possibly overwhelming. A labor rushed due to anxiety that is not complete."
		card_meanings[69] = "Strife. Quarreling. Fighting. Conflict. Competition. Possibly violence."
		card_meanings[70] = "Prodigality or generosity."
		card_meanings[71] = "Success after effort. Victory or triumph after strife. Balanced energy. Gain."
		card_meanings[72] = "Insolence. Pride. Arrogance."
		card_meanings[73] = "Opposition and conflict, yet courage to meet them. Bravery. A disordered and disorganized battle with an uncertain outcome, overcome only through individual effort."
		card_meanings[74] = "Fear. Cowardice. Retreat. Victory in small, insignificant things that consume energy needed for the true conflict. The querent is the underdog."
		card_meanings[75] = "Rapidity. Speed. Haste. Approach to goal. Freedom. Communication."
		card_meanings[76] = "Too much force applied too quickly. A flash in the pan. Burnout. Impulsive violence. Impulsive behavior."
		card_meanings[77] = "Power, force, or great strength intensified with direction."
		card_meanings[78] = "Rage. Raw, uncontrollable force directed in an impulsive and often negative manner. Wasted energy or force. Weakness."
		card_meanings[79] = "Cruelty and malice. Revenge. Oppression. Repression. Fire in its most destructive aspect."
		card_meanings[80] = "Self-sacrifice or generosity in a destructive, oppressive situation."
		card_meanings[81] = "Fertility. Productiveness. Beauty. Pleasure. Happiness."
		card_meanings[82] = "The means of realizing the well-dignified interpretations are blocked by surrounding cards.."
		card_meanings[83] = "Love under will. Harmony of masculine and feminine. Warm friendship. Pleasure in company. Harmony. Mirth. Marriage."
		card_meanings[84] = "The harsher aspects of love. Disharmonious union. Folly. Love at first sight. Obsession. Literally, will under love."
		card_meanings[85] = "Plenty. Pleasure. Hospitality. Sensuality. Joy. Fortune. Passive success. Fertility."
		card_meanings[86] = "Waste. Transient pleasure. Extravagance in its negative aspects. What was once plentiful and alive may become barren and die."
		card_meanings[87] = "Weakness. Abandonment to desire. Hedonism. Pleasure mixed with anxiety. Pleasure coming to an end. Temporary pleasure as an escape from a problem or situation."
		card_meanings[88] = "Boredom. Weariness. Apathy. Burning out. Longing for something better."
		card_meanings[89] = "Disappointment. End of pleasure. Misfortune. Disturbance when least expected. Loss or end of a friendship or relationship. Sadness. Trouble from unexpected or unsuspected sources. Deceit, treachery or ill will."
		card_meanings[90] = "Emotional stability. Coping skills. Determination and fortitude to overcome misfortune and anxiety."
		card_meanings[91] = "Beginning of pleasure. Optimism. Fulfillment of sexual will."
		card_meanings[92] = "Pleasure disturbed, usually through the actions of the querent, but the true nature of this disruption is defined by surrounding cards. Pleasure at the expense of others."
		card_meanings[93] = "Corruption of pleasure. Delusion. Illusory success. Lying. Deceit. Deception. Drunkenness or drug abuse. Promises unfulfilled."
		card_meanings[94] = "Relaxation. Loosening up and letting go. Respite. Vacation. Time out to decompress and recharge."
		card_meanings[95] = "Abandoned success through indolence. Disease. Misery. Decline of interest in anything. Wandering from place to place. Depression. Lack of creativity. Emptiness."
		card_meanings[96] = "Motivation. Self-preservation. Creative impulse. Cautious optimisim. Potential to improve."
		card_meanings[97] = "Pleasure and happiness, complete and fully realized or experienced. Sensuality."
		card_meanings[98] = "Overindulgence. Unrealized happiness. Self-denial of happiness or pleasure."
		card_meanings[99] = "Complete and lasting success. Matters arranged and settled as wished. Peacemaking."
		card_meanings[100] = "Disruption of success, sometimes violent. Waste. Exhaustion. Rivalry. Attack from below."
		card_meanings[101] = "Invoked force. Represents great power for good or evil brought into existence by the will or intellect."
		card_meanings[102] = "The means of realizing the well-dignified interpretations are blocked by surrounding cards.."
		card_meanings[103] = "Peace. Peace restored. Balance of emotional and intellectual aspects of a situation. Harmony."
		card_meanings[104] = "Inactivity. Indecision. End of peace. Disruption of balance, especially between intellectual and emotional forces."
		card_meanings[105] = "Sorrow. Disruption. Separation. Melancholy. Unhappiness. Tears."
		card_meanings[106] = "Faithfulness. Honesty. Singing."
		card_meanings[107] = "Convention. Compromise. Rest from strife. Refuge from mental chaos. Recovering from sickness. Peace after war. Relaxation of anxiety."
		card_meanings[108] = "Stalemate. Forced compromise. A temporary truce, rest, or peace; the conflict will soon resume."
		card_meanings[109] = "Defeat. Weakness. Failure. Conflict decided against a person. Loss. In relationships, it may signify malice, spite, slander, or dishonor."
		card_meanings[110] = "Grief. Mourning. Recovery from defeat or failure."
		card_meanings[111] = "Intelligence that has reached its goal. Mental labor or work. Success after anxiety or trouble. Patience. Possibly a journey by water or by air."
		card_meanings[112] = "Intellectual pride. Conceit."
		card_meanings[113] = "Unstable effort. Vacillation. Striving against opposition too powerful to overcome. Unreliability. An untrustworthy person. Giving up on the brink of winning due to lack of energy."
		card_meanings[114] = "Support. Assistance. Unexpected help. Good advice. "
		card_meanings[115] = "Restriction. Interference. Attention to details at the expense of more important things. Lack of persistence. Unforeseen bad luck."
		card_meanings[116] = "Obstacles, interference. Easier to overcome but will require you to break through emotions obstructing rational thinking."
		card_meanings[117] = "Despair. Cruelty. Suffering. Pain. Loss. Illness. Pain of oppression, burden or shame."
		card_meanings[118] = "A painful lesson to be learned. Pain, despair, cruelty or suffering lessening or decreasing but not ending. The situation will not end, but will slightly improve."
		card_meanings[119] = "Reason divorced from reality. Failure. Disaster. Physical death. Spiritually, it may signal the end of delusion."
		card_meanings[120] = "A brush with death. Realization of mortality. Tragedy averted by not without significant cost."
		card_meanings[121] = "Spirit manifest as pure materialism in all senses. Physical creation and conception. The connection between the spiritual and material worlds. Dignity, usually expressed as loss or gain."
		card_meanings[122] = "The means of realizing the well-dignified interpretations are blocked by surrounding cards.."
		card_meanings[123] = "Harmonious Change. Alternation. Journeying or wandering."
		card_meanings[124] = "Disharmonious change. Change that brings a negative result. Inconsistency. Lack of focus in effort."
		card_meanings[125] = "Commerce. Construction. Material creation. Paid employment."
		card_meanings[126] = "Mismanagement. Delay in business matters, sometimes resulting in loss. Selfishness or greed. Seeking the impossible."
		card_meanings[127] = "Earthly power but nothing beyond. Security. Law and order. Skill in the direction and management of physical forces."
		card_meanings[128] = "Prejudice. Covetousness. Suspicion. Lack of originality."
		card_meanings[129] = "Intense strain with continued inaction, especially in spiritual matters. Loss of money or profession. Monetary anxiety."
		card_meanings[130] = "Labor. Land cultivation. Building. Intelligence applied to labor."
		card_meanings[131] = "Success and gain in material things. Material power, rank, influence, or nobility. Possibly philanthropy."
		card_meanings[132] = "Prodigality. Conceit with wealth. Financial management problems. Insolence."
		card_meanings[133] = "Little gain for much labor. Labor abandoned. Promises of success unfulfilled. Hopes deceived or crushed. Disappointment. Slavery. Necessity. Unprofitable speculation."
		card_meanings[134] = "Delay but growth. Charity. A labor with no expectation of material gain."
		card_meanings[135] = "Prudence. Caution. Building. Carefulness. Intelligence applied to material affairs. Agriculture. Slow, steady gain. Cunning."
		card_meanings[136] = "Too much attention paid to small details. Avarice. Hoarding. Worry."
		card_meanings[137] = "Good luck attending material affairs. Inheritance. Favor. Gain. Increase of wealth."
		card_meanings[138] = "Gain at the expense of others. Covetousness. Theft. Disfavor."
		card_meanings[139] = "Riches and material wealth, sometimes to the point where they lose importance. Completion of material gain and fortune, but nothing beyond the material. Mere accumulation."
		card_meanings[140] = "Slothfulness. Wealth gained, but at a great cost - a pyrrhic victory."
	local result_names = {}
		result_names[1] = "Knight of Wands"
		result_names[2] = "Queen of Wands"
		result_names[3] = "Prince of Wands"
		result_names[4] = "Princess of Wands"
		result_names[5] = "Knight of Cups"
		result_names[6] = "Queen of Cups"
		result_names[7] = "Prince of Cups"
		result_names[8] = "Princess of Cups"
		result_names[9] = "Knight of Swords"
		result_names[10] = "Queen of Swords"
		result_names[11] = "Prince of Swords"
		result_names[12] = "Princess of Swords"
		result_names[13] = "Knight of Disks"
		result_names[14] = "Queen of Disks"
		result_names[15] = "Prince of Disks"
		result_names[16] = "Princess of Disks"
		result_names[17] = "The Fool"
		result_names[18] = "The Fool*"
		result_names[19] = "The Magus"
		result_names[20] = "The Magus*"
		result_names[21] = "The High Priestess"
		result_names[22] = "The High Priestess*"
		result_names[23] = "The Empress"
		result_names[24] = "The Empress*"
		result_names[25] = "The Emperor"
		result_names[26] = "The Emperor*"
		result_names[27] = "The Hierophant"
		result_names[28] = "The Hierophant*"
		result_names[29] = "The Lovers"
		result_names[30] = "The Lovers*"
		result_names[31] = "The Chariot"
		result_names[32] = "The Chariot*"
		result_names[33] = "Adjustment"
		result_names[34] = "Adjustment*"
		result_names[35] = "The Hermit"
		result_names[36] = "The Hermit*"
		result_names[37] = "Fortune"
		result_names[38] = "Fortune*"
		result_names[39] = "Lust"
		result_names[40] = "Lust*"
		result_names[41] = "The Hanged Man"
		result_names[42] = "The Hanged Man*"
		result_names[43] = "Death"
		result_names[44] = "Death*"
		result_names[45] = "Art"
		result_names[46] = "Art*"
		result_names[47] = "The Devil"
		result_names[48] = "The Devil*"
		result_names[49] = "The Tower"
		result_names[50] = "The Tower*"
		result_names[51] = "The Star"
		result_names[52] = "The Star*"
		result_names[53] = "The Moon"
		result_names[54] = "The Moon*"
		result_names[55] = "The Sun"
		result_names[56] = "The Sun*"
		result_names[57] = "The Aeon"
		result_names[58] = "The Aeon*"
		result_names[59] = "The Universe"
		result_names[60] = "The Universe*"
		result_names[61] = "Ace of Wands"
		result_names[62] = "Ace of Wands*"
		result_names[63] = "Two of Wands"
		result_names[64] = "Two of Wands*"
		result_names[65] = "Three of Wands"
		result_names[66] = "Three of Wands*"
		result_names[67] = "Four of Wands"
		result_names[68] = "Four of Wands*"
		result_names[69] = "Five of Wands"
		result_names[70] = "Five of Wands*"
		result_names[71] = "Six of Wands"
		result_names[72] = "Six of Wands*"
		result_names[73] = "Seven of Wands"
		result_names[74] = "Seven of Wands*"
		result_names[75] = "Eight of Wands"
		result_names[76] = "Eight of Wands*"
		result_names[77] = "Nine of Wands"
		result_names[78] = "Nine of Wands*"
		result_names[79] = "Ten of Wands"
		result_names[80] = "Ten of Wands*"
		result_names[81] = "Ace of Cups"
		result_names[82] = "Ace of Cups*"
		result_names[83] = "Two of Cups"
		result_names[84] = "Two of Cups*"
		result_names[85] = "Three of Cups"
		result_names[86] = "Three of Cups*"
		result_names[87] = "Four of Cups"
		result_names[88] = "Four of Cups*"
		result_names[89] = "Five of Cups"
		result_names[90] = "Five of Cups*"
		result_names[91] = "Six of Cups"
		result_names[92] = "Six of Cups*"
		result_names[93] = "Seven of Cups"
		result_names[94] = "Seven of Cups*"
		result_names[95] = "Eight of Cups"
		result_names[96] = "Eight of Cups*"
		result_names[97] = "Nine of Cups"
		result_names[98] = "Nine of Cups*"
		result_names[99] = "Ten of Cups"
		result_names[100] = "Ten of Cups*"
		result_names[101] = "Ace of Swords"
		result_names[102] = "Ace of Swords*"
		result_names[103] = "Two of Swords"
		result_names[104] = "Two of Swords*"
		result_names[105] = "Three of Swords"
		result_names[106] = "Three of Swords*"
		result_names[107] = "Four of Swords"
		result_names[108] = "Four of Swords*"
		result_names[109] = "Five of Swords"
		result_names[110] = "Five of Swords*"
		result_names[111] = "Six of Swords"
		result_names[112] = "Six of Swords*"
		result_names[113] = "Seven of Swords"
		result_names[114] = "Seven of Swords*"
		result_names[115] = "Eight of Swords"
		result_names[116] = "Eight of Swords*"
		result_names[117] = "Nine of Swords"
		result_names[118] = "Nine of Swords*"
		result_names[119] = "Ten of Swords"
		result_names[120] = "Ten of Swords*"
		result_names[121] = "Ace of Disks"
		result_names[122] = "Ace of Disks*"
		result_names[123] = "Two of Disks"
		result_names[124] = "Two of Disks*"
		result_names[125] = "Three of Disks"
		result_names[126] = "Three of Disks*"
		result_names[127] = "Four of Disks"
		result_names[128] = "Four of Disks*"
		result_names[129] = "Five of Disks"
		result_names[130] = "Five of Disks*"
		result_names[131] = "Six of Disks"
		result_names[132] = "Six of Disks*"
		result_names[133] = "Seven of Disks"
		result_names[134] = "Seven of Disks*"
		result_names[135] = "Eight of Disks"
		result_names[136] = "Eight of Disks*"
		result_names[137] = "Nine of Disks"
		result_names[138] = "Nine of Disks*"
		result_names[139] = "Ten of Disks"
		result_names[140] = "Ten of Disks*"
	local card_graphics = {}
		card_graphics[1] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[2] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[3] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[4] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[5] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[6] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[7] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[8] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[9] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[10] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[11] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[12] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[13] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[14] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[15] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[16] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[17] = {graphic = convertGraphic(1122, "monster"), color = 0}
		card_graphics[18] = {graphic = convertGraphic(1122, "monster"), color = 0}
		card_graphics[19] = {graphic = convertGraphic(1114, "monster"), color = 4}
		card_graphics[20] = {graphic = convertGraphic(1114, "monster"), color = 4}
		card_graphics[21] = {graphic = convertGraphic(610, "monster"), color = 0}
		card_graphics[22] = {graphic = convertGraphic(610, "monster"), color = 0}
		card_graphics[23] = Empress
		card_graphics[24] = Empress
		card_graphics[25] = {graphic = convertGraphic(922, "monster"), color = 0}
		card_graphics[26] = {graphic = convertGraphic(922, "monster"), color = 0}
		card_graphics[27] = {graphic = convertGraphic(1100, "monster"), color = 9}
		card_graphics[28] = {graphic = convertGraphic(1100, "monster"), color = 9}
		card_graphics[29] = {graphic = convertGraphic(332, "monster"), color = 0}
		card_graphics[30] = {graphic = convertGraphic(332, "monster"), color = 0}
		card_graphics[31] = {graphic = convertGraphic(4072, "item"), color = 0}
		card_graphics[32] = {graphic = convertGraphic(4072, "item"), color = 0}
		card_graphics[33] = {graphic = convertGraphic(3287, "item"), color = 0}
		card_graphics[34] = {graphic = convertGraphic(3287, "item"), color = 0}
		card_graphics[35] = {graphic = convertGraphic(549, "monster"), color = 0}
		card_graphics[36] = {graphic = convertGraphic(549, "monster"), color = 0}
		card_graphics[37] = {graphic = convertGraphic(1588, "item"), color = 0}
		card_graphics[38] = {graphic = convertGraphic(1588, "item"), color = 0}
		card_graphics[39] = {graphic = convertGraphic(1392, "monster"), color = 32}
		card_graphics[40] = {graphic = convertGraphic(1392, "monster"), color = 32}
		card_graphics[41] = {graphic = convertGraphic(1168, "monster"), color = 0}
		card_graphics[42] = {graphic = convertGraphic(1168, "monster"), color = 0}
		card_graphics[43] = {graphic = convertGraphic(1183, "monster"), color = 0}
		card_graphics[44] = {graphic = convertGraphic(1183, "monster"), color = 0}
		card_graphics[45] = {graphic = convertGraphic(282, "monster"), color = 0}
		card_graphics[46] = {graphic = convertGraphic(282, "monster"), color = 0}
		card_graphics[47] = {graphic = convertGraphic(1021, "monster"), color = 0}
		card_graphics[48] = {graphic = convertGraphic(1021, "monster"), color = 0}
		card_graphics[49] = {graphic = convertGraphic(682, "monster"), color = 20}
		card_graphics[50] = {graphic = convertGraphic(682, "monster"), color = 20}
		card_graphics[51] = {graphic = convertGraphic(1897, "item"), color = 0}
		card_graphics[52] = {graphic = convertGraphic(1897, "item"), color = 0}
		card_graphics[53] = {graphic = convertGraphic(1931, "item"), color = 0}
		card_graphics[54] = {graphic = convertGraphic(1931, "item"), color = 0}
		card_graphics[55] = {graphic = convertGraphic(1930, "item"), color = 0}
		card_graphics[56] = {graphic = convertGraphic(1930, "item"), color = 0}
		card_graphics[57] = {graphic = convertGraphic(1088, "monster"), color = 0}
		card_graphics[58] = {graphic = convertGraphic(1088, "monster"), color = 0}
		card_graphics[59] = {graphic = convertGraphic(656, "monster"), color = 0}
		card_graphics[60] = {graphic = convertGraphic(656, "monster"), color = 0}
		card_graphics[61] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[62] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[63] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[64] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[65] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[66] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[67] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[68] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[69] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[70] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[71] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[72] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[73] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[74] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[75] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[76] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[77] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[78] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[79] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[80] = {graphic = convertGraphic(3007, "item"), color = 633}
		card_graphics[81] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[82] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[83] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[84] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[85] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[86] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[87] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[88] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[89] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[90] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[91] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[92] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[93] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[94] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[95] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[96] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[97] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[98] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[99] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[100] = {graphic = convertGraphic(317, "item"), color = 20}
		card_graphics[101] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[102] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[103] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[104] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[105] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[106] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[107] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[108] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[109] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[110] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[111] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[112] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[113] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[114] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[115] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[116] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[117] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[118] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[119] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[120] = {graphic = convertGraphic(1179, "item"), color = 5}
		card_graphics[121] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[122] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[123] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[124] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[125] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[126] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[127] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[128] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[129] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[130] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[131] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[132] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[133] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[134] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[135] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[136] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[137] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[138] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[139] = {graphic = convertGraphic(276, "item"), color = 18}
		card_graphics[140] = {graphic = convertGraphic(276, "item"), color = 18}
-- CARD SELECTION
	local shiftVar = 0
	local card1 = math.random(#card_table)
	local card_selected1 = card_table[card1]
	local cardname_1 = card_names[card1]
	local cardmeaning_1 = card_meanings[card1]
	local resultname_1 = result_names[card1]
	local cardgraphic_1 = card_graphics[card1]
		if (card1 >= (17 - shiftVar)) then
			if (card1 % 2 == 0) then -- Even
				table.remove(card_table, card1)
				table.remove(card_table, (card1-1))
				table.remove(card_names, card1)
				table.remove(card_names, (card1-1))
				table.remove(card_meanings, card1)
				table.remove(card_meanings, (card1-1))
				table.remove(result_names, card1)
				table.remove(result_names, (card1-1))
				table.remove(card_graphics, card1)
				table.remove(card_graphics, (card1-1))
			else -- odd
				table.remove(card_table, (card1+1))
				table.remove(card_table, card1)
				table.remove(card_names, (card1+1))
				table.remove(card_names, card1)
				table.remove(card_meanings, (card1+1))
				table.remove(card_meanings, card1)
				table.remove(result_names, (card1+1))
				table.remove(result_names, card1)
				table.remove(card_graphics, (card1+1))
				table.remove(card_graphics, card1)
			end
		elseif (card1 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card1)
			table.remove(card_names, card1)
			table.remove(card_meanings, card1)
			table.remove(result_names, card1)
			table.remove(card_graphics, card1)
		end
	local card2 = math.random(#card_table)
	local card_selected2 = card_table[card2]
	local cardname_2 = card_names[card2]
	local cardmeaning_2 = card_meanings[card2]
	local resultname_2 = result_names[card2]
	local cardgraphic_2 = card_graphics[card2]
		if (card2 >= (17 - shiftVar)) then
			if (card2 % 2 == 0) then -- Even
				table.remove(card_table, card2)
				table.remove(card_table, (card2-1))
				table.remove(card_names, card2)
				table.remove(card_names, (card2-1))
				table.remove(card_meanings, card2)
				table.remove(card_meanings, (card2-1))
				table.remove(result_names, card2)
				table.remove(result_names, (card2-1))
				table.remove(card_graphics, card2)
				table.remove(card_graphics, (card2-1))
			else -- odd
				table.remove(card_table, (card2+1))
				table.remove(card_table, card2)
				table.remove(card_names, (card2+1))
				table.remove(card_names, card2)
				table.remove(card_meanings, (card2+1))
				table.remove(card_meanings, card2)
				table.remove(result_names, (card2+1))
				table.remove(result_names, card2)
				table.remove(card_graphics, (card2+1))
				table.remove(card_graphics, card2)
			end
		elseif (card2 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card2)
			table.remove(card_names, card2)
			table.remove(card_meanings, card2)
			table.remove(result_names, card2)
			table.remove(card_graphics, card2)
		end
	local card3 = math.random(#card_table)
	local card_selected3 = card_table[card3]
	local cardname_3 = card_names[card3]
	local cardmeaning_3 = card_meanings[card3]
	local resultname_3 = result_names[card3]
	local cardgraphic_3 = card_graphics[card3]
		if (card3 >= (17 - shiftVar)) then
			if (card3 % 2 == 0) then -- Even
				table.remove(card_table, card3)
				table.remove(card_table, (card3-1))
				table.remove(card_names, card3)
				table.remove(card_names, (card3-1))
				table.remove(card_meanings, card3)
				table.remove(card_meanings, (card3-1))
				table.remove(result_names, card3)
				table.remove(result_names, (card3-1))
				table.remove(card_graphics, card3)
				table.remove(card_graphics, (card3-1))
			else -- odd
				table.remove(card_table, (card3+1))
				table.remove(card_table, card3)
				table.remove(card_names, (card3+1))
				table.remove(card_names, card3)
				table.remove(card_meanings, (card3+1))
				table.remove(card_meanings, card3)
				table.remove(result_names, (card3+1))
				table.remove(result_names, card3)
				table.remove(card_graphics, (card3+1))
				table.remove(card_graphics, card3)
			end
		elseif (card3 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card3)
			table.remove(card_names, card3)
			table.remove(card_meanings, card3)
			table.remove(result_names, card3)
			table.remove(card_graphics, card3)
		end
	local card4 = math.random(#card_table)
	local card_selected4 = card_table[card4]
	local cardname_4 = card_names[card4]
	local cardmeaning_4 = card_meanings[card4]
	local resultname_4 = result_names[card4]
	local cardgraphic_4 = card_graphics[card4]
		if (card4 >= (17 - shiftVar)) then
			if (card4 % 2 == 0) then -- Even
				table.remove(card_table, card4)
				table.remove(card_table, (card4-1))
				table.remove(card_names, card4)
				table.remove(card_names, (card4-1))
				table.remove(card_meanings, card4)
				table.remove(card_meanings, (card4-1))
				table.remove(result_names, card4)
				table.remove(result_names, (card4-1))
				table.remove(card_graphics, card4)
				table.remove(card_graphics, (card4-1))
			else -- odd
				table.remove(card_table, (card4+1))
				table.remove(card_table, card4)
				table.remove(card_names, (card4+1))
				table.remove(card_names, card4)
				table.remove(card_meanings, (card4+1))
				table.remove(card_meanings, card4)
				table.remove(result_names, (card4+1))
				table.remove(result_names, card4)
				table.remove(card_graphics, (card4+1))
				table.remove(card_graphics, card4)
			end
		elseif (card4 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card4)
			table.remove(card_names, card4)
			table.remove(card_meanings, card4)
			table.remove(result_names, card4)
			table.remove(card_graphics, card4)
		end
	local card5 = math.random(#card_table)
	local card_selected5 = card_table[card5]
	local cardname_5 = card_names[card5]
	local cardmeaning_5 = card_meanings[card5]
	local resultname_5 = result_names[card5]
	local cardgraphic_5 = card_graphics[card5]
		if (card5 >= (17 - shiftVar)) then
			if (card5 % 2 == 0) then -- Even
				table.remove(card_table, card5)
				table.remove(card_table, (card5-1))
				table.remove(card_names, card5)
				table.remove(card_names, (card5-1))
				table.remove(card_meanings, card5)
				table.remove(card_meanings, (card5-1))
				table.remove(result_names, card5)
				table.remove(result_names, (card5-1))
				table.remove(card_graphics, card5)
				table.remove(card_graphics, (card5-1))
			else -- odd
				table.remove(card_table, (card5+1))
				table.remove(card_table, card5)
				table.remove(card_names, (card5+1))
				table.remove(card_names, card5)
				table.remove(card_meanings, (card5+1))
				table.remove(card_meanings, card5)
				table.remove(result_names, (card5+1))
				table.remove(result_names, card5)
				table.remove(card_graphics, (card5+1))
				table.remove(card_graphics, card5)
			end
		elseif (card5 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card5)
			table.remove(card_names, card5)
			table.remove(card_meanings, card5)
			table.remove(result_names, card5)
			table.remove(card_graphics, card5)
		end
	local card6 = math.random(#card_table)
	local card_selected6 = card_table[card6]
	local cardname_6 = card_names[card6]
	local cardmeaning_6 = card_meanings[card6]
	local resultname_6 = result_names[card6]
	local cardgraphic_6 = card_graphics[card6]
		if (card6 >= (17 - shiftVar)) then
			if (card6 % 2 == 0) then -- Even
				table.remove(card_table, card6)
				table.remove(card_table, (card6-1))
				table.remove(card_names, card6)
				table.remove(card_names, (card6-1))
				table.remove(card_meanings, card6)
				table.remove(card_meanings, (card6-1))
				table.remove(result_names, card6)
				table.remove(result_names, (card6-1))
				table.remove(card_graphics, card6)
				table.remove(card_graphics, (card6-1))
			else -- odd
				table.remove(card_table, (card6+1))
				table.remove(card_table, card6)
				table.remove(card_names, (card6+1))
				table.remove(card_names, card6)
				table.remove(card_meanings, (card6+1))
				table.remove(card_meanings, card6)
				table.remove(result_names, (card6+1))
				table.remove(result_names, card6)
				table.remove(card_graphics, (card6+1))
				table.remove(card_graphics, card6)
			end
		elseif (card6 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card6)
			table.remove(card_names, card6)
			table.remove(card_meanings, card6)
			table.remove(result_names, card6)
			table.remove(card_graphics, card6)
		end
	local card7 = math.random(#card_table)
	local card_selected7 = card_table[card7]
	local cardname_7 = card_names[card7]
	local cardmeaning_7 = card_meanings[card7]
	local resultname_7 = result_names[card7]
	local cardgraphic_7 = card_graphics[card7]
		if (card7 >= (17 - shiftVar)) then
			if (card7 % 2 == 0) then -- Even
				table.remove(card_table, card7)
				table.remove(card_table, (card7-1))
				table.remove(card_names, card7)
				table.remove(card_names, (card7-1))
				table.remove(card_meanings, card7)
				table.remove(card_meanings, (card7-1))
				table.remove(result_names, card7)
				table.remove(result_names, (card7-1))
				table.remove(card_graphics, card7)
				table.remove(card_graphics, (card7-1))
			else -- odd
				table.remove(card_table, (card7+1))
				table.remove(card_table, card7)
				table.remove(card_names, (card7+1))
				table.remove(card_names, card7)
				table.remove(card_meanings, (card7+1))
				table.remove(card_meanings, card7)
				table.remove(result_names, (card7+1))
				table.remove(result_names, card7)
				table.remove(card_graphics, (card7+1))
				table.remove(card_graphics, card7)
			end
		elseif (card7 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card7)
			table.remove(card_names, card7)
			table.remove(card_meanings, card7)
			table.remove(result_names, card7)
			table.remove(card_graphics, card7)
		end
	local card8 = math.random(#card_table)
	local card_selected8 = card_table[card8]
	local cardname_8 = card_names[card8]
	local cardmeaning_8 = card_meanings[card8]
	local resultname_8 = result_names[card8]
	local cardgraphic_8 = card_graphics[card8]
		if (card8 >= (17 - shiftVar)) then
			if (card8 % 2 == 0) then -- Even
				table.remove(card_table, card8)
				table.remove(card_table, (card8-1))
				table.remove(card_names, card8)
				table.remove(card_names, (card8-1))
				table.remove(card_meanings, card8)
				table.remove(card_meanings, (card8-1))
				table.remove(result_names, card8)
				table.remove(result_names, (card8-1))
				table.remove(card_graphics, card8)
				table.remove(card_graphics, (card8-1))
			else -- odd
				table.remove(card_table, (card8+1))
				table.remove(card_table, card8)
				table.remove(card_names, (card8+1))
				table.remove(card_names, card8)
				table.remove(card_meanings, (card8+1))
				table.remove(card_meanings, card8)
				table.remove(result_names, (card8+1))
				table.remove(result_names, card8)
				table.remove(card_graphics, (card8+1))
				table.remove(card_graphics, card8)
			end
		elseif (card8 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card8)
			table.remove(card_names, card8)
			table.remove(card_meanings, card8)
			table.remove(result_names, card8)
			table.remove(card_graphics, card8)
		end
	local card9 = math.random(#card_table)
	local card_selected9 = card_table[card9]
	local cardname_9 = card_names[card9]
	local cardmeaning_9 = card_meanings[card9]
	local resultname_9 = result_names[card9]
	local cardgraphic_9 = card_graphics[card9]
		if (card9 >= (17 - shiftVar)) then
			if (card9 % 2 == 0) then -- Even
				table.remove(card_table, (card9-1))
				table.remove(card_table, card9)
				table.remove(card_names, (card9-1))
				table.remove(card_names, card9)
				table.remove(card_meanings, (card9-1))
				table.remove(card_meanings, card9)
				table.remove(result_names, (card9-1))
				table.remove(result_names, card9)
				table.remove(card_graphics, (card9-1))
				table.remove(card_graphics, card9)
			else -- odd
				table.remove(card_table, (card9+1))
				table.remove(card_table, card9)
				table.remove(card_names, (card9+1))
				table.remove(card_names, card9)
				table.remove(card_meanings, (card9+1))
				table.remove(card_meanings, card9)
				table.remove(result_names, card9)
				table.remove(result_names, (card9+1))
				table.remove(card_graphics, card9)
				table.remove(card_graphics, (card9+1))
			end
		elseif (card9 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card9)
			table.remove(card_names, card9)
			table.remove(card_meanings, card9)
			table.remove(result_names, card9)
			table.remove(card_graphics, card9)
		end
	local card10 = math.random(#card_table)
	local card_selected10 = card_table[card10]
	local cardname_10 = card_names[card10]
	local cardmeaning_10 = card_meanings[card10]
	local resultname_10 = result_names[card10]
	local cardgraphic_10 = card_graphics[card10]
		if (card10 >= (17 - shiftVar)) then
			if (card10 % 2 == 0) then -- Even
				table.remove(card_table, card10)
				table.remove(card_table, (card10-1))
				table.remove(card_names, card10)
				table.remove(card_names, (card10-1))
				table.remove(card_meanings, card10)
				table.remove(card_meanings, (card10-1))
				table.remove(result_names, card10)
				table.remove(result_names, (card10-1))
				table.remove(card_graphics, card10)
				table.remove(card_graphics, (card10-1))
			else -- odd
				table.remove(card_table, (card10+1))
				table.remove(card_table, card10)
				table.remove(card_names, (card10+1))
				table.remove(card_names, card10)
				table.remove(card_meanings, (card10+1))
				table.remove(card_meanings, card10)
				table.remove(result_names, (card10+1))
				table.remove(result_names, card10)
				table.remove(card_graphics, (card10+1))
				table.remove(card_graphics, card10)
			end
		elseif (card10 <= (16 - shiftVar)) then
			shiftVar = shiftVar + 1
			table.remove(card_table, card10)
			table.remove(card_names, card10)
			table.remove(card_meanings, card10)
			table.remove(result_names, card10)
			table.remove(card_graphics, card10)
		end
-- MENU OPTIONS / TIMERS / MAIL / READINGS / MISC.
-- MENU OPTIONS
	local choiceOpts = {}
		table.insert(choiceOpts, "Daily Reading")
 		table.insert(choiceOpts, "Spread: 3-Cards")
		table.insert(choiceOpts, "Spread: 10-Cards")
-- TIMERS
	local Spread10Timer = 2592000 -- 30 Days IRL
	local Spread3Timer = 604800   -- 7 Days IRL
	local Spread1Timer = 86400    -- 1 Day IRL
-- MAIL
	local Reading1Time = "              ~ Reading preformed at "..realHour()..":"..realMinute().." (EST) ~\n              ------------------------------------"
	local Reading1Results = "\n"..Reading1Time.."\n\n<b>o. Daily Tarot: "..cardname_1.."\n"..cardmeaning_1..""
	local Reading3Time = "              ~ Reading preformed at "..realHour()..":"..realMinute().." (EST) ~\n              ------------------------------------"
	local Reading3Results = "\n"..Reading3Time.."\n\n<b>o. Past Influences: "..cardname_1.."\n"..cardmeaning_1.."\n\n<b>o. Current Situation: "..cardname_2.."\n"..cardmeaning_2.."\n\n<b>o. Future Outlook: "..cardname_3.."\n"..cardmeaning_3..""
	local Reading10Time = "              ~ Reading preformed at "..realHour()..":"..realMinute().." (EST) ~\n              ------------------------------------"
	local Reading10Results = "\n"..Reading10Time.."\n\n<b>o. Present Position: "..cardname_1.."\n"..cardmeaning_1.."\n\n<b>o. Immediate Influence: "..cardname_2.."\n"..cardmeaning_2.."\n\n<b>o. Goal/Destiny: "..cardname_3.."\n"..cardmeaning_3.."\n\n<b>o. Distant Past: "..cardname_4.."\n"..cardmeaning_4.."\n\n<b>o. Recent Past Events: "..cardname_5.."\n"..cardmeaning_5.."\n\n<b>o. Future Influence: "..cardname_6.."\n"..cardmeaning_6.."\n\n<b>o. The Questioner: "..cardname_7.."\n"..cardmeaning_7.."\n\n<b>o. Environmental Factors: "..cardname_8.."\n"..cardmeaning_8.."\n\n<b>o. Inner Emotions: "..cardname_9.."\n"..cardmeaning_9.."\n\n<b>o. Final Results: "..cardname_10.."\n"..cardmeaning_10..""
-- TAROT READINGS
	local Reading1 = "[Tarot Results]: Daily Tarot Reading"
	local Reading3 = "[Tarot Results]: 3-Card Spread"
	local Reading10 = "[Tarot Results]: 10-Card Spread"
-- MISC.
	local Empress = {graphic = 0, color = 0}


	-- :: ABILITIES

	local choice = player:menuString3("What type of reading would you like?", choiceOpts)


	-------- DAILY READING
		if (choice == "Daily Reading") then
				local decision = player:menuString3("Are you ready to proceed?", {"Yes", "No"})
					if (decision == "Yes") then
						if (player.registry["TarotSingle"] >= os.time()) then
							player:dialogSeq({Seer, "You will need to wait roughly "..(math.ceil((player.registry["TarotSingle"] - os.time())/10800)).." more day(s) before you can receive another reading."}, 1)

						elseif (player.registry["TarotSingle"] <= os.time()) then
							player.registry["TarotSingle"] = os.time() + Spread1Timer
							player:removeItem("seer_tarotcard", 1)
							player:sendMail(""..player.name.."", ""..Reading1.."", ""..Reading1Results.."")
							player:dialogSeq({Seer, "Before we begin pulling cards, I want you to contemplate on your existence. Focus solely on yourself..",
							Seer, "Let your mind clear..\n\n\n\n*begins to shuffle cards*"},1 )
								if (card1 == 8 or card1 == 9 ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_1, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
								end

						end

					elseif (decision == "No") then
						player:dialogSeq({Seer, "Oh well, that is too bad. Maybe another time then?"}, 1)
					end

	-------- 3-CARD READING
		elseif (choice == "Spread: 3-Cards") then
				local decision = player:menuString3("Are you ready to proceed?", {"Yes", "No"})
					if (decision == "Yes") then
						if (player.registry["TarotThree"] >= os.time()) then
							player:dialogSeq({Seer, "You will need to wait roughly "..(math.ceil((player.registry["TarotThree"] - os.time())/10800)).." more day(s) before you can receive another 3-Card reading."}, 1)
							return

						elseif (player.registry["TarotThree"] <= os.time()) then
							player.registry["TarotThree"] = os.time() + Spread3Timer
							player:removeItem("seer_tarotcard", 1)
							player:sendMail(""..player.name.."", ""..Reading3.."", ""..Reading3Results.."")
							player:dialogSeq({Seer, "Before we begin pulling cards, I want you to contemplate on your existence. Focus solely on yourself..",
							Seer, "Let your mind clear..\n\n\n\n*begins to shuffle cards*",
							Seer, "Past Influences.."}, 1)
								if (card1 == 8 or card1 == 9 ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_1, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
								end
							player:dialogSeq({Seer, "Current Situation.."}, 1)
								if (card2 == 8 or card2 == 9 ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_2.."\n\n"..cardmeaning_2..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_2, ""..cardname_2.."\n\n"..cardmeaning_2..""}, 1)
								end
							player:dialogSeq({Seer, "Future Outlook.."}, 1)
								if (card3 == 8 or card3 == 9 ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_3.."\n\n"..cardmeaning_3..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_3, ""..cardname_3.."\n\n"..cardmeaning_3..""}, 1)
								end

						end

					elseif (decision == "No") then
						player:dialogSeq({Seer, "Oh well, that is too bad. Maybe another time then?"}, 1)
					end

	-------- 10-CARD READING
		elseif (choice == "Spread: 10-Cards") then
				local decision = player:menuString3("Are you ready to proceed?", {"Yes", "No"})
					if (decision == "Yes") then
						if (player.registry["TarotTen"] >= os.time()) then
							player:dialogSeq({Seer, "You will need to wait roughly "..(math.ceil((player.registry["TarotTen"] - os.time())/10800)).." more day(s) before you can receive another 10-Card reading."}, 1)

						elseif (player.registry["TarotTen"] <= os.time()) then
							local finalcard_10 = result_names
							player.registry["TarotTen"] = os.time() + Spread10Timer
							player:removeItem("seer_tarotcard", 1)
							player:sendMail(""..player.name.."", ""..Reading10.."", ""..Reading10Results.."")
							player:dialogSeq({Seer, "Before we begin pulling cards, I want you to contemplate on your existence. Focus solely on yourself..", 
							Seer, "Let your mind clear..\n\n\n\n*begins to shuffle cards*",
							Seer, "          ..Present Position\n\nThis card reveals the atmosphere in which you are currently working/living in."}, 1)
								if (cardname_1 == "The Empress") or (cardname_1 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_1, ""..cardname_1.."\n\n"..cardmeaning_1..""}, 1)
								end
							player:dialogSeq({Seer, "       ..Immediate Influence\n\nThis card reveals the nature of the influence/obstacles which lie ahead."}, 1)
								if (cardname_2 == "The Empress") or (cardname_2 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_2.."\n\n"..cardmeaning_2..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_2, ""..cardname_2.."\n\n"..cardmeaning_2..""}, 1)
								end
							player:dialogSeq({Seer, "              ..Goal/Destiny\n\nThis card reveals your destiny/goal. It indicates the best that can be accomplished, given your existing circumstances."}, 1)
								if (cardname_3 == "The Empress") or (cardname_3 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_3.."\n\n"..cardmeaning_3..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_3, ""..cardname_3.."\n\n"..cardmeaning_3..""}, 1)
								end
							player:dialogSeq({Seer, "              ..Distant Past\n\nThis card reveals major events and influences which existed in the past, and upon which present events are based."}, 1)
								if (cardname_4 == "The Empress") or (cardname_4 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_4.."\n\n"..cardmeaning_4..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_4, ""..cardname_4.."\n\n"..cardmeaning_4..""}, 1)
								end
							player:dialogSeq({Seer, "        ..Recent Past Events\n\nThis card reveals recent events that have influenced the present situation."}, 1)
								if (cardname_5 == "The Empress") or (cardname_5 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_5.."\n\n"..cardmeaning_5..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_5, ""..cardname_5.."\n\n"..cardmeaning_5..""}, 1)
								end
							player:dialogSeq({Seer, "          ..Future Influence\n\nThis card reveals the sphere of influence that will come into being, in the near future."}, 1)
								if (cardname_6 == "The Empress") or (cardname_6 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_6.."\n\n"..cardmeaning_6..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_6, ""..cardname_6.."\n\n"..cardmeaning_6..""}, 1)
								end
							player:dialogSeq({Seer, "            ..The Questioner\n\nThis card reveals your present position/attitude."}, 1)
								if (cardname_7 == "The Empress") or (cardname_7 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_7.."\n\n"..cardmeaning_7..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_7, ""..cardname_7.."\n\n"..cardmeaning_7..""}, 1)
								end
							player:dialogSeq({Seer, "     ..Environmental Factors\n\nThis card reveals your influence on other people and events. It shows the tendencies and factors, with respect to other people, which may have an effect on yourself."}, 1)
								if (cardname_8 == "The Empress") or (cardname_8 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_8.."\n\n"..cardmeaning_8..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_8, ""..cardname_8.."\n\n"..cardmeaning_8..""}, 1)
								end
							player:dialogSeq({Seer, "            ..Inner Emotions\n\nThis card reveals your; inner hopes, hidden emotions, secret desires, fears, anxieties, and future thoughts."}, 1)
								if (cardname_9 == "The Empress") or (cardname_9 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_9.."\n\n"..cardmeaning_9..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_9, ""..cardname_9.."\n\n"..cardmeaning_9..""}, 1)
								end
							player:dialogSeq({Seer, "             ..Final Results\n\nThis card reveals the results of all the influences, as revealed by the reading. Provided events and influences continue as indicated."}, 1)
								if (cardname_10 == "The Empress") or (cardname_10 == "The Empress (R)" ) then
									player.lastClick = NPC(126).ID
									player:dialogSeq({Empress, ""..cardname_10.."\n\n"..cardmeaning_10..""}, 1)
									player.lastClick = NPC(127).ID
								else
									player:dialogSeq({cardgraphic_10, ""..cardname_10.."\n\n"..cardmeaning_10..""}, 1)
								end	
							player:removeLegendbyName("tarotProphecy")
							player:addLegend("Has been given the Fate of '"..resultname_10.."'. "..curT(), "tarotProphecy", 98, 68)

						end

					elseif (decision == "No") then
						player:dialogSeq({Seer, "Oh well, that is too bad. Maybe another time then?"}, 1)
					end

		end	
end),

}