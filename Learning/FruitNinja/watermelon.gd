extends RigidBody2D

class_name WaterMelon

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	var shot_angle = 3.14* ( 1.35 + 0.3 * randf())
	var move_speed = 300 + 100 * randf()
	self.linear_velocity = move_speed * Vector2(cos(shot_angle), sin(shot_angle))
	self.angular_velocity = 3 + 3 * randf()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
