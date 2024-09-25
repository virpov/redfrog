extends Node

var player_name = "vlad"
var current_health = 35
var max_health = 35
var damage = 10
var player_speed = 100
var player_current_speed = player_speed
var player_armour = 10
var player_camera = null


func freeze_player():
	player_current_speed = 0
	
func unfreeze_player():
	player_current_speed = player_speed
	
func _process(delta: float) -> void:
	if current_health == 0:
		get_tree().quit()
