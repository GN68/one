@tool
extends Node3D
class_name UnoCard

@export var card_identity: CardIdentity : set = set_card_identity

@onready var _card_material = preload("res://resources/materials/card.tres")

func set_card_identity(value: CardIdentity):
	card_identity = value
	var material: StandardMaterial3D = _card_material.duplicate()
	if value:
		material.albedo_texture = card_identity.texture
	$MeshFront.mesh.surface_set_material(0, material)
