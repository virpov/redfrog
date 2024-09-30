extends CharacterBody2D
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if Dialogic.current_timeline != null:
		return
	Global.freeze_player()
	start_dialog()

func start_dialog():
	Dialogic.timeline_ended.connect(_on_timeline_ended2)
	Dialogic.start("questNorminette")
	get_viewport().set_input_as_handled()

func _on_timeline_ended2():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended2)
	$Area2D/CollisionShape2D.queue_free()
	Global.normie_following = true
	Global.unfreeze_player()
