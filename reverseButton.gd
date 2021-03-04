extends TextureButton

func _on_reverseButton_pressed():
	get_tree().get_root().get_node("Level").reverse_round()
