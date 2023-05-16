class_name TBottomTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/t_b.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = true
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = true
	__TYPE = "TBottomTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
