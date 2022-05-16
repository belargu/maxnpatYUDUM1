extends Node2D

onready var _animation_player = $AnimationPlayer
onready var musicPlayer = $music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animation_player.play("cutscene1")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	musicPlayer.play(0)
	Global.goto_scene("res://levels/level_1.tscn")
