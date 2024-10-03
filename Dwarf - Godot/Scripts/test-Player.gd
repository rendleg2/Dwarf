extends CharacterBody2D

var speed = 200
var dir = "down"

func _ready():
	velocity.x = 20
	move_and_slide()
	print("MOVE FASTER")
	
func _process(delta):
	move()
	
func move():
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("up"):
		velocity.y -= speed
		velocity.x = 0
		dir = "up"
	elif Input.is_action_pressed("down"):
		velocity.y += speed
		velocity.x = 0
		dir = "down"
	elif Input.is_action_pressed("left"):
		velocity.x -= speed
		velocity.y = 0
		dir = "left"
	elif Input.is_action_pressed("right"):
		velocity.x += speed
		velocity.y = 0
		dir = "right"
	move_and_slide()
