extends Area2D

var player_in_area = false:
	set(value):
		player_in_area = value
		$!.visible = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func interaction():
	pass
