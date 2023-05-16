class_name CornerBottomRightTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/corner_br.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = false
	__CAN_CONNECT_RIGHT = true
	__TYPE = "CornerBottomRightTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
