extends Node2D

var dialogue_shown = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.current_scene = "1st"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await $TextureRect/AnimationPlayer.animation_finished
	if not dialogue_shown:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "firstregret")
		dialogue_shown = true
		await DialogueManager.dialogue_ended
		get_tree().change_scene_to_file("res://scenes/battlescene.tscn")
	
