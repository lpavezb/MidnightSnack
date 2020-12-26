extends Node2D

onready var Astronaut = get_node("Astronaut")
var gravity = true
var Box = preload("res://scenes/Box.tscn")
var box = Box.instance()
var astro_position
var box_position
var grab_position

signal box_near

func _ready():
	add_child(box)
	box.set_position(Vector2(50,130))
	Astronaut.connect("drop_box", self, "appear_box")
	Astronaut.connect("pick_box", self, "disappear_box")
	Astronaut.connect("position",self,"position")
	$GravityButton.connect("pressed", self, "on_gravity_pressed")
	$GravityButton.connect("unpressed", self, "on_gravity_unpressed")



func _process(_delta):
	if get_node_or_null("Box")!=null:
		if gravity:
			astro_position=Astronaut.get_position()+grab_position
			box_position=box.get_position()
			if astro_position.x>box_position.x-16 and astro_position.x<box_position.x+16 and astro_position.y>box_position.y-16 and astro_position.y<box_position.y+16:
				emit_signal("box_near",true)
			else:
				emit_signal("box_near",false)
	else:
		emit_signal("box_near",false)

func on_gravity_pressed():
	gravity = false
	box.set_gravity(gravity)

func on_gravity_unpressed():
	gravity = true
	box.set_gravity(gravity)
		
func position(dir):
	grab_position = dir

func appear_box():
	add_child(box)
	box.set_position(Astronaut.get_position()+grab_position)
	
func disappear_box():
	remove_child(box)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
