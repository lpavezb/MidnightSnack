extends Spatial


var ground_size = Vector2(5, 10)
var next_chunk_coord = Vector3(-10, -2, 0)

onready var map = $World/Ground
onready var end_n1 = $World/END
onready var start_n2 = $World/StartN2

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
	end_n1.connect("body_entered", self, "show_paper")
	get_tree().paused = true
	
func _process(_delta):
	if Input.is_action_just_pressed(("pause")):
		pause()

func on_finished():
	$AudioStreamPlayer.play(71.4)
	print("loop music")
	

func pause():
	if tutorial_step >= 4:
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
		$"Interface/Tutorial/Jugar".visible = false
		get_tree().paused = false
	else:
		tutorial_step += 1
		tutorial.get_child(tutorial_step).visible = true
	
func show_paper(body):
	if body.name == "Character":
		tutorial.get_node("Noticia1").visible = true
		tutorial.get_node("Siguiente2").visible = true
		get_tree().paused = true

func pass_level():
	tutorial.get_node("Noticia1").visible = false
	tutorial.get_node("Siguiente2").visible = false
	character.teleport(character, start_n2.transform.origin)
	get_tree().paused = false
