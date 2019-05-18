extends Node

# Declare member variables here. Examples:
var angle = 0
var rotation_speed = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle = angle + delta * rotation_speed
	if angle > 180:
		angle = 0
		
	pass
	
	
	
