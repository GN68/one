extends Node

@onready var channel: Channel = Channel.new("lorem/hello/aa")

func _ready() -> void:
	#FirebaseLite.RealtimeDatabase.write("lorem/hello/aa", {"bb":32})
	
	%StatusLabel.text = "Authenticating..."
	
	Player.logged_in.connect(_on_player_logged_in)

func _on_player_logged_in() -> void:
	%StatusLabel.text = "Uid: " + Player.identity.Uid + "\nUsername: " + UsernameService.generate_username(Player.identity.Uid)

func _on_host_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/host/host.tscn")


func _on_join_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/lobby/lobby.tscn")
