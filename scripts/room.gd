extends Resource
class_name Room
## Acts as the data for the current state of a room, only public data is available

# Rules.json
# {
# 	"rules": {
# 		".read": true,
# 		".write": true,
# 
# 		// Playerlist
# 		"userRooms": {
# 			"$userUid": {
# 				// Users can write only if:
# 				// - They are authenticated and writing their own userUid
# 				// - Joining: entry doesn't exist yet and new data is a string
# 				// - Leaving: entry exists, new data is null, and the room no longer exists
# 				".write": "auth != null   &&   auth.uid == $userUid   &&   ( (!data.exists()   &&   newData.isString()) || (data.exists()   &&   !newData.exists()   &&   !root.child('rooms').child(data.val()).exists()) )",
# 
# 				// Users can only read their own userRooms entry
# 				".read": "auth != null && auth.uid == $userUid"
# 			}
# 		},
# 
# 		"rooms": {
# 			"$roomId": {
# 				// Allow only the admin to write at room root level
# 				".write": "auth != null && root.child('rooms').child($roomId).child('adminUid').val() == auth.uid",
# 				".read": "auth != null",
# 
# 				"joinable": {
# 					".write": "auth != null && auth.uid == root.child('rooms').child($roomId).child('adminUid').val()",
# 					".validate": "newData.isBoolean()"
# 				},
# 
# 				// Admin UID field (set once)
# 				"adminUid": {
# 					".validate": "!data.exists() && newData.isString()"
# 				},
# 
# 				// Game State (only admin can write)
# 				"gameState": {
# 					".write": "auth != null && root.child('rooms').child($roomId).child('adminUid').val() == auth.uid",
# 					".read": "auth != null"
# 				},
# 
# 				"players": {
# 					"$playerUid": {
# 						// Allow joining only if room is joinable
# 						// And user is not already in another room
# 						".write": "auth != null   &&   auth.uid == $playerUid   &&   root.child('rooms').child($roomId).child('joinable').val() == true   &&   !root.child('userRooms').child(auth.uid).exists()",
# 						".read": "auth != null",
# 
# 						"data": {
# 							".validate": "newData.isString() && newData.val().length <= 200"
# 						}
# 					}
# 				}
# 			}
# 		}
# 	}
# }


@export var joinable: Channel
@export var players: Channel
var _is_remote = true

var room_id = ""

func _init(player: PlayerIdentity = Player.identity) -> void:
	room_id = player.username
	
	var room_check = await FirebaseLite.RealtimeDatabase.read("rooms/"+room_id)
	if room_check == null or room_check.data == "": # room dosent exist, create new.
		_is_remote = false
		await FirebaseLite.RealtimeDatabase.write("rooms/"+room_id, {
			"joinable": true,
			"adminUid": Player.identity.Uid,
			"gameState": {
				
			},
			"players":{}
		})
	
	# sync data
	joinable = Channel.new("rooms/"+room_id+"/joinable",true)
	players = Channel.new("rooms/"+room_id+"/players",{})

func is_remote() -> bool:
	return _is_remote

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		await FirebaseLite.RealtimeDatabase.write("rooms/"+room_id, {})
