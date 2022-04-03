extends Area2D
signal danger_zone_clicked

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left")\
	and event.pressed:
		emit_signal("danger_zone_clicked")
		
	
