extends CharacterBody2D

var speed = 200
var a = null
var dir = "down"
var movement = false
var Settings_var = Settings.Settings_var
var World_settings = Settings.World_settings

func _ready():
	World_settings["chunkLoaderOne"] = self

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
