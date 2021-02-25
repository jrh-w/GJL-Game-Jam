extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var container = get_node("HBoxContainer/VBoxContainer/roundInfo/HBoxContainer")
onready var new_box = load("res://roundBlock.tscn")

var colors = ["green", "blue", "yellow"]
var shapes = ["box", "circle", "Hexagon", "square", "triangle"]

var colorTable = [[1, 2, 3], [1, 3, 3], [1, 1, 2]]
var shapeTable = [1, 3, 5]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_colors()
	pass # Replace with function body.

func get_colors(colorTab = colorTable, shapeTab = shapeTable):
	var shape = null
	for colors in colorTab:
		print("hi")
		shape = new_box.instance()
		for shapes in shapeTable:
			#var new_shape = 
			pass
		container.add_child(shape)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
