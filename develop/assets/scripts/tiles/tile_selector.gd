extends TextureRect
class_name TileSelector

const TEXTURE_PATH: String = "res://assets/sprites/tiles/selector.png"

func _ready():
	texture = load(TEXTURE_PATH)

func _process(delta):
	pass
