extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isEndBlock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func onCollisionEnter(area):
	if isEndBlock: 
		get_tree().get_root().get_node("Level").roundEnd = true
		print("END")
	#print("collision")
	pass # Replace with function body.
