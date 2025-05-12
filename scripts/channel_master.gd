extends Node


const firebaseConfig = {
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


func _ready() -> void:
	FirebaseLite.initialize(firebaseConfig)
	FirebaseLite.terminate("Storage")
	
	FirebaseLite.RealtimeDatabase.refUpdated.connect(_on_ref_update)
	FirebaseLite.RealtimeDatabase.refDeleted.connect(_on_ref_delete)


func register_channel(channel: Channel):
	channels[channel._read_path] = channel
	FirebaseLite.RealtimeDatabase.listen(channel.path)


func unregister_channel(channel: Channel):
	channels[channel._read_path] = null
	FirebaseLite.RealtimeDatabase.disconnectRef(channel.path)


func _on_ref_update(data):
	if channels[data.key]:
		channels[data.key].set_local_data(data.data)
	print("ref updated: ", data)


func _on_ref_delete(ref):
	print("ref deleted: ", ref)
