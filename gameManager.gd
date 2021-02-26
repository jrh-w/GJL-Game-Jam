extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var history = [] # History of our moves

var roundEnd = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_log(name, a, b):
	var n = {
		"card": name,
		"from": a,
		"to": b
	}
	# Such is the needed transition between the blocks
	if !roundEnd: 
		get_node("UI/TextureRect").offset += 93
		history.push_front(n)
		
func restart_round():
	while history.size() > 0:
		var route = history.pop_front()
		get_node("innerGame/" + route.card).rest_point.deselect()
		get_node("innerGame/" + route.card).rest_point = route.from
		get_node("UI/TextureRect").offset -= 93
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
