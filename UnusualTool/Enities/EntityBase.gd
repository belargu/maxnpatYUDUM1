extends KinematicBody2D

export(int) var hp_max: int = 6
export(int) var hp: int = hp_max
export(int) var defense: int = 0
const UP = Vector2(0, -1) #used in move and slide

export(int) var SPEED: int = 150 #max speed
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer

func _physics_process(delta):
	move()
	
func move():
	velocity = move_and_slide(velocity, UP)

func die():
	queue_free()
