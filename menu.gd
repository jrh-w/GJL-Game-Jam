extends TextureRect

onready var mainMenu = get_node("CenterContainer/mainMenu")
onready var settingsMenu = get_node("CenterContainer/settingsMenu")
onready var levelMenu = get_node("CenterContainer/levelMenu")
onready var creditsMenu = get_node("CenterContainer/creditsMenu")
onready var creditsButton = get_node("creditsContainer")

func _on_settingsButton_pressed():
	
	MusicController.play_sound("click")
	
	mainMenu.hide()
	settingsMenu.show()

func _on_backButton_pressed():
	
	MusicController.play_sound("click")
	
	settingsMenu.hide()
	levelMenu.hide()
	mainMenu.show()

func _on_playButton_down():
	
	MusicController.play_sound("click")
	
	mainMenu.hide()
	levelMenu.show()

func _playLevel(levelName):
	
	MusicController.play_sound("click")
#	MusicController.loud()
	
	get_tree().change_scene("res://" + levelName + ".tscn")

func _on_creditsButton_pressed():
	
	MusicController.play_sound("click")
	
	creditsButton.visible = false
	levelMenu.visible = false
	creditsMenu.visible = true

func _on_backCreditsButton_pressed():
	
	MusicController.play_sound("click")
	
	creditsMenu.visible = false
	levelMenu.visible = true
	creditsButton.visible = true
