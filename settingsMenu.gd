extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var optionMenu = get_node("HBoxContainer/optionMenu")
onready var fullscreenOption = get_node("fullscreen/isFullscreen")

const CONFIG_PATH = "res://config.cfg" # change to 'user://...' after finishing up
var configFile = ConfigFile.new()

var settings = {
	"screen": {
		"resolution": 0,
		"fullscreen": false
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	add_resolutions()
	load_settings(CONFIG_PATH)
	apply_settings()
	optionMenu.connect("item_selected", self, "change_resolution")

func add_resolutions():
	optionMenu.add_item("1024x600", 0)
	optionMenu.add_item("1280x720", 1)
	optionMenu.add_item("1366x768", 2)
	optionMenu.add_item("1440x900", 3)
	optionMenu.add_item("1600x900", 4)
	optionMenu.add_item("1920x1080", 5)
	pass

func change_resolution(id):
	settings.screen.resolution = id
	OS.set_window_position(Vector2(0, 0))
	if id == 0:
		OS.set_window_size(Vector2(1024, 600))
	elif id == 1:
		OS.set_window_size(Vector2(1280, 720))
	elif id == 2:
		OS.set_window_size(Vector2(1366, 768))
	elif id == 3:
		OS.set_window_size(Vector2(1440, 900))
	elif id == 4:
		OS.set_window_size(Vector2(1600, 900))
	elif id == 5:
		OS.set_window_size(Vector2(1920, 1080))
	save_settings(CONFIG_PATH)

func _on_isFullscreen_pressed():
	settings.screen.fullscreen = fullscreenOption.pressed
	if fullscreenOption.pressed:
		OS.set_window_fullscreen(true)
		optionMenu.disabled = true
	else:
		OS.set_window_fullscreen(false)
		optionMenu.disabled = false
	save_settings(CONFIG_PATH)

func save_settings(path):
	for section in settings.keys():
		for key in settings[section]:
			configFile.set_value(section, key, settings[section][key])
	configFile.save(path)

func load_settings(path):
	var file = configFile.load(path)
	if file != OK:
		print("Error while loading user settings")
		return []
	
	# Get values from config file - section by section, key by key
	for section in settings.keys():
		for key in settings[section].keys():
			settings[section][key] = configFile.get_value(section, key, null)

func apply_settings():
	optionMenu.select(settings.screen.resolution)
	change_resolution(settings.screen.resolution)
	fullscreenOption.pressed = settings.screen.fullscreen
	_on_isFullscreen_pressed()
	pass
