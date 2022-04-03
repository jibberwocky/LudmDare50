extends KinematicBody2D

onready var sprite = $AnimatedSprite
export var SE_gunshot : AudioStreamSample

func _ready():
	GameState.connect("Game_Over", self, "shoot_player")

func go_to_game_over():
	add_to_group("Player", false)
	GameState.go_to_game_over()
	
func shoot_player():
	$SE_player.play_sound_effect(SE_gunshot)
	sprite.play("Shoot")


func _on_Danger_Zone_danger_zone_clicked():
	go_to_game_over()


func _on_AnimatedSprite_animation_finished():
	sprite.play("Idle")
