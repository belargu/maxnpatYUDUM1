extends KinematicBody2D

const UP = Vector2(0, -1) #used in move and slide
const GRAVITY = 20
export(int) var MAXFALLSPEED = 250
const MAXSPEED = 150
export(int) var JUMP = 450 ##height
const ACCEL = 20

var velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED: #dont wanna fall infinitly fast, terminal velocity
		velocity.y = MAXFALLSPEED
	
	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED) #clamp speed at maximum speed
	
	if Input.is_action_pressed("ui_right"): #if press right accellerate right
		velocity.x += ACCEL
	elif Input.is_action_pressed("ui_left"): #same thing left
		velocity.x -= ACCEL
	else:
		velocity.x = lerp(velocity.x,0,0.3) ##slowly come to a stop

	if is_on_floor() and Input.is_action_pressed("ui_up"): #if ur on the floor and u hit up, jump
		velocity.y = -JUMP
	velocity = move_and_slide(velocity, UP)
