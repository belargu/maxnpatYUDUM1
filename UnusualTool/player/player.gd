extends KinematicBody2D

const UP = Vector2(0, -1) #used in move and slide
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 150
const JUMP = 450
const ACCEL = 20

var motion = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED: #dont wanna fall infinitly fast, terminal velocity
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED) #clamp speed at maximum speed
	
	if Input.is_action_pressed("ui_right"): #if press right accellerate right
		motion.x += ACCEL
	elif Input.is_action_pressed("ui_left"): #same thing left
		motion.x -= ACCEL
	else:
		motion.x = lerp(motion.x,0,0.2) ##slowly come to a stop

	if is_on_floor() and Input.is_action_pressed("ui_up"): #if ur on the floor and u hit up, jump
		motion.y = -JUMP
	motion = move_and_slide(motion, UP)
