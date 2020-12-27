extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 2 # {0: up, 1: center, 2: down}
var dir = 1 # {0: top-down, 1: down-top}
var can_press = false
signal new_state
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
		$SwitchUp.modulate = Color(133/255, 1, 0, 1)
		$SwitchCenter.modulate = Color(133/255, 1, 0, 1)
		$SwitchDown.modulate = Color(133/255, 1, 0, 1)
	else:
		$SwitchUp.modulate = Color(1, 1, 1, 1)
		$SwitchCenter.modulate = Color(1, 1, 1, 1)
		$SwitchDown.modulate = Color(1, 1, 1, 1)
		
	if Input.is_action_just_pressed("action") and can_press:
		get_parent().get_child(0).get_child(3).get("parameters/playback").travel("BackButton")
		press()
	
func press():
	if dir:
		if state == 2:
			$SwitchDown.hide()
			state = 1
		elif state == 1:
			$SwitchCenter.hide()
			state = 0
			dir = 0
	else:
		if state == 0:
			$SwitchCenter.show()
			state = 1
		elif state == 1:
			$SwitchDown.show()
			state = 2
			dir = 1
	emit_signal("new_state", state)
