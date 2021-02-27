extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pauseMenu = get_node("pauseContainer/pauseMenu")
onready var pauseScreen = get_node("pauseContainer/pauseScreen")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		pauseScreen.show()
		pauseMenu.show()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("works")
	get_tree().paused = false
	pauseScreen.hide()
	pauseMenu.hide()
	pass # Replace with function body.
