extends Area2D

signal pressed
signal unpressed
var is_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if len(get_overlapping_areas()) > 0:
		if not is_pressed:
			emit_signal("pressed")
			is_pressed = true
			$ButtonPressed.show()
	else:
		if is_pressed:
			emit_signal("unpressed")
			is_pressed = false
			$ButtonPressed.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

