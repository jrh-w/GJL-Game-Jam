extends TextureRect

var isEndBlock = false

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if isEndBlock && area.name == "kotki<3": 
		var level = get_tree().get_root().get_node("Level")
		level.roundEnd = true
		level.isWon()
		print("END")


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if isEndBlock && area.name == "kotki<3": 
		var level = get_tree().get_root().get_node("Level")
		level.roundEnd = false
		level.isWon()
		print("DEFINITELY NOT END")
