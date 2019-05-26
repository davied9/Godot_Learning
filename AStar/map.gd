extends TileMap

# Declare member variables here. Examples:
var path_start_loc = Vector2() # loc in map
var path_end_loc = Vector2() # loc in map
var path_is_changed = false
var path = [] # path in loc map
var astar = AStar.new()
var map_region = Rect2()
onready var path_painter = get_parent().get_path_painter()
const WALKABLES = [2]


func update_start_pos(input_event):
	if input_event.is_action_pressed("start"):
		var mouse_pos = get_viewport().get_mouse_position()
		path_start_loc =  world_to_point(mouse_pos)
		var cell = get_cell(path_start_loc.x, path_start_loc.y)
		if 2 == cell:
			var world_pos = point_to_world(path_start_loc)
			$start.position = world_pos
			path_is_changed = true
			
func update_end_pos(input_event):
	if input_event.is_action_pressed("end"):
		var mouse_pos = get_viewport().get_mouse_position()
		path_end_loc = world_to_point(mouse_pos)
		var cell = get_cell(path_end_loc.x, path_end_loc.y)
		if 2 == cell:
			var world_pos = point_to_world(path_end_loc)
			$end.position = world_pos
			path_is_changed = true
	
func update_path():
	if not path_is_changed: return
	var start_pos_index = point_to_index(path_start_loc)
	var end_pos_index = point_to_index(path_end_loc)
	path = astar.get_id_path(start_pos_index, end_pos_index)
	path_is_changed = false
	print('update path : ', path)
	var path_to_run = []
	for point in path:
		path_to_run.append(point_to_world(index_to_point(point)))
	path_to_run.invert()
	path_painter.paint_path(path_to_run)
	$runner.run_path(path_to_run)
		
func point_to_index(point):
	return point.x + map_region.size.x * point.y
	
func index_to_point(index):
	return Vector2(int(index)%int(map_region.size.x), floor(index/map_region.size.x))
	
func point_to_world(point): # point in map to world
	return map_to_world(point) + 0.5*get_cell_size()
	
func world_to_point(world):
	return world_to_map(world)
	
func is_walkable(x, y):
	return get_cell(x,y) in WALKABLES
	
func is_outside_map_bounds(point):
	return point.x < map_region.position.x or point.y < map_region.position.y \
		or point.x > map_region.end.x or point.y > map_region.end.y
	
func init_map_region():
	map_region = get_used_rect()
	
func init_path():
	path_start_loc = world_to_point($start.position)
	path_end_loc = world_to_point($end.position)
	path_is_changed = true
	
func init_astar():
	var walkable_points_array = []
	# find walkable points && add them to astar
	for x in range(map_region.position.x, map_region.end.x):
		for y in range(map_region.position.y, map_region.end.y):
			if is_walkable(x, y):
				var point = Vector2(x, y)
				var point_index = point_to_index(point)
				walkable_points_array.append( point )
				#print('astar : adding point ', point)
				astar.add_point(point_index, Vector3(point.x, point.y, 0.0))
	# connect walkable points
	for point in walkable_points_array:
		var point_index = point_to_index(point)
		var points_relative = PoolVector2Array([
			Vector2(point.x + 1, point.y),
			Vector2(point.x - 1, point.y),
			Vector2(point.x, point.y + 1),
			Vector2(point.x, point.y - 1)])
		for point_relative in points_relative:
			var point_relative_index = point_to_index(point_relative)
			if is_outside_map_bounds(point_relative):
				continue
			if not astar.has_point(point_relative_index): # astar have all walkable points
				continue
			astar.connect_points(point_index, point_relative_index, false)
			#print('astar : connect ', point_index, '(', point, ') with ', point_relative_index, '(', point_relative, ')')

# Called when the node enters the scene tree for the first time.
func _ready():
	init_map_region()
	init_astar()
	init_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	update_start_pos(event)
	update_end_pos(event)
	update_path()
	#test_point_trasform(event)
	
func test_point_trasform(input_event):
	if input_event.is_action_pressed("middle"):
		var pos = get_viewport().get_mouse_position()
		var point = world_to_point(pos)
		var index = point_to_index(point)
		var point_new = index_to_point(index)
		print('new click : world', pos, ', map loc ', point, ', index ', index, ', map loc(transoform backwards) ', point_new)