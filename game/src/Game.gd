extends Spatial


var ground_size = Vector2(5, 10)
var next_chunk_coord = Vector3(-10, -2, 0)

onready var map = $World/Ground
var audio
# Called when the node enters the scene tree for the first time.
func _ready():
	audio = $AudioStreamPlayer
	$AudioStreamPlayer.play()
	audio.connect("finished", self, "on_finished")

func on_finished():
	$AudioStreamPlayer.play(71.4)
	print("loop music")
	
