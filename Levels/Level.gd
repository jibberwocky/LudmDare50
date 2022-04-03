extends Node
class_name Level

signal level_changed(target_level)

func cleanup():
	queue_free()
