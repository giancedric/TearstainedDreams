extends Node2D

var enter = false

var player_in_range = false
var lever = false
var lever_on = false

var message_range = false
var runes_revealed = false
var message_read = false

var torch_range = false
var torch2_range = false
var torch_turned = false
var torch2_turned = false

var gemglow = false
var gemglow2 = false

var anim_played = false
var gem_offered = false
var dialogue_shown = false
var anim_finished = false
var tear2 = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.current_scene = "dungeon"
	global.game_pause = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and lever == false and torch_turned == true and torch2_turned == true:
		$"!".visible = true
		on_lever()
	else:
		$"!".visible = false
	if message_range and runes_revealed:
		$"!2".visible = true
		read_runes()
	else:
		$"!2".visible = false
	if Input.is_action_just_pressed("path"):
		$puzzle2.visible = true
		runes_revealed = true
	if torch_range and message_read:
		turn_torch()
		$"!3".visible = true
	else:
		$"!3".visible = false
	if torch2_range and message_read:
		turn_torch2()
		$"!4".visible = true
	else:
		$"!4".visible = false
	if torch_turned and torch2_turned and lever_on == false:
		$lever.visible = true
	if $lever.visible == false and $leveron.visible == false:
		$lever/levercollision.collision_layer = 0
		$lever/levercollision.collision_mask = 0
		$leveron/leveroncollision.collision_mask = 0
		$leveron/leveroncollision.collision_layer = 0
	else:
		$lever/levercollision.collision_layer = 1
		$lever/levercollision.collision_mask = 1
		$leveron/leveroncollision.collision_mask = 1
		$leveron/leveroncollision.collision_layer = 1
	if global.offered and anim_played == false:
		$tear.visible = true
		$tear.play()
		anim_played = true
	if not dialogue_shown and tear2 and $tear2.visible:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemoffered")
		dialogue_shown = true
		tear2 = true
	if global.transition_scene == true:
		$ColorRect/AnimationPlayer.play("fadein")
func _on_leverflip_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true


func _on_leverflip_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false

func on_lever():
	if Input.is_action_just_pressed("interact"):
		lever = true
		$leveron.visible = true
		lever_on = true
		if lever_on:
			$lever.visible = false
			$gatecollision.collision_layer = 0
			$gatecollision.collision_mask = 0
			$gate.visible = false
			$gate2.visible = false
			


func _on_message_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		message_range = true


func _on_message_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		message_range = false
		
func read_runes():
	if Input.is_action_just_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "read")
		message_read = true
		enter = true
		


func _on_torchturn_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		torch_range = true


func _on_torchturn_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		torch_range = false

func turn_torch():
	if Input.is_action_just_pressed("interact"):
		$torchup.visible = false
		$torchdown.visible = true
		torch_turned = true


func _on_torchturn_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		torch2_range = true


func _on_torchturn_2_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		torch2_range = false
		
func turn_torch2():
	if Input.is_action_just_pressed("interact"):
		$torchup2.visible = false
		$torchdown2.visible = true
		torch2_turned = true



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if enter == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "dungeonenter")


func _on_gemglow_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if gemglow == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemglow")
			gemglow = true

func _on_gemglow_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if gemglow2 == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemglow2")
			gemglow2 = true


func _on_statuegem_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if gemglow2 == true and gem_offered == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "gemoffer")
			gem_offered = true
	
func _on_tear_animation_finished() -> void:
	$tear.visible = false
	$tear2.visible = true
	$tear2.play()

func _on_tear_2_animation_finished() -> void:
	$tear2.visible = false
	tear2 = true
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/dream.tscn")
