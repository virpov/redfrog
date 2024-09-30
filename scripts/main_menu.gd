extends Control

func _on_startnew_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/layout.tscn")


func _on_creditsred_frog_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Credits.tscn")


func _on_return_0_pressed() -> void:
	get_tree().quit()
