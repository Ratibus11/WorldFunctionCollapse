class_name CornerTopLeftTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/corner_tl.png"

func _init() -> void:
	__CAN_CONNECT_TOP = true
	__CAN_CONNECT_BOTTOM = false
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = false
	__TYPE = "CornerTopLeftTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
