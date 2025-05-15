@tool
extends Button
class_name RoomButton

@export var room_id: String
@export var room_name: String : set = set_room_name
@export var players: int = 0 : set = set_players
@export var joinable: bool : set = set_joinable

signal double_clicked

func set_room_name(value: String) -> void:
	room_name = value
	if !is_node_ready(): await ready
	$Control/HBoxContainer/NameLabel.text = value + "'s Room"

func set_players(value: int) -> void:
	players = value
	if !is_node_ready(): await ready
	$Control/HBoxContainer/CountLabel.text = str(value,"/4")

func set_joinable(value: bool) -> void:
	disabled = !value
	joinable = value
	if !is_node_ready(): await ready
	$Control/HBoxContainer/StatusLabel.text = "Closed" if !value else "Open"


var _last_click_time = 0
func _on_pressed() -> void:
	var current_time = Time.get_ticks_msec()
	if current_time - _last_click_time < 300:
		double_clicked.emit()
	_last_click_time = current_time
	
