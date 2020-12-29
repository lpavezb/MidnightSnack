extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pressed
signal unpressed
var jumping = false
var can_press = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var _a = $Piso.connect("body_entered", self, "on_body_entered")
	var _b = $Piso.connect("body_exited", self, "on_body_exited")

func on_body_entered(_body: Node):
	can_press = true

func on_body_exited(_body: Node):
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
		
	if Input.is_action_just_pressed("action") and can_press and not jumping:
		press()
		
func press():
	if $ButtonPressed.visible:
		$ButtonPressed.hide()
		emit_signal("unpressed")
	else:
		$ButtonPressed.show()
		emit_signal("pressed")
		
func unpress():
	$ButtonPressed.hide()
	
func set_jumping(value):
	jumping = value
