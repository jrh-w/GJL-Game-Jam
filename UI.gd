extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var container = get_node("MarginContainer/HBoxContainer")
onready var new_box = load("res://roundBlock.tscn")
onready var new_shape = load("res://shapeShell.tscn")

onready var square = load("res://colorPalette/square.png")
onready var circle = load("res://colorPalette/circle.png")
onready var Hexagon = load("res://colorPalette/Hexagon.png")
onready var triangle = load("res://colorPalette/triangle.png")

var colorDict = {
	"blue": Color(0.298, 0.2588, 0.5882),
	"orange": Color(1, 0.3922, 0.2392),
	"light_blue": Color(0.5608, 0.7765, 0.8784),
	"green": Color(0.6078, 0.8118, 0.4392),
	"yellow": Color(1, 0.7451, 0.3608)
}
var shapes = ["square", "circle", "Hexagon", "triangle"]

var colorTable = [["light_blue", "green", "yellow"], ["orange", "blue", "green"], 
			["yellow", "orange", "light_blue"]]
var shapeTable = [0, 2, 3]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_colors()
	pass # Replace with function body.

func get_colors(colorTab = colorTable, shapeTab = shapeTable):
	var box = null
	for colors in colorTab:
		box = new_box.instance()
		var color = 0
		for number in shapeTable:
			print(colors[color]) # Current color of shape
			var shape = new_shape.instance()
			shape.get_node("Sprite").texture = load("res://colorPalette/" + shapes[number] + ".png")
			shape.get_node("Sprite").modulate = colorDict[colors[color]]
			box.get_node("MarginContainer/HBoxContainer").add_child(shape)
			#shape.get_node()
			color = color + 1
		container.add_child(box)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
