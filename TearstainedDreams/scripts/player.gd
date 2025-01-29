extends CharacterBody2D


const SPEED = 65.0

var current_dir = "none"


func player():
	pass

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	current_camera()
	
func player_movement(_delta):
	if global.game_pause == false:
		if Input.is_action_pressed("right"):
			current_dir = "right" 
			play_anim(1)
			velocity.x = SPEED
			velocity.y = 0
		elif Input.is_action_pressed("left"):
			current_dir = "left"
			play_anim(1) 
			velocity.x = -SPEED
			velocity.y = 0
		elif Input.is_action_pressed("down"):
			current_dir = "down"
			play_anim(1)  
			velocity.y = SPEED
			velocity.x = 0
		elif Input.is_action_pressed("up"):
			current_dir = "up"
			play_anim(1) 
			velocity.y = -SPEED
			velocity.x = 0
		else:
			play_anim(0) 
			velocity.x = 0
			velocity.y = 0
	elif global.game_pause == true:
		velocity.x = 0
		velocity.y = 0
		play_anim(0)
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	
	if dir == "right":
		if movement == 1:
			anim.play("right_walk")
		elif movement == 0:
			anim.play("right_idle")
	if dir == "left":
		if movement == 1:
			anim.play("left_walk")
		elif movement == 0:
			anim.play("left_idle")
	if dir == "down":
		
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")

func current_camera():
	if global.current_scene == "house":
		$housecam.enabled = true
		$worldcam.enabled = false
		$forestcam.enabled = false
	elif global.current_scene == "world":
		$housecam.enabled = false
		$worldcam.enabled = true
		$forestcam.enabled = false
	elif global.current_scene == "forest":
		$forestcam.enabled = true
		$worldcam.enabled = false
		$housecam.enabled = false
	elif global.current_scene == "dungeonentrance":
		$forestcam.enabled = false
		$worldcam.enabled = false
		$housecam.enabled = false
		$dungeonentrancecam.enabled = true
