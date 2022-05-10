extends "res://boxes/hitbox.gd"

export(int) var SPEED: int = 200
var dir = 1

func _ready():
	#global_position.y = 50
	pass
	
func _physics_process(delta): #make the bolt move in a direction, post right, neg left
	global_position.x += SPEED * delta * dir
	
func destroy():
	queue_free()
	
func _on_boltAttack_area_entered(area):
	destroy()

func _on_boltAttack_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
