extends Node2D

var anim_finished = false
var spawned = false

var fade_in_progress = false
var fade_speed = 0.5  # Adjust speed (higher = faster fade)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/enemy.modulate.a = 0  # Start fully transparent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if anim_finished:
		$spawn.play()
	if fade_in_progress:
		$VBoxContainer/enemy.modulate.a = min($VBoxContainer/enemy.modulate.a + fade_speed * delta, 1.0)
		if $VBoxContainer/enemy.modulate.a >= 1.0:
			fade_in_progress = false  # Stop fading when fully visible

	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	anim_finished = true


func _on_spawn_animation_finished() -> void:
		$spawn.visible = false
		$VBoxContainer/enemy.visible = true
		fade_in_progress = true
		$VBoxContainer/enemy.play()


func _on_attack_pressed() -> void:
	print("attack pressed")


func _on_defend_pressed() -> void:
	print("defend pressed")


func _on_run_pressed() -> void:
	print("run pressed")
