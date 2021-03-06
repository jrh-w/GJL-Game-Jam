extends Node2D

var selected = false
var rest_point
var rest_nodes = []
export var shape = "circle"
var shapeId = 0

var onMatchingPos = false

onready var level = get_tree().get_root().get_node("Level")
onready var textRect = get_tree().get_root().get_node("Level/UI/TextureRect")

var pauseOverText = load("res://colorPalette/box_background_stop_1.png")
var forwardOverText = load("res://colorPalette/box_background_skip_1.png")
var backwardOverText = load("res://colorPalette/box_background_back_1.png")

var darkcolorDict = {
	"blue": "#503785",
	"orange": "#ff954f",
	"light_blue": "#79ABD1",
	"green": "#C8E687",
	"yellow": "#ffe375"
}

func _ready():
	
	$pobrane.texture = load(str("res://colorPalette/box_", shape, ".png"))
	
	shapeId = get_tree().get_root().get_node("Level/UI/TextureRect").shapes.find(shape, 0)
	
	rest_nodes = get_tree().get_nodes_in_group("zone")
	
	rest_point = rest_nodes[0]
	for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < global_position.distance_to(rest_point.global_position):
					rest_point = child
					
	print("ready")
	rest_point.select()
	
	updateColor()
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed && selected:
			
			MusicController.play_sound("drop")
			
			selected = false
			var shortest_dist = 75
			var tempRestPoint
			
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					tempRestPoint = child
					shortest_dist = distance
					
			if tempRestPoint != null:
				# Player can now move between any 2 cubes on level
				if !tempRestPoint.busy:
					rest_point.deselect()
					
					# Needed !!!!!!
					var tempForLog = rest_point
					
					rest_point = tempRestPoint
					var isExecuted = rest_point.select()
					level.new_log(get_node(".").name, tempForLog, tempRestPoint, isExecuted)
				else:
					MusicController.play_sound("lockClose")
						
			for cube in get_tree().get_nodes_in_group("kotki"):
				cube.updateColor()
				
			if level.currentRound < level.rounds:
				
				var padlockId = null
				
				if textRect.colorTable[textRect.offset / 93][textRect.shapeTable.find(shapeId, 0)] == rest_point.color:
					print("matching color")
					onMatchingPos = true
					padlockId = rest_point.matched()
				else:
					onMatchingPos = false
				
				# Update move history by checking if padlock was unlocked
				if tempRestPoint != null && padlockId != null:
					level.update_log(padlockId)
				
				level.isWon()
			
func _on_Area2D_input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			level.onlyOneSelected = true
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			if !level.roundEnd && !level.isWon && !level.isLost && level.onlyOneSelected:
				MusicController.play_sound("pick")
				selected = true
				level.onlyOneSelected = false

	if Input.is_action_just_pressed("click"):
		
		if !level.roundEnd && !level.isWon && !level.isLost:
			MusicController.play_sound("pick")
			selected = true
			
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point.global_position, 10 * delta)

func updateColor():
	if level.currentRound < level.rounds:
		var currColorTable = textRect.colorTable[textRect.offset / 93]
		var whereId = textRect.shapeTable.find(shapeId, 0)
		
		$pobrane.modulate = textRect.colorDict[currColorTable[whereId]]
		
		var currColorName = currColorTable[whereId]
		
		if currColorTable[whereId] == rest_point.color:
			onMatchingPos = true
			rest_point.matched()
		else:
			onMatchingPos = false
			
		if rest_point.function == "stop":
			$onPaused.visible = true
			$onPaused.modulate = darkcolorDict[currColorName]
			$onPaused.texture = pauseOverText
		elif rest_point.function == "skip":
			$onPaused.visible = true
			$onPaused.modulate = darkcolorDict[currColorName]
			$onPaused.texture = forwardOverText
		elif rest_point.function == "back":
			$onPaused.visible = true
			$onPaused.modulate = darkcolorDict[currColorName]
			$onPaused.texture = backwardOverText
		else:
			$onPaused.visible = false
