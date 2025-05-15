extends Node

@export var text: Channel = Channel.new("test")

func _ready() -> void:
	text.data_updated.connect(_on_text_updated)

func _on_text_updated(data) -> void:
	$PaddingContainer/VBoxContainer/Label.text = data

func _on_line_edit_text_submitted(new_text:String) -> void:
	text.set_data(new_text)
