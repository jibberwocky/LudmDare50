extends Node2D

var time_remaining = 30
var timer_max_wait_time = 30
export var SE_clock_noise : AudioStreamSample

func _ready():
	pass # Replace with function body.

func _process(delta):
	time_remaining -= delta
	if(time_remaining <= 0):
		GameState.go_to_game_over()
		time_remaining = 0
	elif(time_remaining <= timer_max_wait_time*0.25) and !GameState.is_game_over:
		$SE_player.play_sound_effect(SE_clock_noise)
	var time_intensity = (timer_max_wait_time-time_remaining)/timer_max_wait_time
	$Sprite/Clock_hand.rotation_degrees = time_intensity*360
	
