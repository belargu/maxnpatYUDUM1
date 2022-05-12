extends KinematicBody2D

export(int) var hp_max: int = 6
export(int) var hp: int = hp_max setget set_hp
export(int) var defense: int = 0
const UP = Vector2(0, -1) #used in move and slide

export(int) var SPEED: int = 150 #max speed
var velocity = Vector2.ZERO
const GRAVITY = 25
export(int) var MAXFALLSPEED = 300
export var dir = 1

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer
onready var timer = $fx_timer

signal hp_changed(new_hp)

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max)
		emit_signal("hp_changed", hp)

func _physics_process(delta):
	move()
	
func move():
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED: #dont wanna fall infinitly fast, terminal velocity
		velocity.y = MAXFALLSPEED
	velocity = move_and_slide(velocity, UP)
	if dir == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

func die():
	print("can i get an f in chat for " + name)
	queue_free()

func _on_hurtbox_area_entered(hitbox): #damage is dealt
	var base_damage = hitbox.damage
	self.hp -= base_damage
	sprite.modulate = Color (1,0,0,1)
	timer.start(0.2)
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "and dealt " + str(base_damage))
	print("hp is " + str(self.hp))
	if self.hp <= 0:
		die()


func _on_fx_timer_timeout():
	sprite.modulate = Color (1,1,1,1)
