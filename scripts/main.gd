extends Node

@onready var channel: Channel = Channel.new("lorem/hello/aa")

func _ready() -> void:
	#FirebaseLite.RealtimeDatabase.write("lorem/hello/aa", {"bb":32})
	
	%StatusLabel.text = "Authenticating..."
	#var data: Dictionary = await FirebaseLite.Authentication.initializeAuth(1)
	#if data and data.has("localId"):
	#	%StatusLabel.text = "Uid: " + data.localId + "\nUsername: " + UsernameService.generate_username(data.localId)
	


func _on_button_pressed() -> void:
	channel.set_data({"hello": randi() % 256})
