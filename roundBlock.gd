extends TextureRect

var isEndBlock = false

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if isEndBlock && area.name == "kotki<3": 
		var level = get_tree().get_root().get_node("Level")
		level.roundEnd = true
		level.get_node("UI/TextureRect/backButtonContainer/VBoxContainer/reverseButton").disabled = true
		level.isWon()
		print("END")
