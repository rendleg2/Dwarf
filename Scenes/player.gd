extends CharacterBody2D

var speed = 200
var a = null
var dir = "down"
var movement = false


func _ready():
	pass

func _process(delta):
	move()

func move():
	velocity.x = 0
	velocity.y = 0
	movement = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		velocity.x = 0
		dir = "up"
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed
		velocity.x = 0
		dir = "down"
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		velocity.y = 0
		dir = "left"
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed
		velocity.y = 0
		dir = "right"
	else:
		movement = false
	move_and_slide()
