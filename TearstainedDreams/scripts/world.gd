extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scenes()
	if global.housetear_collected==true:
		if Input.is_action_pressed("path"):
			$path.visible = true
		elif Input.is_action_just_released("path"):
			$path.visible = false

func _on_houseentrance_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "houseentry")
		
func change_scenes():
	if global.transition_scene == true:
		
			global.finish_changescenes()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		$Intructions.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		$Intructions.visible = false


func _on_foresttransition_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/forest.tscn")
