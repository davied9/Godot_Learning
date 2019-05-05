extends RigidBody2D

class_name WaterMelon

# Declare member variables here. Examples:
var state = "flying"
var output_debug_info = false
var slices_scene = preload("res://watermelon_slice.tscn")

func set_state(new_state):
	print('watermelon state change from ', state, ' to ', new_state)
	state = new_state
	if 'cut' == state:
		create_slices()
#	if 'out_of_sight' == state:
#		self.free()

func get_state():
	return state

func create_slices():
	var p = get_parent()
	var inst1 = slices_scene.instance()
	var inst2 = slices_scene.instance()
	inst1.position = position - Vector2(10, 0)
	inst1.linear_velocity = linear_velocity - Vector2(20 + 10*randf(), 0)
	inst1.angular_velocity = angular_velocity * 5
	inst2.position = position + Vector2(10, 0)
	inst2.linear_velocity = linear_velocity + Vector2(20 + 10*randf(), 0)
	inst2.angular_velocity = angular_velocity * 5
	p.add_child(inst1)
	p.add_child(inst2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if output_debug_info:
		print(self, " state is ", state)
	
