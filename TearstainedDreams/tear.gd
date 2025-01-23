extends Node2D

var state = "none"
var player_in_area = false

func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state != "picked up":
		if player_in_area:
			if Input.is_action_just_pressed("interact"):
				state = "picked up"
		


func _on_collectarea_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_collectarea_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
