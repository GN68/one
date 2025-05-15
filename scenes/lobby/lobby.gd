extends Node

@onready var room_button = preload("res://scenes/lobby/room_button.tscn")

func _ready() -> void:
	ChannelDictionary.new("rooms").data_updated.connect(_on_rooms_updated)

func _on_rooms_updated(rooms: Dictionary) -> void:
	for room_name in rooms.keys():
		var room: Dictionary = rooms[room_name]
		
		var button: RoomButton = room_button.instantiate()
		button.room_id = room.adminUid
		button.room_name = room_name
		if room.has("players"):
			button.players = room.players.size()
		else:
			button.players = 0
		
		button.joinable = room.joinable
		$PaddingContainer/VBoxContainer/ScrollContainer/List.add_child(button)


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
