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

var time = 0
signal timeout

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
		while history.size() > 0:
			var route = history.pop_front()
			get_node("innerGame/" + route.card).rest_point.deselect()
			get_node("innerGame/" + route.card).rest_point = route.from
			get_node("innerGame/" + route.card).rest_point.select()
			if !route.doneWhilePaused:
				currentRound -= 1
				get_node("UI/TextureRect").offset -= 93
				
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()
			
		for drop in get_tree().get_nodes_in_group("zone"):
			drop.init()
		
		get_tree().get_root().get_node("Level/UI/TextureRect/backButtonContainer/VBoxContainer/reverseButton").disabled = false
		roundEnd = false
				
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
		#if !route.from.busy:
		get_node("innerGame/" + route.card).rest_point.deselect(true)
		get_node("innerGame/" + route.card).rest_point = route.from
		get_node("innerGame/" + route.card).rest_point.select()
		if !route.doneWhilePaused:
			get_node("UI/TextureRect").offset -= 93
			currentRound -= 1
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()
		#else:
		#history.push_front(route)

func isWon():
	var areAllMatched = true
	
	for cube in get_tree().get_nodes_in_group("kotki"):
		if areAllMatched && cube.onMatchingPos:
			areAllMatched = true
		else:
			areAllMatched = false
		
	yield(get_tree().create_timer(1.0), "timeout")
		
	if roundEnd:
		isLost = true
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.get_node("pobrane").modulate = "666666"
			cube.get_node("onPaused").visible = false
		#get_node("UI").lost()
	elif areAllMatched:
		isWon = true
		get_node("UI").won()
