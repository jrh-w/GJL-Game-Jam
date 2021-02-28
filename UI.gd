extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pauseMenu = get_node("pauseContainer/pauseMenu")
onready var loseMenu = get_node("pauseContainer/loseMenu")
onready var winMenu = get_node("pauseContainer/winMenu")
onready var pauseScreen = get_node("pauseContainer/pauseScreen")

export(int) var currLevelNumber
export(bool) var lastLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

#func _input(event):
#	if Input.is_action_pressed("pause"):
#		get_tree().paused = true
#		pauseScreen.show()
#		pauseMenu.show()
#
#		MusicController.quiet()

func _on_Button_pressed():
	get_tree().paused = false
	pauseScreen.hide()
	pauseMenu.hide()
	
	MusicController.loud()
	MusicController.play_sound("click")

func lost():
	print("Lost it")
	get_tree().paused = true
	pauseScreen.show()
	loseMenu.show()
	
	MusicController.quiet()

func won():
	
	MusicController.quiet()
	
	#get_tree().paused = true
	#pauseScreen.show()
	#winMenu.show()
	if !lastLevel:
		get_node("/root/LevelMenu").isLocked[currLevelNumber] = 0
		print(get_node("/root/LevelMenu").isLocked)
		get_node("/root/LevelMenu").save_progress()
		get_tree().change_scene(str("res://Level", currLevelNumber + 1, ".tscn"))
	else:
		get_tree().change_scene(str("res://LevelExit.tscn"))

func _on_homeButton_pressed():
	get_tree().paused = false
	pauseScreen.hide()
	winMenu.hide()
	get_tree().change_scene("res://menu.tscn")

	MusicController.play_sound("click")
