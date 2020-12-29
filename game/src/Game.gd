extends Spatial


var ground_size = Vector2(5, 10)
var next_chunk_coord = Vector3(-10, -2, 0)

onready var map = $World/Ground

onready var character = $Character

onready var pause_menu = $"Interface/Pause menu"
onready var tutorial = $"Interface/Tutorial"
var tutorial_step = 0
var audio


# Called when the node enters the scene tree for the first time.
func _ready():
	audio = $AudioStreamPlayer
	$AudioStreamPlayer.play()
	print($World/StartN2.transform.origin)
	audio.connect("finished", self, "on_finished")
	get_tree().paused = true
	
func _process(_delta):
	if Input.is_action_just_pressed(("pause")):
		pause()

func on_finished():
	$AudioStreamPlayer.play(71.4)
	print("loop music")
	

func pause():
	if !tutorial.visible:
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
	
func _on_continue_pressed():
	pause()
	
func _on_quit_pressed():
	get_tree().paused = !get_tree().paused
	var _a = get_tree().change_scene("res://scenes/main_menu.tscn")
	


func _on_Siguiente_pressed():
	tutorial.get_child(tutorial_step).visible = false
	if tutorial_step == 3:
		$"Interface/Tutorial/Siguiente".visible = false
		$"Interface/Tutorial/Jugar".visible = true
	if tutorial_step == 4:
		tutorial.visible = false
		get_tree().paused = false
	else:
		tutorial_step += 1
		tutorial.get_child(tutorial_step).visible = true
	
	
