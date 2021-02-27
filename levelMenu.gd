extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var level_normal = load("res://colorPalette/UI_Button_menu.png")
onready var level_pressed = load("res://colorPalette/UI_Button_menu_1.png")
onready var level_disabled = load("res://colorPalette/Padlock_0.png")

var isLocked = [0, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	defineLevelAccess()

func defineLevelAccess():
	var level_buttons = get_tree().get_nodes_in_group("levels")
	var iterator = 0
	for button in level_buttons:
		if isLocked[iterator]:
			button.disabled = true
			button.texture_disabled = level_disabled
			pass
		else:
			button.disabled = false
			button.texture_normal = level_normal
			button.texture_pressed = level_pressed
			pass
		iterator += 1

