extends "res://Enities/EntityBase.gd"

export(int) var JUMP = 500 ##height
const ACCEL = 20

func _ready():
	pass

func _physics_process(delta):
	
	velocity.x = clamp(velocity.x, -SPEED, SPEED) #clamp speed at maximum speed
	
	if Input.is_action_pressed("ui_right"): #if press right accellerate right
		velocity.x += ACCEL
	elif Input.is_action_pressed("ui_left"): #same thing left
		velocity.x -= ACCEL
	else:
		velocity.x = lerp(velocity.x,0,0.3) ##slowly come to a stop

	if is_on_floor() and Input.is_action_pressed("ui_up"): #if ur on the floor and u hit up, jump
		velocity.y = -JUMP
