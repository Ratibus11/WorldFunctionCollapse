extends Node2D

const SEED_QUANTITY = 40
const GARDEN_AREA_THRESHOLD = 10

# =====

var delaunay: Delaunay

var SCREEN_SIZE = DisplayServer.window_get_size()

func __getRandomPoints(quantity: int) -> Array[Vector2i]:
	Check.isInt(quantity)
	Check.isPositiveNumber(quantity)
	
	var output: Array[Vector2i] = []
	for i in range(SEED_QUANTITY):
		var x = randi() % SCREEN_SIZE.x
		var y = randi() % SCREEN_SIZE.y
		output.append(Vector2i(x, y))
	
	return output
	
func _ready():
	delaunay = Delaunay.new(Rect2(Vector2(0, 0), SCREEN_SIZE))
	
	for point in __getRandomPoints(SEED_QUANTITY):
		delaunay.add_point(point)
		
	var triangles = delaunay.triangulate()
			
	var regions = delaunay.make_voronoi(triangles)
	for region in regions:
		__displayRegion(region)
	
func __displayRegion(region: Delaunay.VoronoiSite):
	var polygon: Polygon2D = Polygon2D.new()
	polygon.polygon = region.polygon
	
	if __getPolygonSurface(polygon) < GARDEN_AREA_THRESHOLD:
		var r = randf_range(0.3, 0.35)
		var g = randf_range(0.7, 0.8)
		var b = randf_range(0.1, 0.2)
		polygon.color = Color(r, g, b, 1)
	else:
		var g = randf_range(0.3, 0.5)
		polygon.color = Color(g, g, g, 1)
	
	add_child(polygon)
	
func __getPolygonSurface(polygon: Polygon2D):
	var points = polygon.polygon
	
	var a = 0
	var b = 0
	for i in range(points.size() - 1):
		a += points[i].x * points[i + 1].y
		b += points[i].y * points[i + 1].x
	
	return a - b

func _process(delta):
	pass
