extends Sprite

onready var anim_player := $AnimationPlayer
onready var path_follow :PathFollow2D = get_parent()
onready var SunTimer := $SunTimer
onready var light := $Light2D
onready var audio := $AudioStreamPlayer2D

var time_remaining = 60
var timer_max_wait_time = 60
func _ready():
	GameState.connect("Game_Over", self, "game_over")
	

func _process(delta):
	time_remaining -= delta
	if(time_remaining <= 0):
		GameState.go_to_game_over()
		time_remaining = 0
	var sun_power = (timer_max_wait_time-time_remaining)/timer_max_wait_time
	path_follow.set_unit_offset(sun_power)
	light.energy = sun_power
	audio.volume_db = -10 + 5 * sun_power

func _on_SunArea2D_sun_clicked():
	anim_player.play("Hit")
	time_remaining += 0.4
	time_remaining = clamp(time_remaining, 0, timer_max_wait_time)


func _on_AnimationPlayer_animation_finished(anim_name):
	anim_player.play("RESET")

func game_over():
	audio.playing = false
