extends Node2D

const OFFSET = 94

var history = [] # History of our moves

var roundEnd = false

var isWon = false
var isLost = false

var paused = false

var onlyOneSelected = true

var rounds = 1
var currentRound = 0

var time = 0
signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	rounds = get_node("UI/TextureRect").colorTable.size()

func new_log(name, a, b, isExecuted):
	var n = {
		"card": name,
		"from": a,
		"to": b,
		"doneWhilePaused": paused,
		"moveExecuted": isExecuted,
		"padlockUnlocked": null
	}
	if !roundEnd: 
		var isSkip = (b.function == "skip" || b.function == "back")
		if !paused && !isSkip:
			currentRound += 1
			# Such is the needed transition between the blocks
			get_node("UI/TextureRect").offset += OFFSET
		history.push_front(n)

func update_log(padlockId):
	var route = history.pop_front()
	route.padlockUnlocked = padlockId
	history.push_front(route)

func restart_round():
	
	MusicController.play_sound("click")
	
	if !isWon:
	
		while history.size() > 0:
			var route = history.pop_front()
			get_node("innerGame/" + route.card).rest_point.deselect(true)
			get_node("innerGame/" + route.card).rest_point = route.from
			get_node("innerGame/" + route.card).rest_point.select(true)
			if route.to.function == "back" && route.moveExecuted:
				get_node("UI/TextureRect").offset += route.moveExecuted * OFFSET
				currentRound += route.moveExecuted
			elif route.to.function == "skip" && route.moveExecuted:
				get_node("UI/TextureRect").offset -= route.moveExecuted * OFFSET
				currentRound -= route.moveExecuted
			elif !route.doneWhilePaused && route.moveExecuted:
				get_node("UI/TextureRect").offset -= OFFSET
				currentRound -= 1
				
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()
			
		for drop in get_tree().get_nodes_in_group("zone"):
			drop.init()
		
		roundEnd = false
		
	isLost = false
	isWon = false

func forwardTwoRounds():
	print("robi sie")
	if currentRound <= rounds - 2:
		currentRound += 2
		get_node("UI/TextureRect").offset += 2 * OFFSET
		return 2
	elif currentRound == rounds - 1:
		currentRound += 1
		get_node("UI/TextureRect").offset += OFFSET
		return 1
	else: return 0

func backTwoRounds():
	if currentRound >= 2:
		currentRound -= 2
		get_node("UI/TextureRect").offset -= 2 * OFFSET
		return 2
	elif currentRound == 1:
		currentRound -= 1
		get_node("UI/TextureRect").offset -= OFFSET
		return 1
	else: return 0

func reverse_round():
	
	get_node("UI/TextureRect/backButtonContainer/VBoxContainer/restartButton").turnNormal()
	get_node("UI/TextureRect/LastTour").on = false
	
	if isLost: isLost = false
	
	MusicController.play_sound("click")
	
	if history.size() > 0 && !isWon:
		
		var route = history.pop_front()
		
		if route.from.function == "padlock":
			route.from.open()
			
		get_node("innerGame/" + route.card).rest_point.deselect(true)
		get_node("innerGame/" + route.card).rest_point = route.from
		get_node("innerGame/" + route.card).rest_point.select(true)
		
		print(route.padlockUnlocked)
		# If not null, a padlock was unlocked
		if route.padlockUnlocked != null:
			# Array starts at 0, so index must be decremented
			get_tree().get_nodes_in_group("zone")[route.padlockUnlocked - 1].init()

		if route.to.function == "back" && route.moveExecuted:
			get_node("UI/TextureRect").offset += route.moveExecuted * OFFSET
			currentRound += route.moveExecuted
		elif route.to.function == "skip" && route.moveExecuted:
			get_node("UI/TextureRect").offset -= route.moveExecuted * OFFSET
			currentRound -= route.moveExecuted
		elif !route.doneWhilePaused && route.moveExecuted:
			get_node("UI/TextureRect").offset -= OFFSET
			currentRound -= 1
		for cube in get_tree().get_nodes_in_group("kotki"):
			cube.updateColor()

func isWon():
	var areAllMatched = true
	print("checking")
	for cube in get_tree().get_nodes_in_group("kotki"):
		if areAllMatched && cube.onMatchingPos:
			areAllMatched = true
		else:
			areAllMatched = false
	
	if areAllMatched:
		if !isWon:
			print("allmatched")
			MusicController.play_sound("win")
			isWon = true
		
			yield(get_tree().create_timer(0.5), "timeout")
			get_node("UI").won()
	elif roundEnd:
			MusicController.play_sound("lose")
			isLost = true
			get_node("UI/TextureRect/backButtonContainer/VBoxContainer/restartButton").turnOrange()
			get_node("UI/TextureRect/LastTour").on = true
