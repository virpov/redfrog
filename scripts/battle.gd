extends Control


var shield: int = 10
var enemy_resource: Resource
var current_player_health: int = 0
var current_enemy_health: int = 0
var is_defending: bool = false


signal textbox_closed


func prepare_battle(enemy_resource: Resource):
	self.enemy_resource = enemy_resource
	set_health(State.current_health, State.max_health, $PlayerPanel/HBoxContainer/HealthBar)
	set_health(self.enemy_resource.current_health, self.enemy_resource.max_health, $EnemyInfo/HealthBar)
	$EnemyInfo/EnemyTexture.texture = self.enemy_resource.texture
	$Background.texture = self.enemy_resource.background
	$EnemyInfo/Name.text = self.enemy_resource.name
	$PlayerPanel/HBoxContainer/PlayerName.text = State.player_name
	
	current_player_health = State.current_health
	current_enemy_health = self.enemy_resource.current_health
	$TextPanel.hide()
	$ActionPanel.hide()
	display_text(self.enemy_resource.enemy_spawn_text)
	await textbox_closed
	$ActionPanel.show()


func _input(Event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextPanel.visible:
		$TextPanel.hide()
		emit_signal('textbox_closed')
		
func display_text(text):
	if $ActionPanel.visible:
		$ActionPanel.hide()
	$TextPanel.show()
	$TextPanel/Text.text = text
	
func set_health(health, max_health, progress_bar):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("HP").text = "HP: %d/%d" % [health, max_health]


func _on_run_pressed() -> void:
	if randi_range(0, 100) > self.enemy_resource.run_percent:
		display_text("You failed to escape!")
		await textbox_closed
		enemy_turn()
	else:
		display_text("Got away safely")
		await textbox_closed
		State.current_health = current_player_health
		BattleManager.end_battle()
	 # Replace with function body.

func enemy_turn():
	var random_number = randi_range(0, (self.enemy_resource.attack_phrases.size()-1))
	display_text(self.enemy_resource.attack_phrases[random_number])
	await textbox_closed
	if is_defending:
		is_defending = false
		current_player_health = max(0, current_player_health - max(0, (self.enemy_resource.damage - (State.player_armour + shield))))
		set_health(current_player_health, State.max_health, $PlayerPanel/HBoxContainer/HealthBar)
		$AnimationPlayer.play("screen_shake")
		await $AnimationPlayer.animation_finished
		display_text("%s dealt %d damage!" % [self.enemy_resource.name, max(0, (self.enemy_resource.damage - (State.player_armour + shield)))])
		await textbox_closed
	else:
		current_player_health = max(0, current_player_health - max(0, self.enemy_resource.damage - State.player_armour))
		set_health(current_player_health, State.max_health, $PlayerPanel/HBoxContainer/HealthBar)
		$AnimationPlayer.play("screen_shake")
		await $AnimationPlayer.animation_finished
		display_text("%s dealt %d damage!" % [self.enemy_resource.name, self.enemy_resource.damage])
		await textbox_closed
	
	if current_player_health <= 0:
		display_text("You dead!")
		await textbox_closed
		self.hide()
		State.current_health = current_player_health
		
	if !$ActionPanel.visible:
		$ActionPanel.show()
	

func _on_attack_pressed() -> void:
	display_text("No way %s" % [self.enemy_resource.name])
	await textbox_closed
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health(current_enemy_health, self.enemy_resource.max_health, $EnemyInfo/HealthBar)
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	display_text("%s dealt %d damage!" % [State.player_name, State.damage])
	await textbox_closed
	if current_enemy_health <= 0:
		$AnimationPlayer.play("enemy_dead")
		await $AnimationPlayer.animation_finished
		display_text("%s was defeated!" % self.enemy_resource.name)
		await textbox_closed
		State.current_health = current_player_health
		BattleManager.end_battle()
	else:
		enemy_turn()



func _on_defend_pressed() -> void:
	is_defending = true
	display_text("You prepare defensively")
	await textbox_closed
	enemy_turn()
	
