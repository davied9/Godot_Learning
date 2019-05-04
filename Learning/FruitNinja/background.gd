extends Node2D

# Declare member variables here. Examples:
var melon = preload("res://watermelon.tscn")
var timer = 0
var leap = 0.5
var melons = []
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer > leap:
		timer = 0
		var node = melon.instance()
		node.position = Vector2(512, 650)
		self.add_child(node)
	for c in self.get_children():
		if c.position.y > 700:
			self.remove_child(c)
			c.free()
	pass
