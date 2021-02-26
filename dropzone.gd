extends Position2D

var busy = false
var color = '#8fc6e0'

func select():
	$box2.modulate = color
	busy = true
	
func deselect():
	busy = false
