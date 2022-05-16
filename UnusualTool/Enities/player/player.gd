extends "res://Enities/EntityBase.gd"

export(int) var JUMP = 530 ##height
const ACCEL = 20

onready var _animation_player = $AnimationPlayer
onready var audioPlayer = $AudioStreamPlayer

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
		#$Sprite.flip_h = false
		_animation_player.play("walk")
	elif Input.is_action_pressed("ui_left"): #same thing left
		velocity.x -= ACCEL
		dir = -1
		#$Sprite.flip_h = true
		_animation_player.play("walk")
		
		
	else:
		velocity.x = lerp(velocity.x,0,0.3) ##slowly come to a stop
		_animation_player.play("idle")
	
	if Input.is_action_just_pressed("attack"): #if attack is pressed
		var BoltAttack = load("res://Enities/player/BoltAttack.tscn") #load bolt attack into var
		var boltAttack = BoltAttack.instance() #load instance into var ?
		var world = get_tree().current_scene #get world tree thing ??
		world.add_child(boltAttack) #make new instnace of bolt a child of the world
		boltAttack.global_position = global_position + Vector2(0, -9) #put the bolt where the player is accounting for offset
		boltAttack.dir = sign(dir) #determine the direction of the projectile based off of the players last input
		
	if Input.is_action_pressed("attack"):
		_animation_player.play("shoot")
		audioPlayer.stream = load("res://sounds/wrench/wrenchshoot.mp3")
		audioPlayer.play(0)
		
	if is_on_floor() and Input.is_action_pressed("ui_up"): #if ur on the floor and u hit up, jump
		velocity.y = -JUMP
	elif not is_on_floor():
		_animation_player.play("jump")
		
	if Input.is_action_just_pressed("ui_up"):
		#extra block of code here to play wrenchjump.mp3 bc it's looped
		#weirdly when played in AnimationPlayer
		audioPlayer.stream = load("res://sounds/wrench/wrenchjump.mp3")
		audioPlayer.play(0)
		
func _on_hitbox_area_entered(area):
	velocity.y = -JUMP*.8
	
#when player is hurt, play noise
func _on_hurtbox_area_entered_2(area: Area2D) -> void:
	audioPlayer.stream = load("res://sounds/wrench/wrenchhurt.mp3")
	audioPlayer.play(0)

#switch level
func _on_door_body_entered(body: Node) -> void:
	get_parent().doorEntered = true #bool used in level_1-3.gd
	
func die():
	Global.respawned = true
	get_parent().toRespawn = true
	
	#can't use the function below since we're using global.gd for level switching;
	#"can't free a deleted scene" error shows up when player tries to switch levels
	#after respawning at least once
	#get_tree().reload_current_scene()


