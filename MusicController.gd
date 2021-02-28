extends Node

func play_sound(type):
	
	if type == "drop":
		$SoundPlayer.stream = load(str("res://sounds/Block_Drop",randi()%3+1,".wav"))
		print($SoundPlayer.stream)
	elif type == "pick":
		$SoundPlayer.stream = load(str("res://sounds/Block_PickUp",randi()%3+1,".wav"))
	elif type == "click":
		$SoundPlayer.stream = load(str("res://sounds/Button_Click.wav"))
	elif type == "end":
		$SoundPlayer.stream = load(str("res://sounds/End_Button.wav"))
	elif type == "lockOpen":
		$SoundPlayer.stream = load(str("res://sounds/Lock_Open.wav"))
	elif type == "lockClose":
		$SoundPlayer.stream = load(str("res://sounds/Lock_Close.wav"))
		
	$SoundPlayer.play()

func quiet():
	
	$MusicPlayer.volume_db = -10
	
func loud():
	
	$MusicPlayer.volume_db = 0
