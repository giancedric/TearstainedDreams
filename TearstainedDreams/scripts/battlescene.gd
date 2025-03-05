extends Node2D

@export var enemy: Resource = null


var anim_finished = false
var spawned = false

var fade_in_progress = false
var fade_speed = 0.5  
var fade_in_done = false

var dialogue = false
var death = false
var final = true
var echo = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/enemy.modulate.a = 0  # Start fully transparent
	set_health($Panel/ProgressBar, global.current_health, global.max_health)
	set_health($VBoxContainer/ProgressBar, enemy.health, enemy.max_health)
	$VBoxContainer/enemy.sprite_frames = enemy.idle_animation
	global.current_scene = "battle"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if anim_finished and not spawned:
		$spawn.play()
		spawned = true
		
	if fade_in_progress:
		$VBoxContainer/enemy.modulate.a = min($VBoxContainer/enemy.modulate.a + fade_speed * delta, 1.0)
		if $VBoxContainer/enemy.modulate.a >= 1.0:
			fade_in_progress = false 
			fade_in_done = true
	if fade_in_done and not dialogue:
			$Actions.visible = true
			$Panel.visible = true
			$VBoxContainer/ProgressBar.visible = true
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "enterattack")
			dialogue = true
	if global.current_health == 1 and not death:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemdeath")
		death = true
		
		$Actions/HBoxContainer/Attack.disabled = true
		await DialogueManager.dialogue_ended
		$Actions/HBoxContainer/Defend.text = "Echoed Tear"
		
		echo = true
		
		
		set_health($Panel/ProgressBar, global.current_health, global.max_health)
		
	if Input.is_action_just_pressed("interact") and final:
			$PulsingButton.visible = false
			global.current_health = 50
			$VBoxContainer/enemy.visible = false
			$VBoxContainer/AnimatedSprite2D.visible = true
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "smokedefeat")
			await DialogueManager.dialogue_ended
			$fog.layer = -1
			if $fog.layer == -1:
				$ColorRect.visible = true
				$ColorRect/AnimationPlayer.play("new_animation")

		

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	anim_finished = true


func _on_spawn_animation_finished() -> void:
		$spawn.visible = false
		$VBoxContainer/enemy.visible = true
		fade_in_progress = true
		$VBoxContainer/enemy.play("default")
		



func _on_attack_pressed() -> void:
	if enemy.health >= 80:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "attack")
		enemy.health = max(0, enemy.health - global.damage)
		set_health($VBoxContainer/ProgressBar, enemy.health, enemy.max_health)
		$VBoxContainer/enemy.play("damaged")
		await DialogueManager.dialogue_ended
		$VBoxContainer/enemy.play("default")
		enemy_turn()
	elif enemy.health <= 80:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "attackphase2")
		enemy.health = max(0, enemy.health - global.damage)
		set_health($VBoxContainer/ProgressBar, enemy.health, enemy.max_health)
		$VBoxContainer/enemy.play("damaged")
		await DialogueManager.dialogue_ended
		$VBoxContainer/enemy.play("default")
		enemy_turn()
	
func enemy_turn():

		
	if global.current_health <= 10:
		
		global.current_health = max(0, global.current_health - 9)
		set_health($Panel/ProgressBar, global.current_health, global.max_health)
		$VBoxContainer/enemy.play("attack")
		await $VBoxContainer/enemy.animation_finished
		$VBoxContainer/enemy.play("default")
	elif global.current_health <= 59:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "enemyattack2")
		global.current_health = max(0, global.current_health - enemy.damage)
		set_health($Panel/ProgressBar, global.current_health, global.max_health)
		$VBoxContainer/enemy.play("attack")
		await $VBoxContainer/enemy.animation_finished
		$VBoxContainer/enemy.play("default")
	elif global.current_health >= 60:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "enemyattack")
		global.current_health = max(0, global.current_health - enemy.damage)
		set_health($Panel/ProgressBar, global.current_health, global.max_health)
		$VBoxContainer/enemy.play("attack")
		await $VBoxContainer/enemy.animation_finished
		$VBoxContainer/enemy.play("default")
	

func _on_defend_pressed() -> void:
	if $Actions/HBoxContainer/Defend.text == "Echoed Tear" and echo:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemlast")
		await DialogueManager.dialogue_ended
		
		$Actions/HBoxContainer/Defend.disabled = true
		$PulsingButton.visible = true
		final = true

	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "defend")


func _on_run_pressed() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "run")
