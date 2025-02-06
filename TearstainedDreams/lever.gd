extends Sprite2D

var player_in_area = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var switch = false:
	set(value):
		switch = value
		if value == true:
			on()
		else:
			off()

func interact():
	switch = not switch

func on():
	$lever.frame = 3

func off():
	$lever.frame = 4
	
