extends Area2D

var clock_indicator = preload("res://Effects/ClockIndicator.tscn")
const ExplodeEffect = preload("res://Effects/Clock_Explosion.tscn")
export var SE_clock_noise : AudioStreamSample
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = randi() % 5
	$Timer.start(rand_range(0.5, 10))
	


func _on_Timer_timeout():
	var new_indicator = clock_indicator.instance()
	self.add_child(new_indicator)
	new_indicator.position = Vector2.ZERO
	

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left")\
	and event.pressed:
		var effect = ExplodeEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position
		GameState.clocks_shot += 1
		$SE_player.play_sound_effect(SE_clock_noise)
		queue_free()



	
