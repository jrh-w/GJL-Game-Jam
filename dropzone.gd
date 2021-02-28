extends Position2D

var busy = false
export(String, "none", "default", "back", "skip", "stop", "padlock") var function
export(String, "none", "blue", "orange", "light_blue", "green", "yellow") var color
export(int) var connectedPadlockId

func _enter_tree():
	#print(color)
	
	if color != "none":
		var thisZoneColor = get_tree().get_root().get_node("Level/UI/TextureRect").colorDict[color]
		
		if function != "padlock":
			$box.texture = load(str("res://colorPalette/box_background_", function ,".png"))
		else:
			$box/Padlock.visible = true
			$box/Padlock/base.modulate = thisZoneColor
			$box2.visible = false
			busy = true
		
		$box2.modulate = thisZoneColor
	else:
		$box.texture = load(str("res://colorPalette/box_background_", function ,".png"))
		$box2.visible = false
	#print(get_tree().get_root().get_node("Level/UI/TextureRect").colorDict["blue"])

func init():
	if function == "padlock":
		$box/Padlock.visible = true
		$box2.visible = false
		busy = true

func select(isReversing = false):
	busy = true
	var isExecuted = true
	if function == "back" && !isReversing:
		print("enter back")
		isExecuted = get_tree().get_root().get_node("Level").backTwoRounds()
	elif function == "skip" && !isReversing:
		#print("enter skip")
		isExecuted = get_tree().get_root().get_node("Level").forwardTwoRounds()
	elif function == "stop":
		get_tree().get_root().get_node("Level").paused = true
		print("enter stop")
	
	return isExecuted
	
func deselect(isReversing = false):
	if function == "padlock" && !isReversing:
		
		MusicController.play_sound("lockClose")
		
		$box/Padlock.visible = true
		$box2.visible = false
		busy = true
	else:
		busy = false
		if function == "stop":
			get_tree().get_root().get_node("Level").paused = false
			print("leaving stop")

func matched():
	if connectedPadlockId:
		get_parent().get_node(str("dropzone",connectedPadlockId)).open()
		return connectedPadlockId
	else:
		print("no padlock assigned")
		return null

func open():
	
	MusicController.play_sound("lockOpen")
	
	$box/Padlock.visible = false
	$box2.visible = true
	busy = false
