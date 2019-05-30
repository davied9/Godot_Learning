extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	yield(get_tree().create_timer(3), 'timeout')
	$StartButton.show()
	# When you need to pause for a brief time, an alternative to using a Timer node
	#  is to use the SceneTree’s create_timer() function. 
	# This can be very useful to delay, such as in the above code, 
	# where we want to wait a little bit of time before showing the “Start” button.
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

