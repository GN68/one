extends Node
class_name Channel


signal data_updated(data)
signal data_recived(data)

var _cancel_update = false # used to avoid causing an infinite loop when setting the data
var _read_path : String # a cache of the key for identifying this channel on a ref update
@export var path : String = "" : set = set_path
func set_path(value: String):
	if path == "":
		path = value
		_read_path = path.replace("/", "_").replace(".", "_").replace(":", "_").replace("@", "_").replace('"', "_").replace("@", "_")
@export var data : Dictionary = {} : set = set_local_data
func set_local_data(value: Dictionary):
	if hash(data) != hash(value):
		data = value
		data_updated.emit(data)
		
		if !_cancel_update:
			data_recived.emit(data)
	_cancel_update = false

func set_data(value: Dictionary):
	_cancel_update = true
	FirebaseLite.RealtimeDatabase.write(path, value)

func _ready() -> void:
	ChannelMaster.register_channel(self)


func _init(channel_path: String) -> void:
	set_path(channel_path)
	ChannelMaster.add_child(self)
