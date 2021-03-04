extends TextureButton

var orangeRestartButton = load("res://colorPalette/UI_Button_Last_Tour.png")
var normalRestartButton = load("res://colorPalette/UI_Button_restart.png")

func _on_TextureButton_pressed():
	turnNormal()
	get_tree().get_root().get_node("Level").restart_round()

func turnOrange():
	get_node(".").texture_normal = orangeRestartButton
	
func turnNormal():
	get_node(".").texture_normal = normalRestartButton
	get_tree().get_root().get_node("Level/UI/TextureRect/LastTour").on = false
