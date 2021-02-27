extends Position2D

var busy = false
export var function = 'default'

func _enter_tree():
	if function == "back":
		$box.texture = load("res://colorPalette/box_background_back.png")
	elif function == "skip":
		$box.texture = load("res://colorPalette/box_background_skip.png")
	elif function == "stop":
		$box.texture = load("res://colorPalette/box_background_stop.png")

func select():
	busy = true
	
	if function == "back":
		print("enter back")
		get_tree().get_root().get_node("Level").backTwoRounds()
	elif function == "skip":
		print("enter skip")
	elif function == "stop":
		get_tree().get_root().get_node("Level").paused = true
		print("enter stop")
	
	
func deselect():
	busy = false
	if function == "stop":
		get_tree().get_root().get_node("Level").paused = false
		print("leaving stop")
