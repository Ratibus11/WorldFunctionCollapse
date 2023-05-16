class_name TRightTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/t_r.png"

func _init() -> void:
	__CAN_CONNECT_TOP = true
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = false
	__CAN_CONNECT_RIGHT = true
	__TYPE = "TRightTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
