extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "dungeonentrance")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/dungeon.tscn")
		global.current_scene = "dungeon"
