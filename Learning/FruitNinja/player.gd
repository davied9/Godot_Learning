extends Node2D

# Declare member variables here. Examples:
const LINE_WIDTH = 10
const LINE_COLOR = Color(1,0,0,0.5)
const LAST_TIME = 0.1
const INIT_POS = Vector2(-1111, -1111)
var slice = []
var last_press_pos = INIT_POS

func add_attack_position(new_attack_position, time_elapsed):
	var N = len(slice)
	if N > 0:
		var die_count = 0
		for s in slice:
			s['time_elapsed'] += time_elapsed
			if s['time_elapsed'] > LAST_TIME:
				die_count += 1
		if N == die_count:
			die_count = N - 1
		for i in range(die_count):
			slice.remove(0)
	slice.append({'position':new_attack_position, 'time_elapsed':0})
	
func clear_attack_position():
	slice.clear()
	
func is_new_attack_position_available(new_attack_position):
	if 0 == len(slice):
		return true
	var distance = (slice[-1]['position'] - new_attack_position).length()
	if distance > 30:
		return true
	else:
		return false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("attack"):
		var attack_position = get_viewport().get_mouse_position()
		if is_new_attack_position_available(attack_position):
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_point(attack_position)
			for r in result:
				var collider = r['collider']
				var m = collider as WaterMelon
				if null != m and m.is_in_group("fruits"):
					m.free()
			add_attack_position(attack_position, delta)
		else:
			clear_attack_position()
			add_attack_position(attack_position, delta)
		update()
	elif Input.is_action_just_released("attack"):
		clear_attack_position()
		update()

func _draw():
	var N = len(slice)
	if 1 == N:
		draw_circle(slice[0]["position"], LINE_WIDTH, LINE_COLOR)
	elif N > 1:
		for i in N - 1:
			draw_line(slice[i]["position"], slice[i+1]["position"], LINE_COLOR, LINE_WIDTH)
