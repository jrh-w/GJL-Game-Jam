extends MarginContainer

var on = false
var during = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if on && !during:
		during = true
		get_node(".").visible = !get_node(".").visible
		yield(get_tree().create_timer(1), "timeout")
		during = false
	elif !on:
		get_node(".").visible = false
