class_name TileGrid
extends TileMap

const RENDER_BARRIER = true
const RENDER_SLEEP = 0.01
const MANUAL_RENDER = false
const GRID_SIZE = 31

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

const TILE_SIZE = 30
var tiles: Array[Tile] = []

func __place_tile(tile: Tile, tile_coordinates: Vector2i, bypassLimits: bool = false) -> void:
	if not bypassLimits and not __areCoordinatesInGrid(tile_coordinates):
		push_warning(str("Cannot place tile at x:"+str(tile_coordinates.x)+" y:"+str(tile_coordinates.y)+"."))
		return 
		
	Check.isInt(tile_coordinates.x)
	Check.isInt(tile_coordinates.y)
	
	tile.position.x = tile_coordinates.x * TILE_SIZE
	tile.position.y = tile_coordinates.y * TILE_SIZE
	
	add_child(tile)
	tiles.append(tile)

func _input(event: InputEvent) -> void:
	var TILE_COORDINATES = __getTileCoordinatesFromClick(event.position)
	
	if not __areCoordinatesInGrid(TILE_COORDINATES):
		return
	
	if event is InputEventMouseButton:
		if event.pressed == true:
			if not __isTileOccupied(TILE_COORDINATES):
				var possible_tiles = __getPossibleTiles(TILE_COORDINATES)
				__place_tile(__getRandomTile(possible_tiles), TILE_COORDINATES)
				
	elif event is InputEventMouseMotion:
		if MANUAL_RENDER:
			if not __isTileOccupied(TILE_COORDINATES):
				var COORDINATES = Vector2i(TILE_COORDINATES.x * TILE_SIZE, TILE_COORDINATES.y * TILE_SIZE)
				SELECTOR.set_position(COORDINATES)
				SELECTOR.show()
			else:
				SELECTOR.hide()

func __getPossibleTiles(new_tile_coordinates: Vector2i):
	var TOP_NEIGHBOR_COORDINATES = Vector2i(new_tile_coordinates.x, new_tile_coordinates.y - 1)
	var BOTTOM_NEIGHBOR_COORDINATES = Vector2i(new_tile_coordinates.x, new_tile_coordinates.y + 1)
	var LEFT_NEIGHBOR_COORDINATES = Vector2i(new_tile_coordinates.x - 1, new_tile_coordinates.y)
	var RIGHT_NEIGHBOR_COORDINATES = Vector2i(new_tile_coordinates.x + 1, new_tile_coordinates.y)
	
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

func __getTileCoordinatesFromClick(vector: Vector2i) -> Vector2i:
	var X = vector.x
	var Y = vector.y
	
	var TILE_X = int(X / TILE_SIZE)
	var TILE_Y = int(Y / TILE_SIZE)
	
	return Vector2i(TILE_X, TILE_Y)

func __getCenterTile() -> Vector2i:
	var WINDOW_SIZE = get_viewport_rect()
	
	var WIDTH = WINDOW_SIZE.end.x
	var HEIGHT = WINDOW_SIZE.end.y
	
	var TILE_X = int(WIDTH / TILE_SIZE / 2)
	var TILE_Y = int(HEIGHT / TILE_SIZE / 2)
	
	return Vector2i(TILE_X, TILE_Y)
	
func __getRandomTile(possible_tiles: Array[Tile] = __getConcreteTiles()) -> Tile:
	return possible_tiles[randi() % possible_tiles.size()]
	
func __getTile(tile_coordinates: Vector2i) -> Tile:
	var TILE_X = tile_coordinates.x * TILE_SIZE
	var TILE_Y = tile_coordinates.y * TILE_SIZE
	
	for tile in tiles:
		if tile.position.x == TILE_X and tile.position.y == TILE_Y:
			return tile
	return null
	
func __isTileOccupied(tile_coordinates: Vector2i) -> bool:
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
	
func __initWindowSize(size: int) -> void:
	Check.isInt(size);
	Check.isOdd(size);
	
	var SIZE = size * TILE_SIZE
	DisplayServer.window_set_size(Vector2i(SIZE, SIZE))
	
