extends Node2D

onready var flames = $flames
onready var _animation_player = $AnimationPlayer
onready var inputAllowed = false #bool for timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flames.play("wiggle")
	_animation_player.play("title falls down")

func _input(event):
	if event is InputEventKey:
		if event.pressed and inputAllowed: #only let player start game after animation
			Global.goto_scene("res://levels/cutscene1.tscn")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	inputAllowed = true
