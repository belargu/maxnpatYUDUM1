extends "res://Enities/EntityBase.gd"

func _ready(): #this doesnt work
	SPEED = 20
	dir = -1
	#self.hp_max = 3
	#self.hp = hp_max
	
func _physics_process(delta):
	velocity.x = SPEED * dir
	move()
	if is_on_wall():
		dir *= -1
	
