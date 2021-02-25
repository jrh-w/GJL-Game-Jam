extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var playButton = get_node("HBoxContainer/VBoxContainer/initialMenu/playButton")
onready var menu1 = get_node("HBoxContainer/VBoxContainer/initialMenu")
onready var menu2 = get_node("HBoxContainer/levelMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onPlay():
	menu1.hide()
	menu2.show()
	print("xd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func onBack():
	menu2.hide()
	menu1.show()
