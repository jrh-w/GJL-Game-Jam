extends Node2D

var selected = false
var rest_point
var rest_nodes = []
export var shape = "circle"
var shapeId = 0

var onMatchingPos = false

onready var level = get_tree().get_root().get_node("Level")
onready var textRect = get_tree().get_root().get_node("Level/UI/TextureRect")

var darkcolorDict = {
	"blue": "#503785",
	"orange": "#FF643D",
	"light_lue": "#79ABD1",
	"green": "#C8E687",
	"yellow": "#CHUJWIE"
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
	rest_point.select()
	
	updateColor()
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("click"):
		
		if !level.roundEnd:
			selected = true
			
	if Input.is_action_just_released("click"): 
			selected = false
			var shortest_dist = 75
			var tempRestPoint
			
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					tempRestPoint = child
					shortest_dist = distance
					
			if tempRestPoint != null:
				#if !tempRestPoint.busy && rest_point.global_position.distance_to(tempRestPoint.global_position) < 110:
				if !tempRestPoint.busy:
					rest_point.deselect()
					level.new_log(get_node(".").name, rest_point, tempRestPoint)
					rest_point = tempRestPoint
					rest_point.select()
						
			for cube in get_tree().get_nodes_in_group("kotki"):
				cube.updateColor()
				
			if level.currentRound < level.rounds:
				if textRect.colorTable[textRect.offset / 93][textRect.shapeTable.find(shapeId, 0)] == rest_point.color:
					onMatchingPos = true
					rest_point.matched()
				else:
					onMatchingPos = false
				
				level.isWon()
		
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
		else:
			$onPaused.visible = false