func __generateGrid(size: int) -> void:
	Check.isInt(size);
	Check.isOdd(size);
	
	var cursor_x = (size - 1) / 2
	var cursor = Vector2i(cursor_x, cursor_x)
	
	var MOVEMENTS: Array[Vector2i] = [
		Vector2i(0, -1),
		Vector2i(1, 0),
		Vector2i(0, 1),
		Vector2i(-1, 0)
	]
	
	for x in range(cursor_x + 1):
		for i in range(MOVEMENTS.size()):
			var movement = MOVEMENTS[i]
			
			cursor = Vector2i(cursor.x + movement.x, cursor.y + movement.y)
			
			var possible_tiles = __getPossibleTiles(cursor)
			__place_tile(__getRandomTile(possible_tiles), cursor)
			await get_tree().create_timer(RENDER_SLEEP).timeout
			
			var nextAxisTile = __getNextAxisCursorPosition(MOVEMENTS, i, cursor)
			while __isTileOccupied(nextAxisTile):
				cursor = Vector2i(cursor.x + movement.x, cursor.y + movement.y)
				nextAxisTile = __getNextAxisCursorPosition(MOVEMENTS, i, cursor)
				
				possible_tiles = __getPossibleTiles(cursor)
				__place_tile(__getRandomTile(possible_tiles), cursor)
				await get_tree().create_timer(RENDER_SLEEP).timeout

func __generateGridBarrier(gridSize: int):
	Check.isInt(gridSize);
	Check.isOdd(gridSize);
	
	__place_tile(__getConcreteTile(CONCRETE_TILE.CORNER_BOTTOM_RIGHT), Vector2i(-1, -1), true)
	__place_tile(__getConcreteTile(CONCRETE_TILE.CORNER_BOTTOM_LEFT), Vector2i(gridSize, -1), true)
	__place_tile(__getConcreteTile(CONCRETE_TILE.CORNER_TOP_RIGHT), Vector2i(-1, gridSize), true)
	__place_tile(__getConcreteTile(CONCRETE_TILE.CORNER_TOP_LEFT), Vector2i(gridSize, gridSize), true)
	
	for i in range(gridSize):
		__place_tile(__getConcreteTile(CONCRETE_TILE.HORIZONTAL), Vector2i(i, -1), true)
		__place_tile(__getConcreteTile(CONCRETE_TILE.HORIZONTAL), Vector2i(i, gridSize), true)
		__place_tile(__getConcreteTile(CONCRETE_TILE.VERTICAL), Vector2i(gridSize, i), true)
		__place_tile(__getConcreteTile(CONCRETE_TILE.VERTICAL), Vector2i(-1, i), true)

		

func __areCoordinatesInGrid(cursor: Vector2i) -> bool:
	return (0 <= cursor.x and cursor.x <= GRID_SIZE - 1) and (0 <= cursor.y and cursor.y <= GRID_SIZE - 1)
	
func __getNextAxisCursorPosition(movements: Array[Vector2i], currentMovementIndex: int, cursor: Vector2i) -> Vector2i:
	Check.isInt(currentMovementIndex);
	
	var nextAxisMovementIndex = (currentMovementIndex + 1) % movements.size()
	
	return Vector2i(cursor.x + movements[nextAxisMovementIndex].x, cursor.y + movements[nextAxisMovementIndex].y)
	
	
func _ready() -> void:
	__initWindowSize(GRID_SIZE)
	var CENTER_TILE_COORDINATES = __getCenterTile()
	var CENTER_TILE = __getRandomTile()
	__place_tile(CENTER_TILE, CENTER_TILE_COORDINATES)
	
	SELECTOR.hide()
	add_child(SELECTOR)
	
	if RENDER_BARRIER:
		__generateGridBarrier(GRID_SIZE)
	
	if not MANUAL_RENDER:
		__generateGrid(GRID_SIZE)

func _process(delta: float) -> void:
	pass
