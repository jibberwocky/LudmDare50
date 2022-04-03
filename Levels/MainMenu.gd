extends Level

func _on_Play_button_pressed():
	GameState.reset()
	emit_signal("level_changed", "res://Levels/World.tscn")


func _on_AssetCredits_pressed():
	emit_signal("level_changed", "res://Levels/Credits.tscn")


func _on_How_To_Play_button_pressed():
	emit_signal("level_changed", "res://Levels/HowToPlay.tscn")
