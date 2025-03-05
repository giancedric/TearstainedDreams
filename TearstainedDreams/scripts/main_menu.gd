extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$play.play()
	await get_tree().create_timer(0.5).timeout 
	get_tree().change_scene_to_file("res://scenes/house.tscn")
