extends RigidBody2D

class_name WaterMelon

# Declare member variables here. Examples:
var state = "flying"
var output_debug_info = false

func set_state(new_state):
	print('watermelon state change from ', state, ' to ', new_state)
	state = new_state
#	if 'out_of_sight' == state:
#		self.free()

func get_state():
	return state

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if output_debug_info:
		print(self, " state is ", state)
	
