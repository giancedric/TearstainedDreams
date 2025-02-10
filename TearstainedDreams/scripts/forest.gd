extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.current_scene = "forest"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path()

func path():
	if global.housetear_collected==true:
		if Input.is_action_pressed("path"):
			$path.visible = true
		elif Input.is_action_just_released("path"):
			$path.visible = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "forestenter")


func _on_changetomysticalforest_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/dungeon_entrance.tscn")
		global.current_scene = "dungeonentrance"
