extends Node2D

const LOAD_TILE_GRID = true;
const LOAD_VORONOI = true;
const GRID_SIZE = 31

# =====

const TILE_SIZE = 30;

func __initWindow():
	var SIZE = GRID_SIZE * TILE_SIZE
	DisplayServer.window_set_size(Vector2i(SIZE, SIZE))

func _ready():
	__initWindow()
	
	if LOAD_VORONOI:
		var voronoiScene = load("res://assets/scenes/voronoi/voronoi.tscn").instantiate()
		add_child(voronoiScene)
		
	if LOAD_TILE_GRID:
		var tileGridScene = load("res://assets/scenes/tile_grid/tile_grid.tscn").instantiate()
		add_child(tileGridScene)


func _process(delta):
	pass
