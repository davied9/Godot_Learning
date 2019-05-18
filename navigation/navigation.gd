extends Navigation2D

# Member variables
const SPEED = 200.0

var begin = Vector2()
var end = Vector2()
var path = []
var agent = null

var new_begin = Vector2()
var new_end = Vector2()
var new_path = []
var new_agent = null

func _ready():
	agent = $agent
	new_agent = $new_agent
	end = agent.position

func _process(delta):
	if path.size() > 1:
		var to_walk = delta * SPEED
		while to_walk > 0 and path.size() >= 2:
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		agent.position = path[path.size() - 1]
		
		if path.size() < 2:
			path = []
			
	else:
		agent.position = end
		
	if new_path.size() > 1:
		var to_walk = delta * SPEED
		while to_walk > 0 and new_path.size() >= 2:
			var pfrom = new_path[new_path.size() - 1]
			var pto = new_path[new_path.size() - 2]
			var d = pfrom.distance_to(pto)
			if d <= to_walk:
				new_path.remove(new_path.size() - 1)
				to_walk -= d
			else:
				new_path[new_path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		new_agent.position = new_path[new_path.size() - 1]
		
		if new_path.size() < 2:
			new_path = []

func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # PoolVector2Array too complex to use, convert to regular array
	path.invert()
	print("path : ", path)

func _update_new_path():
	var p = get_simple_path(new_begin, new_end, true)
	new_path = Array(p) # PoolVector2Array too complex to use, convert to regular array
	new_path.invert()
	print("new path : ", new_path)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		begin = agent.position
		# Mouse to local navigation coordinates
		end = event.position - position
		_update_path()
		
	if event is InputEventMouseButton and event.pressed and event.button_index == 2:
		new_begin = new_agent.position
		# Mouse to local navigation coordinates
		new_end = event.position - position
		_update_new_path()
