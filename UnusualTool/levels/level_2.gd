extends Node2D

onready var doorEntered = false
onready var toRespawn = false
onready var audioPlayer = $AudioStreamPlayer
onready var musicPlayer = $music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicPlayer.play(Global.timestamp)
	#play the corresponding sound when starting
	if not Global.respawned:
		audioPlayer.stream = load("res://sounds/door.mp3")
		audioPlayer.play(0)
	elif Global.respawned:
		audioPlayer.stream = load("res://sounds/wrench/wrenchdie.mp3")
		audioPlayer.play(0)
		Global.respawned = false #toggle back

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if toRespawn: 
		Global.goto_scene("res://levels/level_2.tscn")
	if doorEntered:
		Global.goto_scene("res://levels/level_3.tscn")
