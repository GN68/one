@tool
extends Resource
class_name PlayerIdentity

@export var Uid: String : set = _set_Uid
@export var is_host: bool
@export var username: String

func _init(uid: String, host: bool) -> void:
	self.is_host = host
	self.Uid = uid


func _set_Uid(value):
	Uid = value
	username = UsernameService.generate_username(value)