extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scenes()




func _on_houseentrance_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true
		
func change_scenes():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/house.tscn")
			global.finish_changescenes()
