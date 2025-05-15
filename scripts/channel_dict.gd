extends Channel
class_name ChannelDictionary
# The same as channel but can only be a dictionary

func _set_local_data(value: Variant):
	if hash(data) != hash(value):
		data = value
		data_updated.emit(data)
		
		if !_cancel_update:
			data_recived.emit(data)
	_cancel_update = false


# sets the data in the server, assuming you have permission for the given ref_path. if not, this channel is read only
func set_data(value: Variant):
	_cancel_update = true
	FirebaseLite.RealtimeDatabase.write(ref_path, value)