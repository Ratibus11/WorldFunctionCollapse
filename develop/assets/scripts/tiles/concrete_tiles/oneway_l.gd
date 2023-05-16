class_name OnewayLeftTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/oneway_l.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = false
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = false
	__TYPE = "OnewayLeftTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
