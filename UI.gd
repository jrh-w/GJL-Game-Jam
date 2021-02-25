extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var container = get_node("HBoxContainer/VBoxContainer/roundInfo/HBoxContainer")
onready var new_box = load("res://roundBlock.tscn")
onready var new_shape = load("res://shapeShell.tscn")

onready var square = load("res://colorPalette/square.png")
onready var circle = load("res://colorPalette/circle.png")
onready var Hexagon = load("res://colorPalette/Hexagon.png")
onready var triangle = load("res://colorPalette/triangle.png")

var colors = ["green", "blue", "yellow"]
var shapes = ["square", "circle", "Hexagon", "triangle"]

var colorTable = [[1, 2, 3], [1, 3, 3], [1, 1, 2]]
var shapeTable = [0, 2, 3, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_colors()
	pass # Replace with function body.

func get_colors(colorTab = colorTable, shapeTab = shapeTable):
	var box = null
	for colors in colorTab:
		box = new_box.instance()
		for number in shapeTable:
			var shape = new_shape.instance()
			shape.get_node("Sprite").texture = load("res://colorPalette/" + shapes[number] + ".png")
			shape.get_node("Sprite").modulate = Color(0, 0, 1, 1)
			box.get_node("MarginContainer/HBoxContainer").add_child(shape)
			#shape.get_node()
			pass
		container.add_child(box)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
