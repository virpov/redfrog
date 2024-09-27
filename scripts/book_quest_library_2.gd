extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	Global.freeze_player()
	start_dialog()

func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("questLibrary2")
	get_viewport().set_input_as_handled()

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	$CollisionShape2D.queue_free()
	get_tree().change_scene_to_file("res://scenes/final_scene.tscn")
