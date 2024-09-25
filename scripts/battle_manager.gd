extends Node

var battle: Node
var battle_camera: Camera2D
var enemy_resource: Resource
var current_enemy: Node = null

func start_battle():
	battle.prepare_battle(enemy_resource)
	battle.show()
	State.freeze_player()
	BattleManager.battle_camera.make_current()
	

func end_battle():
	current_enemy.queue_free()
	battle.hide()
	State.player_camera.make_current()
	State.unfreeze_player()
