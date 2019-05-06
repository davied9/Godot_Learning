extends Node2D


const WIDTH = 1024
const HEIGHT = 600
var melon = preload("res://watermelon.tscn")
var timer = 0
var leap = 0.5
var melons = []

func apply_random_start_state(fruit):
	var start_point = Vector2(1024*randf(), HEIGHT + 100) #Vector2(-256 + 1536*randf(), 900)
	var target_point = Vector2(256 + 512*randf(), 300)
	var shot_direction = (target_point - start_point).normalized()
	var move_speed = 300 + 100 * randf()
	fruit.position = start_point
	fruit.linear_velocity = move_speed * shot_direction
	fruit.angular_velocity = 3 + 1 * randf()

func _ready():
	pass # Replace with function body.

func _draw():
#	var center = Vector2(WIDTH/2, HEIGHT/2)
#	var bottom = Vector2(WIDTH/2, HEIGHT)
#	draw_line(center-Vector2(100, 0), center+Vector2(100, 0), Color(1,0,0), 8)
#	draw_line(bottom-Vector2(400, 0), bottom+Vector2(400, 0), Color(1,0,0), 8)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer > leap:
		timer = 0
		var node = melon.instance()
		apply_random_start_state(node)
		self.add_child(node)
	for c in self.get_children():
		if c.position.y > 700:
			self.remove_child(c)
			var cc = c as WaterMelon
			if null != cc:
				cc.set_state("out_of_sight")
				cc.free()
			var ccs = c as WaterMelonSlice
			if null != ccs:
				ccs.free()
