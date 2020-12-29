extends Spatial


var ground_size = Vector2(5, 10)
var next_chunk_coord = Vector3(-10, -2, 0)

onready var map = $World/Ground

onready var character = $Character

onready var pause_menu = $"Interface/Pause menu"
var audio


# Called when the node enters the scene tree for the first time.
func _ready():
	audio = $AudioStreamPlayer
	$AudioStreamPlayer.play()
	print($World/StartN2.transform.origin)
	audio.connect("finished", self, "on_finished")
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed(("pause")):
		pause()

func on_finished():
	$AudioStreamPlayer.play(71.4)
	print("loop music")
	

func pause():
	pause_menu.visible = !pause_menu.visible
	get_tree().paused = !get_tree().paused
	
func _on_continue_pressed():
	pause()
	
func _on_quit_pressed():
	get_tree().paused = !get_tree().paused
	var _a = get_tree().change_scene("res://scenes/main_menu.tscn")
	
