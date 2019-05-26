extends Node2D

# Declare member variables here. Examples:
const PATH_COLOR = Color(0,1,0)
const PATH_WIDTH = 10
var path = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func paint_path(path_to_paint):
	path = path_to_paint
	update()

func _draw():
	var last_point = path[0]
	for i in range(path.size()-1):
		var new_point = path[i+1]
		draw_line(last_point, new_point, PATH_COLOR, PATH_WIDTH, true)
		draw_circle(new_point, PATH_WIDTH/2, PATH_COLOR)
		last_point = new_point
	pass