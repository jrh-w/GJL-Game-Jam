extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_menuButton_pressed():
	MusicController.quiet()
	MusicController.play_sound("click")
	get_tree().change_scene("res://menu.tscn")


func _on_soundButton_toggled(button_pressed):
	MusicController.toggle(button_pressed)


func _on_soundButton_pressed():
	MusicController.play_sound("click")
