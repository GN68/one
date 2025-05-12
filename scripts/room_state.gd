extends Resource
class_name RoomState
## Acts as the data for the current state of a room, only public data is available

@export var joinable: bool = true
@export var players: Array[PlayerIdentity] = []

@export var turn: int = 0