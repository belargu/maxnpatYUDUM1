extends Node2D

onready var _animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animation_player.play("cutscene2")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	Global.goto_scene("res://levels/end.tscn")
