extends KinematicBody2D

var velocity = Vector2.ZERO
export var friction = 600
export var max_speed = 600 
export var acceleration = 300

export var clock_spawn_min := 1
export var clock_spawn_max := 3

onready var _sprite = $Sprite
onready var _animation = $Animate_body

onready var start_position := global_position
onready var target_position := global_position

export var wander_range := 100

var clock = preload("res://Characters/Clocks.tscn")

func _ready():
	pass # Replace with function body.

func _process(delta):
	accelerate_toward_point(target_position, delta)

func accelerate_toward_point(target_position, delta):
	var direction =  global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	_sprite.flip_h = velocity.x < 0
	if(velocity != Vector2.ZERO):
		_animation.play("run")
	velocity = move_and_slide(velocity)
	if(position + velocity*2 >= target_position):
		update_target_position()


func update_target_position():
	var target_vector = Vector2(rand_range(wander_range, -wander_range),rand_range(wander_range, -wander_range))
	target_position = start_position + target_vector


func _on_Wander_reset_timeout():
	update_target_position()


func _on_Clock_spawn_timer_timeout():
	var spwaned_clock = clock.instance()
	var ysort = self.get_parent()
	ysort.add_child(spwaned_clock)
	spwaned_clock.global_position = position
	var spawn_adjust = floor(GameState.time_counter/60)  
	$Clock_spawn_timer.start(rand_range(
		max(clock_spawn_min-spawn_adjust, 0.1),max(clock_spawn_max-spawn_adjust,1)))
