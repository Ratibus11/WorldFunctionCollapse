class_name HorizontalTile
extends Tile

const TEXTURE_PATH: String = "res://assets/sprites/tiles/straight_h.png"

func _init() -> void:
	__CAN_CONNECT_TOP = false
	__CAN_CONNECT_BOTTOM = false
	__CAN_CONNECT_LEFT = true
	__CAN_CONNECT_RIGHT = true
	__TYPE = "HorizontalTile"

func _ready() -> void:	
	_loadTexture(TEXTURE_PATH)

func _process(delta: float) -> void:
	pass
