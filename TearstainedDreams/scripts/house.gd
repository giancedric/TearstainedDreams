extends Node2D

var housedialogue_shown = false
var dialogue_shown = false
var player_in_area = false

var cutscene_played = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.current_scene = "house"
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
	if player_in_area and $tear.visible:
		$interacttext.visible = true
		collect_tear()
	else:
		$interacttext.visible = false
	dialogue()

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
	if body.has_method("player") and not cutscene_played:
		$entity.visible = true
		$entity.play("summon")
		global.game_pause = true
		

func _on_house_cutscene_body_exited(body: Node2D) -> void:
	if body.has_method("player") and not cutscene_played:
		cutscene_played = true
		$entity.play("disappear")
		await $entity.animation_finished
		$entity.visible = false
		if $entity.visible == false:
			$tear.play("spawn")
			$tear.visible = true
			

func _on_entity_animation_finished() -> void:
	global.game_pause = false
	$entity.play("idle")
	if $entity.animation == "idle" and not dialogue_shown:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "houseentity")
		dialogue_shown = true


func _on_collectarea_body_entered(body: Node2D) -> void:
	if body.has_method("player") and $tear.visible == true:
		player_in_area = true


func _on_collectarea_body_exited(body: Node2D) -> void:
	if body.has_method("player") and $tear.visible == true:
			player_in_area = false

func collect_tear():
	if Input.is_action_just_pressed("interact"):
		global.housetear_collected = true
		$tear.play("pop")
		await $tear.animation_finished
		$tear.visible = false




func _on_tearbarrier_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if global.housetear_collected == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "tearbarrier")
			body.global_position.y -= 25


func dialogue():
	if global.housetear_collected == true and housedialogue_shown == false:
		housedialogue_shown = true
		await $tear.visibility_changed
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "tearexplain")
