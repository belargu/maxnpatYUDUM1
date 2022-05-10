extends KinematicBody2D

export(int) var hp_max: int = 6
export(int) var hp: int = hp_max
export(int) var defense: int = 0
const UP = Vector2(0, -1) #used in move and slide

export(int) var SPEED: int = 150 #max speed
var velocity = Vector2.ZERO
const GRAVITY = 25
export(int) var MAXFALLSPEED = 300

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer

func _physics_process(delta):
	move()
	
func move():
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED: #dont wanna fall infinitly fast, terminal velocity
		velocity.y = MAXFALLSPEED
	velocity = move_and_slide(velocity, UP)

func die():
	queue_free()

func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.hp -= base_damage
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "and dealt " + str(base_damage))
