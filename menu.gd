extends MarginContainer

onready var mainMenu = get_node("CenterContainer/mainMenu")
onready var settingsMenu = get_node("CenterContainer/settingsMenu")
onready var levelMenu = get_node("CenterContainer/levelMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_settingsButton_pressed():
	mainMenu.hide()
	settingsMenu.show()

func _on_backButton_pressed():
	settingsMenu.hide()
	levelMenu.hide()
	mainMenu.show()

func _on_playButton_down():
	mainMenu.hide()
	levelMenu.show()

func _playLevel(levelName):
	get_tree().change_scene("res://" + levelName + ".tscn")
