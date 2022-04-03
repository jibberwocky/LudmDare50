extends Node

onready var current_level = $MainMenu

var next_level = null

func _ready():
	current_level.connect("level_changed", self, "handle_level_change")

func handle_level_change(next_level_name: String):
	next_level = load(next_level_name).instance()
	update_loaded_level()


func update_loaded_level():
	add_child(next_level)
	current_level.cleanup()
	current_level = next_level
	current_level.connect("level_changed", self, "handle_level_change")
	next_level = null

#handle quit requests
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior
