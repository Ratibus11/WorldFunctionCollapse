class_name TLeftTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/t_l.png"

func _init() -> void:
	__CAN_CONNECT_TOP = true
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = false
	__TYPE = "TLeftTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
