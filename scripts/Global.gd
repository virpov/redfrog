extends Node

var player_speed = 100
var player_current_speed = player_speed

func freeze_player():
	player_current_speed = 0
	
func unfreeze_player():
	player_current_speed = player_speed
