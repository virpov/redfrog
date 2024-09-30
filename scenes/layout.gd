extends Node2D

var distance = Vector2(15, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.normie_following:
		$"Quests/Quest Norminette".position = $Player.position - distance
