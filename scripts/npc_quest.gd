extends CharacterBody2D

var player: Node2D
var timeline_finished = false

func _ready() -> void:
	player = get_tree().get_root().get_node("Player")  # Asegúrate de que la ruta es correcta
	
func _physics_process(delta):
	if player:
		if timeline_finished:
			AnimatedSprite2D.position += (player.position - AnimatedSprite2D.position) / Global.speed
		#if player:
		#	var direction = (player.global_position - global_position).normalized()
		#	velocity = direction * Global.speed
		#	move_and_slide()  # Asegúrate de pasar la velocity a move_and_slide
	
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
	timeline_finished = true
	Global.unfreeze_player()
