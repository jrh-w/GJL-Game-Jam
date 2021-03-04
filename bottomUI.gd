extends TextureRect

onready var container = get_node("MarginContainer/HBoxContainer")
onready var new_box = load("res://roundBlock.tscn")
onready var new_shape = load("res://shapeShell.tscn")

onready var square = load("res://colorPalette/square.png")
onready var circle = load("res://colorPalette/circle.png")
onready var Hexagon = load("res://colorPalette/Hexagon.png")
onready var triangle = load("res://colorPalette/triangle.png")

export (Array, Array, String, "yellow", "green", "light_blue", "blue", "orange") var colorTable# = [["light_blue", "green", "yellow", "orange"], ["orange", "yellow", "green", "light_blue"], 
			#["yellow", "green", "light_blue", "blue"], ["orange", "blue", "light_blue", "yellow"], ["yellow", "green", "orange", "light_blue"]]

var offset = 0 # 93 is the space between one block

var colorDict = {
	"blue": Color(0.298, 0.2588, 0.5882),
	"orange": Color(1, 0.3922, 0.2392),
	"light_blue": Color(0.5608, 0.7765, 0.8784),
	"green": Color(0.6078, 0.8118, 0.4392),
	"yellow": Color(1, 0.7451, 0.3608)
}
export (Array, String, "square", "circle", "Hexagon", "triangle") var shapes# = ["square", "circle", "Hexagon", "triangle"]

export (Array, int ) var shapeTable# = [3, 1, 2, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_colors()

func _enter_tree():
	get_node("menuButtonContainer/HBoxContainer/soundButton").pressed = MusicController.InternalPaused

func get_colors(colorTab = colorTable, shapeTab = shapeTable):
	var box = null
	var prev = []
	var id = 0
	print (colorTab.size())
	for colors in colorTab:
		box = new_box.instance()
		var color = 0
		if colors != prev:
			for number in shapeTable:
				var shape = new_shape.instance()
				shape.get_node("Sprite").texture = load("res://colorPalette/" + shapes[number] + ".png")
				shape.get_node("Sprite").modulate = colorDict[colors[color]]
				box.get_node("MarginContainer/HBoxContainer").add_child(shape)
				color = color + 1
		prev = colors
		id+=1
		if id >= colorTab.size():
			box.isEndBlock = true
		container.add_child(box)

func _physics_process(delta):
	var vect = Vector2(container.get_child(0).get_size() * container.get_child_count())
	vect.x += 3 * container.get_child_count()
	vect.x = (container.get_global_rect().size.x / 2) - (vect.x / 2) + offset
	vect.y = get_node("arrowContainer").rect_position.y
	get_node("arrowContainer").set_position( lerp(get_node("arrowContainer").rect_position, vect, 10 * delta) )
