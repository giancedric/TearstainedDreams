extends Node2D

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
		
