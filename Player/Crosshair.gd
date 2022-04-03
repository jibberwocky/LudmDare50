extends Area2D
const HitEffect = preload("res://Effects/Effect.tscn")
export var SE_gunshot : AudioStreamSample

func _process(delta):
	if(GameState.is_game_over): 
		visible = false 
		return
	position = get_global_mouse_position()
	if(Input.is_action_just_pressed("mouse_left")):
		_create_hit_effect(position)
		$SE_player.play_sound_effect(SE_gunshot)
		
func _create_hit_effect(position: Vector2):
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = position
