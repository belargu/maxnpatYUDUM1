extends Node2D

onready var doorEntered = false
onready var toRespawn = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if toRespawn:
		Global.goto_scene("res://levels/level_1.tscn")
	if doorEntered:
		Global.goto_scene("res://levels/level_2.tscn")
