extends Node

var speed = 100

func freeze_player():
	self.speed = 0
	
func unfreeze_player():
	self.speed = 100
