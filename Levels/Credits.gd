extends Level

func _on_Play_button_pressed():
	emit_signal("level_changed", "res://Levels/MainMenu.tscn")
