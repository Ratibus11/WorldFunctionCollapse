class_name TileGrid
extends TileMap

const SCENE_PATH: String = "res://assets/scene/tile_grid/tile_grid.tscn"
var SELECTOR = TileSelector.new()
enum CONCRETE_TILE {
	CORNER_BOTTOM_LEFT,
	CORNER_BOTTOM_RIGHT,
	CORNER_TOP_LEFT,
	CORNER_TOP_RIGHT,
	CROSS,
	EMPTY,
	ONEWAY_BOTTOM,
	ONEWAY_LEFT,
	ONEWAY_RIGHT,
	ONEWAY_TOP,
	HORIZONTAL,
	VERTICAL,
	T_BOTTOM,
	T_LEFT,
	T_RIGHT,
	T_TOP,
	COUNT
}

var tiles: Array[Tile] = []
const TILE_SIZE = 30

func place_tile(tile: Tile, tile_coordinates: Vector2) -> void:
	Check.isInt(tile_coordinates.x)
	Check.isInt(tile_coordinates.y)
	
	tile.position.x = tile_coordinates.x * TILE_SIZE
	tile.position.y = tile_coordinates.y * TILE_SIZE
	
	add_child(tile)
	tiles.append(tile)

func _input(event: InputEvent) -> void:
	var TILE_COORDINATES = __getTileCoordinatesFromClick(event.position)
	
	if event is InputEventMouseButton:
		if event.pressed == true:
			if not __isTileOccupied(TILE_COORDINATES):
				var possible_tiles = __getPossibleTiles(TILE_COORDINATES)
				place_tile(__getRandomTile(possible_tiles), TILE_COORDINATES)
				
	elif event is InputEventMouseMotion:
		if not __isTileOccupied(TILE_COORDINATES):
			var COORDINATES = Vector2(TILE_COORDINATES.x * TILE_SIZE, TILE_COORDINATES.y * TILE_SIZE)
			SELECTOR.set_position(COORDINATES)
			SELECTOR.show()
		else:
			SELECTOR.hide()

func __getPossibleTiles(new_tile_coordinates: Vector2):
	var TOP_NEIGHBOR_COORDINATES = Vector2(new_tile_coordinates.x, new_tile_coordinates.y - 1)
	var BOTTOM_NEIGHBOR_COORDINATES = Vector2(new_tile_coordinates.x, new_tile_coordinates.y + 1)
	var LEFT_NEIGHBOR_COORDINATES = Vector2(new_tile_coordinates.x - 1, new_tile_coordinates.y)
	var RIGHT_NEIGHBOR_COORDINATES = Vector2(new_tile_coordinates.x + 1, new_tile_coordinates.y)
	
	var TOP_NEIGHBOR = __getTile(TOP_NEIGHBOR_COORDINATES)
	var BOTTOM_NEIGHBOR = __getTile(BOTTOM_NEIGHBOR_COORDINATES)
	var LEFT_NEIGHBOR = __getTile(LEFT_NEIGHBOR_COORDINATES)
	var RIGHT_NEIGHBOR = __getTile(RIGHT_NEIGHBOR_COORDINATES)

	var possible_tiles: Array[Tile] = __getConcreteTiles().duplicate()
	var canNeighborConnect: bool
	
	if (TOP_NEIGHBOR):
		canNeighborConnect = TOP_NEIGHBOR.canConnectBottom()
		possible_tiles = possible_tiles.filter(func(pt: Tile): return pt.canConnectTop() if canNeighborConnect else not pt.canConnectTop())
	
	if (BOTTOM_NEIGHBOR):
		canNeighborConnect = BOTTOM_NEIGHBOR.canConnectTop()
		possible_tiles = possible_tiles.filter(func(pt: Tile): return pt.canConnectBottom() if canNeighborConnect else not pt.canConnectBottom())
	
	if (LEFT_NEIGHBOR):
		canNeighborConnect = LEFT_NEIGHBOR.canConnectRight()
		possible_tiles = possible_tiles.filter(func(pt: Tile): return pt.canConnectLeft() if canNeighborConnect else not pt.canConnectLeft())
	
	if (RIGHT_NEIGHBOR):
		canNeighborConnect = RIGHT_NEIGHBOR.canConnectLeft()
		possible_tiles = possible_tiles.filter(func(pt: Tile): return pt.canConnectRight() if canNeighborConnect else not pt.canConnectRight())
		
	return possible_tiles

