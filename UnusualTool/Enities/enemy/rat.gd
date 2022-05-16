extends "res://Enities/enemy/EnemyBase.gd"

onready var fcast = $floor_cast
onready var audioPlayer = $AudioStreamPlayer
export var edge_detect = true

func _ready():
	fcast.enabled = edge_detect

func _physics_process(delta):
	fcast.position.x = $CollisionShape2D.shape.get_extents().x * dir #moves the raycast in front of the rat depending on the direction
	if not fcast.is_colliding() and edge_detect == true and is_on_floor(): #if the raycast doesn't detect floor infront of the rat
		dir *= -1 #flip direction
		audioPlayer.stream = load("res://sounds/rat/ratwalk.mp3")
		audioPlayer.play(0)

#when rat is hurt, play noise
func _on_hurtbox_area_entered_2(area: Area2D) -> void:
	audioPlayer.stream = load("res://sounds/rat/rathurt.mp3")
	audioPlayer.play(0)
	
