extends Camera2D


func _physics_process(delta):
	var midpoint := Vector2.ZERO
	if(!GameState.is_game_over):
		midpoint = get_global_mouse_position()
	var total_nodes := 1
	for player in get_tree().get_nodes_in_group("Player"):
		if(is_instance_valid(player)):
			midpoint += player.global_position
			total_nodes += 1
	midpoint = midpoint/total_nodes
	position = midpoint
	
