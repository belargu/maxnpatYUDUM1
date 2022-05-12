extends Node2D

onready var flames = $flames
onready var _animation_player = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flames.play("wiggle")
	_animation_player.play("title falls down")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
