extends Position2D

var busy = false
var color = '#8fc6e0'
export var function = 'default'

func _enter_tree():
	if function == "back":
		print("go back")
		$box.texture = load("res://colorPalette/box_background_back.png")
	elif function == "skip":
		$box.texture = load("res://colorPalette/box_background_skip.png")
		print("skip")
	elif function == "stop":
		$box.texture = load("res://colorPalette/box_background_stop.png")
		print("stop")

func select():
	$box2.modulate = color
	busy = true
	
	if function == "back":
		print("go back")
		get_tree().get_root().get_node("Level").restart_round()
	elif function == "skip":
		print("skip")
	elif function == "stop":
		print("stop")
	
	
func deselect():
	busy = false
