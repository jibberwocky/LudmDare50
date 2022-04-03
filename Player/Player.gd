extends KinematicBody2D

export var move_speed := 10000
export var FRICTION := 2000

const GRAVITY := 100

var velocity := Vector2.ZERO
var facing_direction := Vector2.ZERO

onready var player_states = {"Run":"_player_state_run", "Die":"_player_state_die"}
onready var state = "Run"

onready var run_animator := $Animate_player_body
onready var _sprite := $Sprite


onready var front_arm = $Front_Arm
onready var back_arm = $Back_Arm

onready var arms := [front_arm, back_arm]

var active_arm := 0
var indoors:= false

func _ready():
	GameState.connect("Game_Over", self, "die")
	pass
	
func _process(delta):
	call(player_states[state], delta)
	guns_follow_mouse()
	if(Input.is_action_just_pressed("mouse_left")):
		arms[active_arm].play("Fire")
		active_arm = wrapi(active_arm+1, 0, 2)
		
func _player_state_run(delta):
	var input_left = Input.is_action_pressed("move_left")
	var input_right = Input.is_action_pressed("move_right")
	var input_up = Input.is_action_pressed("move_up")
	var input_down = Input.is_action_pressed("move_down")

	var horizontal_input := float(input_right) - float(input_left)
	var input_direction = Vector2(float(input_right) - float(input_left), float(input_down) - float(input_up))
	input_direction = input_direction.normalized()
	if input_direction != Vector2.ZERO:
		run_animator.play("run")
		velocity = input_direction * move_speed * delta
		flip_sprite(input_direction.x < 0)
	else:
		run_animator.play("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	
func flip_sprite(flip:bool):
	if(flip):
		front_arm.position.x = 5
		back_arm.position.x = -6
	else:
		front_arm.position.x = -5
		back_arm.position.x = 6
	if(front_arm.flip_v != flip):
		active_arm = wrapi(active_arm+1, 0, 2)
	front_arm.flip_v = flip
	back_arm.flip_v = flip
	_sprite.flip_h = flip
	
func guns_follow_mouse():
	arms[active_arm].look_at(get_global_mouse_position())
	arms[wrapi(active_arm +1, 0, 2)].rotation = lerp(arms[wrapi(active_arm +1, 0, 2)].rotation, -80,0.3)
	

func die():
	run_animator.play("die")
	state = "Die"

func _player_state_die(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION *0.5 * delta)
	velocity = move_and_slide(velocity, Vector2.UP)
