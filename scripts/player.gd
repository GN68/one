extends Node

@export var identity: PlayerIdentity

var _logged_in: bool = false
signal logged_in

func _ready() -> void:
	if !ChannelMaster.is_firebase_initialized(): await ChannelMaster.firebase_initialized
	
	var data: Dictionary = await FirebaseLite.Authentication.initializeAuth(1)
	if data and data.has("localId"):
		identity = PlayerIdentity.new(data["localId"],true)
		_logged_in = true
		logged_in.emit()

func is_logged_in() -> bool:
	return _logged_in
