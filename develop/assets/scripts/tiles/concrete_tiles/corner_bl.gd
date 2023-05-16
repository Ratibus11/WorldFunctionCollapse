class_name CornerBottomLeftTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/corner_bl.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = false
	__TYPE = "CornerBottomLeftTile"

func _ready() -> void:	
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
