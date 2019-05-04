extends Label

# Declare member variables here. Examples:
var angle = 0
var rotation_speed = 60
var index = 0
var texts = ["111111111","222222222","33333333"]
var control = null

# Called when the node enters the scene tree for the first time.
func _ready():
	control = self as Control
	print("get control : ", control)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	angle = angle + delta * rotation_speed
	if angle > 360:
		rotation_speed = -rotation_speed
	elif angle < 0:
		rotation_speed = -rotation_speed
	
	control.rect_rotation = angle
	
	if angle < 120:
		index = 0
	elif angle > 240:
		index = 2
	else:
		index = 1

	self.text = texts[index]

	
		
	pass

