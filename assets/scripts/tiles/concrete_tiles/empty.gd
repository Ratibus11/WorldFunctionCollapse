class_name EmptyTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/empty.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = false
	__CAN_CONNECT_LEFT = false
	__CAN_CONNECT_RIGHT = false
	__TYPE = "EmptyTile"

func _ready() -> void:
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
