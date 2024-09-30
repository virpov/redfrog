extends Node

var speed = 100
var normie_following = false

func freeze_player():
	self.speed = 0
	
func unfreeze_player():
	self.speed = 100
