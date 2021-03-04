extends TextureButton

func _on_exitButton_pressed():
	MusicController.play_sound("click")
	
	get_tree().quit()
