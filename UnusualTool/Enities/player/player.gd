extends "res://Enities/EntityBase.gd"

export(int) var JUMP = 530 ##height
const ACCEL = 20
var dir = 1

onready var _animated_sprite = $AnimatedSprite

#signal attacking(dir)

func _ready():
	pass

func _process(delta):
	#var playerHP = self.hp
	pass

func _physics_process(delta):
	
	velocity.x = clamp(velocity.x, -SPEED, SPEED) #clamp speed at maximum speed
	
	if Input.is_action_pressed("ui_right"): #if press right accellerate right
		velocity.x += ACCEL
		dir = 1
		$AnimatedSprite.flip_h = false
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("ui_left"): #same thing left
		velocity.x -= ACCEL
		dir = -1
		$AnimatedSprite.flip_h = true
		_animated_sprite.play("walk")
		
	else:
		velocity.x = lerp(velocity.x,0,0.3) ##slowly come to a stop
		_animated_sprite.play("idle")
	
	if Input.is_action_just_pressed("attack"): #if attack is pressed
		var BoltAttack = load("res://Enities/player/BoltAttack.tscn") #load bolt attack into var
		var boltAttack = BoltAttack.instance() #load instance into var ?
		var world = get_tree().current_scene #get world tree thing ??
		world.add_child(boltAttack) #make new instnace of bolt a child of the world
		boltAttack.global_position = global_position #put the bolt where the player is
		boltAttack.global_position.y -= 9 #offset so it comes out of players head
		boltAttack.dir = sign(dir) #determine the direction of the projectile based off of the players last input
		
	if Input.is_action_pressed("attack"):
		_animated_sprite.play("shoot")
		
	if is_on_floor() and Input.is_action_pressed("ui_up"): #if ur on the floor and u hit up, jump
		velocity.y = -JUMP
	elif not is_on_floor():
		_animated_sprite.play("jump")
