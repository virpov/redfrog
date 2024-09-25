extends CharacterBody2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	Dialogic.start('chapter01')
	get_viewport().set_input_as_handled()
