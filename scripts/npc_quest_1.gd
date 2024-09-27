extends CharacterBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return
	Global.freeze_player()
	start_dialog()


func start_dialog():
	$"../Player/Camera2D".zoom.x = 2
	$"../Player/Camera2D".zoom.y = 2
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("questFirstproject")
	get_viewport().set_input_as_handled()

func _on_timeline_ended():
	
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	$Area2D/CollisionShape2D.queue_free()
	Global.unfreeze_player()
