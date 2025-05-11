extends Node

var gamerules = [
	{name = "Draw Card Stacking",tooltip = "Allow draw cards to accumulate to the last player"},
	{name = "Extra Move on Draw",tooltip = "Gives a player an extra move when the player chose to draw a card"},
	{name = "Last Man",tooltip = "Makes the game end only when one player is left not empty handed, compared to the usual first player wins and the game ends"},
	{name = "Same Number Batching",tooltip = "allow cards of the same number AND color to be dropped all at once"},
	{name = "Jump In", tooltip = "If you have exactly the same card (same color and number/symbol) as the one on top of the discard pile, you can \"jump in\" and play it immediately"},
	{name = "Copycat", tooltip = ""}
]

var cardsets = []