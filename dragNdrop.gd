extends Node2D

var selected = false
var rest_point
var rest_nodes = []

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0]
	for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < global_position.distance_to(rest_point.global_position):
					rest_point = child
	rest_point.select()

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
					if !tempRestPoint.busy:
						get_tree().get_root().get_node("Level").new_log(get_node(".").name, rest_point, tempRestPoint)
						rest_point.deselect()
						rest_point = tempRestPoint
						rest_point.select()
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point.global_position, 10 * delta)
