extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pauseMenu = get_node("MarginContainer/CenterContainer/pauseMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		pauseMenu.show()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().paused = false
	pauseMenu.hide()
	pass # Replace with function body.
