class_name OnewayBottomTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/oneway_b.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = false
	__CAN_CONNECT_RIGHT = false
	__TYPE = "OnewayBottomTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
