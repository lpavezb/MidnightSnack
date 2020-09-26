extends Node2D


var Box = preload("res://scenes/Box.tscn")
var box = Box.instance()
onready var Astronaut = get_node("Astronaut")

func _ready():
	Astronaut.connect("drop_box", self, "appear_box")
	Astronaut.connect("pick_box", self, "disappear_box")


func appear_box(dir):
	add_child(box)
	box.set_position(Astronaut.get_position()+dir)
	
func disappear_box(dir):
	remove_child(box)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
