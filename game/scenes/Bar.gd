extends HBoxContainer

onready var sleepiness_bar = get_node("/root/Game/Character")

func change_sleepiness(sleepiness):
	$TextureProgress.value=sleepiness


# Called when the node enters the scene tree for the first time.
func _ready():
	sleepiness_bar.connect("sleepiness_bar",self,"change_sleepiness")
