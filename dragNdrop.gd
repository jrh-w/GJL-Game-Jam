extends Node2D

var selected = false
var rest_point
var rest_nodes = []
export var shape = "circle"
var shapeId = 0

func _ready():
	#print(str("res://colorPalette/box_", shape, ".png"))
	$pobrane.texture = load(str("res://colorPalette/box_", shape, ".png"))
	
	shapeId = get_tree().get_root().get_node("Level/UI/TextureRect").shapes.find(shape, 0)
	
	#if shape == "square":
	#	shapeId = 0
	#elif shape == "circle":
	#	shapeId = 1
	#elif shape == "Hexagon":
	#	shapeId = 2
	#elif shape == "triangle":
	#	shapeId = 3
		
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
					if !tempRestPoint.busy && rest_point.global_position.distance_to(tempRestPoint.global_position) < 110:
						get_tree().get_root().get_node("Level").new_log(get_node(".").name, rest_point, tempRestPoint)
						rest_point.deselect()
						rest_point = tempRestPoint
						rest_point.select()
			for cube in get_tree().get_nodes_in_group("kotki"):
				cube.updateColor()
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point.global_position, 10 * delta)

func updateColor():
	var level = get_tree().get_root().get_node("Level")
	if level.currentRound < level.rounds:
		var TextRect = get_tree().get_root().get_node("Level/UI/TextureRect")
		var currColorTable = TextRect.colorTable[TextRect.offset / 93]
		var whereId = TextRect.shapeTable.find(shapeId, 0)
		$pobrane.modulate = TextRect.colorDict[currColorTable[whereId]]
