extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var history = [] # History of our moves

var roundEnd = false

var isWon = false
var isLost = false

var paused = false

var rounds = 1
var currentRound = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rounds = get_node("UI/TextureRect").colorTable.size()
	pass # Replace with function body.

func new_log(name, a, b):
	var n = {
		"card": name,
		"from": a,
		"to": b,
		"doneWhilePaused": paused
	}
	if !roundEnd: 
		if !paused:
			currentRound += 1
			# Such is the needed transition between the blocks
			get_node("UI/TextureRect").offset += 93
		history.push_front(n)
		#isWon()
		
func restart_round():
	if !roundEnd:
		while history.size() > 0:
			var route = history.pop_front()
			get_node("innerGame/" + route.card).rest_point.deselect()
			get_node("innerGame/" + route.card).rest_point = route.from
			if !route.doneWhilePaused:
				currentRound -= 1
				get_node("UI/TextureRect").offset -= 93
				
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()
			
		for drop in get_tree().get_nodes_in_group("zone"):
			drop.init()
				
func backTwoRounds():
	if !roundEnd && history.size() > 1:
		for i in range(2):
			var route = history.pop_front()
			get_node("innerGame/" + route.card).rest_point.deselect()
			get_node("innerGame/" + route.card).rest_point = route.from
			if !paused:
				currentRound -= 1
				get_node("UI/TextureRect").offset -= 93
			
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()

func reverse_round():
	if !roundEnd && history.size() > 0:
		var route = history.pop_front()
		get_node("innerGame/" + route.card).rest_point.deselect()
		get_node("innerGame/" + route.card).rest_point = route.from
		get_node("UI/TextureRect").offset -= 93
		currentRound -= 1
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()

func isWon():
	var areAllMatched = true
	
	for cube in get_tree().get_nodes_in_group("kotki"):
		if areAllMatched && cube.onMatchingPos:
			areAllMatched = true
		else:
			areAllMatched = false
	
	if areAllMatched:
		print('won')
		if roundEnd:
			isLost = true
			get_node("UI").lost()
		else:
			isWon = true
			get_node("UI").won()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
