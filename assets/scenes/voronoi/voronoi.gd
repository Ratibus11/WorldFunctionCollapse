extends Node2D

const SEED_QUANTITY = 60
const TOWN_AREA_THRESHOLD = 50000
const CITY_AREA_THRESHOLD = 200000

# =====

var delaunay: Delaunay

var SCREEN_SIZE = DisplayServer.window_get_size()
var TOTAL_AREA = SCREEN_SIZE.y * SCREEN_SIZE.y

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
	
	var SURFACE = __getPolygonSurface(polygon)
	if SURFACE < TOWN_AREA_THRESHOLD:
		var r = randf_range(0.3, 0.35)
		var g = randf_range(0.7, 0.8)
		var b = randf_range(0.1, 0.2)
		polygon.color = Color(r, g, b, 1)
	elif SURFACE < CITY_AREA_THRESHOLD:
		var g = randf_range(0.6, 0.7)
		polygon.color = Color(g, g, g, 1)
	else:
		var g = randf_range(0.3, 0.4)
		polygon.color = Color(g, g, g, 1)
	add_child(polygon)
	
func __getPolygonSurface(polygon: Polygon2D):
	var points = polygon.polygon
	var surface = 0
	var n = points.size()
	
	var a = 0;
	var b = 0;
	
	var x1;
	var x2;
	var y1;
	var y2;
	
	for i in range(n):
		x1 = points[i].x
		y2 = points[(i + 1) % n].y
		y1 = points[i].y
		x2 = points[(i + 1) % n].x
		
		a += x1 * y2
		b += y1 + x2
	
	return abs(a - b) / 2

func _process(delta):
	pass
