extends Node2D


var Box = preload("res://scenes/Box.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", self, "on_timeout")

func on_timeout():
	var box = Box.instance()
	add_child(box)
	box.global_position = $Position2D.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
