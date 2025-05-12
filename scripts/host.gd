extends Node

var gamerules = [
	{name = "Draw Card Stacking",tooltip = "Allow draw cards to accumulate to the last player"},
	{name = "Extra Move on Draw",tooltip = "Gives players an extra move upon drawing a card"},
	{name = "Last Man",tooltip = "Makes the game end only when one player is left not empty handed, compared to the usual first player wins and the game ends"},
	{name = "Same Number Batching",tooltip = "allow cards of the same number AND color to be dropped all at once"},
	{name = "Jump In", tooltip = "If you have exactly the same card (same color and number/symbol) as the one on top of the discard pile, you can \"jump in\" and play it immediately"},
	{name = "Copycat", tooltip = ""}
]

var cardsets = [
	preload("res://resources/cardsets/blues.tres"),
	preload("res://resources/cardsets/greens.tres"),
	preload("res://resources/cardsets/reds.tres"),
	preload("res://resources/cardsets/wilds.tres"),
	preload("res://resources/cardsets/yellows.tres"),
]

func _ready() -> void:
	
	for gamerule in gamerules:
		var option = CheckBox.new()
		option.text = gamerule.name
		option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		option.tooltip_text = gamerule.tooltip
		%Gamerules.add_child(option)
	
	for cardset in cardsets:
		var option = CheckBox.new()
		option.text = cardset.name
		option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		option.tooltip_text = cardset.description
		%Cardsets.add_child(option)