extends VBoxContainer

onready var level_normal = load("res://colorPalette/UI_Button_menu.png")
onready var level_pressed = load("res://colorPalette/UI_Button_menu_1.png")
onready var level_disabled = load("res://colorPalette/UI_Level_locked.png")

const SAVE_PATH = "user://savegame.save"

var isLocked = [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

# Called when the node enters the scene tree for the first time.
func _ready():
	defineLevelAccess()

func _enter_tree():
	print(get_node("/root/LevelMenu").isLocked)
	isLocked = get_node("/root/LevelMenu").isLocked
	defineLevelAccess()

func defineLevelAccess():
	load_progress()
	var level_buttons = get_tree().get_nodes_in_group("levels")
	var iterator = 0
	for button in level_buttons:
		if isLocked[iterator]:
			button.disabled = true
			button.texture_disabled = level_disabled
		else:
			button.disabled = false
			button.texture_normal = level_normal
			button.texture_pressed = level_pressed
		iterator += 1

func load_progress():
	var file = File.new()
	if file.file_exists(SAVE_PATH):
		var isOK = file.open(SAVE_PATH, File.READ)
		if isOK == OK:
			print("loading...")
			var data = file.get_line() # Digit line is recovered
			
			var levelInfo = []	
			for level in data:
				levelInfo.push_back(int(level))
				
			isLocked = levelInfo
			file.close()
		else:
			print("Error: Could not read save file")

func save_progress():
	var file = File.new()
	var isOK = file.open(SAVE_PATH, File.WRITE)
	if isOK == OK:
		print("saving...")
		
		var levelInfo = "" # Info about our levels will be stored digit after digit
		for level in isLocked:
			levelInfo += str(level)
			
		file.store_line(str(levelInfo))
		file.close()
	else:
		print("Error: Could not write to save file")
