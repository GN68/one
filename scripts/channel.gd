extends Resource
class_name Channel


signal data_updated(data)
signal data_recived(data)

var _cancel_update = false # used to avoid causing an infinite loop when setting the data
var _read_path : String # a cache of the key for identifying this channel on a ref update
@export var ref_path : String = "" : set = set_ref_path
func set_ref_path(value: String):
	if ref_path == "":
		ref_path = value
		_read_path = ref_path.replace("/", "_").replace(".", "_").replace(":", "_").replace("@", "_").replace('"', "_").replace("@", "_")

@export var data : Variant = {} : set = _set_local_data
func _set_local_data(value: Variant):
	if hash(data) != hash(value):
		data = value.data
		data_updated.emit(data)
		
		if !_cancel_update:
			data_recived.emit(data)
	_cancel_update = false


# sets the data in the server, assuming you have permission for the given ref_path. if not, this channel is read only
func set_data(value: Variant):
	_cancel_update = true
	await FirebaseLite.RealtimeDatabase.write(ref_path, {"data": value})


func _init(channel_path: String, initial_data: Variant = null) -> void:
	set_ref_path(channel_path)
	if initial_data: _set_local_data({data=initial_data})
	ChannelMaster.register_channel(self, initial_data == null)


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		ChannelMaster.unregister_channel(_read_path)
