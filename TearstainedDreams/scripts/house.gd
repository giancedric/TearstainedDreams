extends Node2D

var dialogue_shown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.game_first_loadin == true:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_house_posx
		$player.position.y = global.player_exit_house_posy
	$entity.visible = false
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
	


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


func _on_house_cutscene_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		$entity.visible = true
		$entity.play("summon")
		global.game_pause = true

func _on_house_cutscene_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		$entity.play("disappear")
		await $entity.animation_finished
		$entity.visible = false
		if $entity.visible == false:
			$tear.play("default")
			$tear.visible = true
			

func _on_entity_animation_finished() -> void:
	global.game_pause = false
	$entity.play("idle")
	if $entity.animation == "idle" and not dialogue_shown:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "houseentity")
		dialogue_shown = true
