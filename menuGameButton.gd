extends TextureButton

func _on_menuButton_pressed():
	MusicController.play_sound("click")
	get_tree().change_scene("res://menu.tscn")


func _on_soundButton_toggled(button_pressed):
	MusicController.toggle(button_pressed)


func _on_soundButton_pressed():
	MusicController.play_sound("click")
