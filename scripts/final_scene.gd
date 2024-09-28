extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/splash_screen.tscn")
	if Dialogic.current_timeline != null:
		Dialogic.end_timeline()
