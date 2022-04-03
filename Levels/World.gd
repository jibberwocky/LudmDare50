extends Level


func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	emit_signal("level_changed", "res://Levels/MainMenu.tscn")
