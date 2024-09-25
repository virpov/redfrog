extends CharacterBody2D

@export var enemy: Resource
@export var speed: int
var player_chase = false
var player = null
var fight = false


func _physics_process(delta):
	if !fight:
		if player_chase:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("walk")
			if (player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _on_fight_area_body_entered(body: Node2D) -> void:
	fight = true
	BattleManager.current_enemy = self
	BattleManager.enemy_resource = enemy
	BattleManager.start_battle()
