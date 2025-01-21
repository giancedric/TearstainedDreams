extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.game_first_loadin == true:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_house_posx
		$player.position.y = global.player_exit_house_posy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	change_scenes()


func _on_house_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true


func change_scenes():
	if global.transition_scene == true:
		if global.current_scene == "house":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.game_first_loadin = false
			global.finish_changescenes()
