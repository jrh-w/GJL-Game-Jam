extends Position2D

var busy = false
export(String, "none", "default", "back", "skip", "stop", "padlock") var function
export(String, "none", "blue", "orange", "light_blue", "green", "yellow") var color
export(int) var connectedPadlockId

export(int) var padlockIdItsConnTo

func _enter_tree():
	
	if color != "none":
		var thisZoneColor = get_tree().get_root().get_node("Level/UI/TextureRect").colorDict[color]
		
		if function != "padlock":
			$box.texture = load(str("res://colorPalette/box_background_", function ,".png"))
		else:
			$box/Padlock.visible = true
			$box/Padlock/base.modulate = get_tree().get_root().get_node("Level/UI/TextureRect").colorDict[get_parent().get_node(str("dropzone", padlockIdItsConnTo)).color]
			busy = true
		
		$box2.modulate = thisZoneColor
	else:
		$box.texture = load(str("res://colorPalette/box_background_", function ,".png"))
		$box2.visible = false

func init():
	if function == "padlock":
		$box/Padlock.visible = true
		busy = true

func select(isReversing = false):
	busy = true
	var isExecuted = 2
	if function == "back" && !isReversing:
		isExecuted = get_tree().get_root().get_node("Level").backTwoRounds()
	elif function == "skip" && !isReversing:
		isExecuted = get_tree().get_root().get_node("Level").forwardTwoRounds()
	elif function == "stop":
		get_tree().get_root().get_node("Level/UI/TextureRect/arrowContainer/Arrow/TextureRect").texture = load("res://colorPalette/UI_round_stop.png")
		get_tree().get_root().get_node("Level").paused = true
	
	return isExecuted
	
func deselect(isReversing = false):
	if function == "padlock" && !isReversing:
		
		MusicController.play_sound("lockClose")
		
		$box/Padlock.visible = true
		busy = true
	else:
		busy = false
		if function == "stop":
			get_tree().get_root().get_node("Level/UI/TextureRect/arrowContainer/Arrow/TextureRect").texture = load("res://colorPalette/UI_round_arrow.png")
			get_tree().get_root().get_node("Level").paused = false

func matched():
	if connectedPadlockId:
		get_parent().get_node(str("dropzone",connectedPadlockId)).open()
		return connectedPadlockId
	else:
		return null

func open():
	
	MusicController.play_sound("lockOpen")
	
	$box/Padlock.visible = false
	$box2.visible = true
	busy = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("click") || (event is InputEventScreenTouch && event.pressed and event.get_index() == 0):
		MusicController.play_sound("lockClose")