func __getTileCoordinatesFromClick(vector: Vector2) -> Vector2:
	var X = vector.x
	var Y = vector.y
	
	Check.isPositiveNumber(X)
	Check.isPositiveNumber(Y)
	
	var TILE_X = int(X / TILE_SIZE)
	var TILE_Y = int(Y / TILE_SIZE)
	
	return Vector2(TILE_X, TILE_Y)

func __getCenterTile() -> Vector2:
	var WINDOW_SIZE = get_viewport_rect()
	
	var WIDTH = WINDOW_SIZE.end.x
	var HEIGHT = WINDOW_SIZE.end.y
	
	var TILE_X = int(WIDTH / TILE_SIZE / 2)
	var TILE_Y = int(HEIGHT / TILE_SIZE / 2)
	
	return Vector2(TILE_X, TILE_Y)
	
func __getRandomTile(possible_tiles: Array[Tile] = __getConcreteTiles()) -> Tile:
	return possible_tiles[randi() % possible_tiles.size()]
	
func __getTile(tile_coordinates: Vector2) -> Tile:
	var TILE_X = tile_coordinates.x * TILE_SIZE
	var TILE_Y = tile_coordinates.y * TILE_SIZE
	
	for tile in tiles:
		if tile.position.x == TILE_X and tile.position.y == TILE_Y:
			return tile
	return null
	
func __isTileOccupied(tile_coordinates: Vector2) -> bool:
	return false if __getTile(tile_coordinates) == null else true
	
func __getConcreteTile(index: CONCRETE_TILE) -> Tile:
	match (index):
		CONCRETE_TILE.CORNER_BOTTOM_LEFT:
			return CornerBottomLeftTile.new()
		CONCRETE_TILE.CORNER_BOTTOM_RIGHT:
			return CornerBottomRightTile.new()
		CONCRETE_TILE.CORNER_TOP_LEFT:
			return CornerTopLeftTile.new()
		CONCRETE_TILE.CORNER_TOP_RIGHT:
			return CornerTopRightTile.new()
		CONCRETE_TILE.CROSS:
			return CrossTile.new()
		CONCRETE_TILE.EMPTY:
			return EmptyTile.new()
		CONCRETE_TILE.ONEWAY_BOTTOM:
			return OnewayBottomTile.new()
		CONCRETE_TILE.ONEWAY_LEFT:
			return OnewayLeftTile.new()
		CONCRETE_TILE.ONEWAY_RIGHT:
			return OnewayRightTile.new()
		CONCRETE_TILE.ONEWAY_TOP:
			return OnewayTopTile.new()
		CONCRETE_TILE.HORIZONTAL:
			return HorizontalTile.new()
		CONCRETE_TILE.VERTICAL:
			return VerticalTile.new()
		CONCRETE_TILE.T_BOTTOM:
			return TBottomTile.new()
		CONCRETE_TILE.T_LEFT:
			return TLeftTile.new()
		CONCRETE_TILE.T_RIGHT:
			return TRightTile.new()
		CONCRETE_TILE.T_TOP:
			return TTopTile.new()
	push_error("Invalid CONCRETE_TILE index.") 
	return 
	
func __getConcreteTiles() -> Array[Tile]:
	var TILES: Array[Tile] = []
	for i in range(CONCRETE_TILE.COUNT):
		TILES.append(__getConcreteTile(i))
	return TILES
	
func _ready() -> void:
	var CENTER_TILE_COORDINATES = __getCenterTile()
	var CENTER_TILE = __getRandomTile()
	place_tile(CENTER_TILE, CENTER_TILE_COORDINATES)
	add_child(SELECTOR)

func _process(delta: float) -> void:
	pass
