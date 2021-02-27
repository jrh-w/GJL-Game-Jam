extends Position2D

var busy = false
export(String, "default", "back", "skip", "stop", "padlock") var function
export(String, "blue", "orange", "light_blue", "green", "yellow") var color
export(int) var connectedPadlockId

func _enter_tree():
	#print(color)
	var thisZoneColor = get_tree().get_root().get_node("Level/UI/TextureRect").colorDict[color]
	
	if function != "padlock":
		$box.texture = load(str("res://colorPalette/box_background_", function ,".png"))
	else:
		$box/Padlock.visible = true
		$box/Padlock/base.modulate = thisZoneColor
		$box2.visible = false
		busy = true
	
	$box2.modulate = thisZoneColor
	#print(get_tree().get_root().get_node("Level/UI/TextureRect").colorDict["blue"])

func init():
	if function == "padlock":
		$box/Padlock.visible = true
		$box2.visible = false
		busy = true

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

func matched():
	if connectedPadlockId:
		get_parent().get_node(str("dropzone",connectedPadlockId)).open()
	else:
		print("no padlock assigned")

func open():
	$box/Padlock.visible = false
	$box2.visible = true
	busy = false
