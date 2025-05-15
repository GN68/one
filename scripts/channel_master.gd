extends Node


const config = {
  "apiKey": "AIzaSyAVaCp87D95ATpzg6Dy5eZPgbfmKd_SuRE",
  "authDomain": "gn68s-web-one.firebaseapp.com",
  "databaseURL": "https://gn68s-web-one-default-rtdb.asia-southeast1.firebasedatabase.app",
  "projectId": "gn68s-web-one",
  "storageBucket": "gn68s-web-one.firebasestorage.app",
  "messagingSenderId": "989426630908",
  "appId": "1:989426630908:web:d71b99fc945b2d7c029779",
  "measurementId": "G-PHCJR8M2YJ"
}


var channels: Dictionary[String, Channel]
var is_initialized = false
signal firebase_initialized

func _ready() -> void:
	FirebaseLite.initialize(config)
	FirebaseLite.terminate("Storage")
	
	FirebaseLite.RealtimeDatabase.refUpdated.connect(_on_ref_update)
	FirebaseLite.RealtimeDatabase.refDeleted.connect(_on_ref_delete)
	firebase_initialized.emit()


func register_channel(channel: Channel, request_initial_data: bool = true):
	if !is_node_ready(): await ready
	channels[channel._read_path] = channel
	FirebaseLite.RealtimeDatabase.listen(channel._read_path)
	if request_initial_data:
		var initial_data = await FirebaseLite.RealtimeDatabase.read(channel._read_path)
		if initial_data == null:
			print("Warning: No initial data for ", channel._read_path)
		else:
			channel._set_local_data(initial_data)

func unregister_channel(read_path: String):
	channels[read_path] = null
	FirebaseLite.RealtimeDatabase.disconnectRef(read_path)


func _on_ref_update(updated):
	if channels[updated.key]:
		channels[updated.key]._set_local_data(updated.data)
	print("ref updated: ", updated)


func _on_ref_delete(ref):
	print("ref deleted: ", ref)


func is_firebase_initialized() -> bool:
	return is_initialized
