extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pressed

var can_press = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Piso.connect("body_entered", self, "on_body_entered")
	$Piso.connect("body_exited", self, "on_body_exited")

func on_body_entered(body: Node):
	can_press = true

func on_body_exited(body: Node):
	can_press = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	if can_press:
		$Button.modulate = Color(133/255, 1, 0, 1)
		$ButtonPressed.modulate = Color(133/255, 1, 0, 1)
	else:
		$Button.modulate = Color(1, 1, 1, 1)
		$ButtonPressed.modulate = Color(1, 1, 1, 1)
		
	if Input.is_action_just_pressed("action") and can_press:
		press()
		
func press():
	if $ButtonPressed.visible:
		$ButtonPressed.hide()
	else:
		$ButtonPressed.show()
		emit_signal("pressed")
