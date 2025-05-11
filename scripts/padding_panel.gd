@tool
extends Container
class_name PaddingContainer

@export var max_children_width : float = 50 : set = set_max_children_width

func _ready() -> void:
	sort_children.connect(_on_sort_children)


func set_max_children_width(value : float):
	max_children_width = value
	_on_sort_children()


func _on_sort_children():
	for child in get_children():
		if child is Control:
			child.position.x = (size.x - max_children_width * 16) * 0.5
			child.position.y = 0
			
			child.grow_horizontal = Control.GROW_DIRECTION_BOTH
			child.grow_vertical = Control.GROW_DIRECTION_BOTH
			
			child.size.x = min(size.x, max_children_width * 16)
			child.size.y = size.y