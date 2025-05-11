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

func _ready() -> void:
	FirebaseLite.initialize(firebaseConfig)
	FirebaseLite.terminate("Storage")
	
	FirebaseLite.RealtimeDatabase.refUpdated.connect(on_ref_updated)
	FirebaseLite.RealtimeDatabase.refDeleted.connect(on_ref_deleted)
	FirebaseLite.RealtimeDatabase.listen("bb")
	
	FirebaseLite.RealtimeDatabase.write("lorem", {"hello":{"aa":{"bb":3}}})
	
	%StatusLabel.text = "Authenticating..."
	var data: Dictionary = await FirebaseLite.Authentication.initializeAuth(1)
	print(data)
	if data and data.has("localId"):
		%StatusLabel.text = "Uid: " + data.localId + "\nUsername: " + UsernameService.generate_username(data.localId)


func on_ref_updated(data):
	print("+",data)
	
func on_ref_deleted(data):
	print("-",data)

func _on_button_pressed() -> void:
	FirebaseLite.RealtimeDatabase.write("bb", {"hello": str(randf())})
