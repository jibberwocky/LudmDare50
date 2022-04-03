extends Node2D

signal Game_Over

var game_counting = false
var is_game_over = false
var time_counter := 0.0
var clocks_shot := 0 

func go_to_game_over():
	if(!is_game_over):
		emit_signal("Game_Over")
		is_game_over = true
		game_counting = false

func reset():
	randomize()
	is_game_over = false
	time_counter = 0
	game_counting = true
	clocks_shot = 0

func _process(delta):
	if(game_counting):
		time_counter += delta
