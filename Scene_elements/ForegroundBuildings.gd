extends Sprite



var target_opacity := 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	modulate.a = lerp(modulate.a, target_opacity, delta * 1)

func _on_Area2D_body_entered(body):
	target_opacity = 0.1
	body.indoors = true


func _on_Area2D_body_exited(body):
	target_opacity = 1
	body.indoors = false
