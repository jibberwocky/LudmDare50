extends AnimatedSprite



func _on_Front_Arm_animation_finished():
	play("idle")


func _on_Back_Arm_animation_finished():
	play("idle")
