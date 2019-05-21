extends TileMap

# Declare member variables here. Examples:
var tile_to_set = 0
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print('tile ids : ', tile_set.get_tiles_ids ())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('click'):
		var mousePos = get_viewport().get_mouse_position()
		var loc = world_to_map(mousePos)
		var cell = get_cell(loc.x, loc.y)
		if( -1 != cell ):
			print(tile_set.tile_get_name(cell))
		else:
			set_cell(loc.x, loc.y, tile_to_set)
	if Input.is_action_pressed('click'):
		var mousePos = get_viewport().get_mouse_position()
		var loc = world_to_map(mousePos)
		var cell = get_cell(loc.x, loc.y)
		if( -1 == cell ):
			set_cell(loc.x, loc.y, tile_to_set)
	if Input.is_action_just_released('click'):
			tile_to_set += 1
			if tile_to_set >= len(tile_set.get_tiles_ids()):
				tile_to_set = 0
	if Input.is_action_pressed('right_click'):
		var mousePos = get_viewport().get_mouse_position()
		var loc = world_to_map(mousePos)
		var cell = get_cell(loc.x, loc.y)
		if( -1 != cell ):
			print(tile_set.tile_get_name(cell))
			set_cell(loc.x, loc.y, -1)
			tile_to_set = cell
		
		
		