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

var offset = 0 # 93 is the space between one block

var colorDict = {
	"blue": Color(0.298, 0.2588, 0.5882),
	"orange": Color(1, 0.3922, 0.2392),
	"light_blue": Color(0.5608, 0.7765, 0.8784),
	"green": Color(0.6078, 0.8118, 0.4392),
	"yellow": Color(1, 0.7451, 0.3608)
}
var shapes = ["square", "circle", "Hexagon", "triangle"]

var colorTable = [["light_blue", "green", "yellow", "orange"], ["orange", "blue", "green", "light_blue"], 
			["yellow", "orange", "light_blue", "blue"]]
var shapeTable = [0, 2, 3, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_colors()
	#get_node("MarginContainer2").position.x = 287
	#get_node("MarginContainer2").position.y = 500
	#print(get_node("MarginContainer2/HBoxContainer/Arrow").rect_global_position)
	#print(get_node("MarginContainer2/HBoxContainer/Arrow").get_size())
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
	box = new_box.instance()
	box.isEndBlock = true
	# Add "End" PNG <-----------------------------------
	container.add_child(box)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vect = Vector2(container.get_child(0).get_size() * container.get_child_count())
	vect.x = (container.get_global_rect().size.x / 2) - (vect.x / 2) - (6 * (get_viewport().size.x / 1024)) + offset
	vect.y = get_node("arrowContainer").rect_position.y
	#print(6 * (get_viewport().size.x / 1024))
	get_node("arrowContainer").set_position(vect)
	pass