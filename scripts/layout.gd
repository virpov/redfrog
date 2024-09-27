extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("quit")
		var fishdelete = get_tree().get_nodes_in_group($".")
		for fishthings in fishdelete:
			fishthings.queue_free()
		get_tree().change_scene_to_file()
