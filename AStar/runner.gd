extends Sprite

# Declare member variables here. Examples:
var path = []
const SPEED = 400
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		
		position = path[path.size() - 1]
		
		if path.size() < 2:
			path = []
			set_visible(false)
			set_process(false)
		

func run_path(new_path):
	set_visible(true)
	set_process(true)
	path = new_path