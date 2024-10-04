extends CharacterBody2D

var speed = 200
	
func _process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("up"):
		velocity.y -= speed
		velocity.x = 0
	elif Input.is_action_pressed("down"):
		velocity.y += speed
		velocity.x = 0
	elif Input.is_action_pressed("left"):
		velocity.x -= speed
		velocity.y = 0
	elif Input.is_action_pressed("right"):
		velocity.x += speed
		velocity.y = 0
	move_and_slide()
