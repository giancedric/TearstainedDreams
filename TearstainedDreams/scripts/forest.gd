extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path()

func path():
	if global.housetear_collected==true:
		if Input.is_action_pressed("path"):
			$path.visible = true
		elif Input.is_action_just_released("path"):
			$path.visible = false
