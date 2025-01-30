extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_dooropens_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		$door.visible = false
		$dooropen.visible = true
