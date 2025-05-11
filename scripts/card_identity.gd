extends Resource
class_name CardIdentity

@export var name : String
@export var texture : Texture
@export var tags : Array[String] # Used to identify what cards are compatible
@export_multiline var description : String
@export var special : PackedScene # Gets added to the card node