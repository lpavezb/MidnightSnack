extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var flip = true
var vel = 10
func _physics_process(_delta):
	var moving = Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")
	if moving:
		if Input.is_action_pressed("ui_right"):
			$AnimationPlayer.play("RunRight")
			flip = true
			position.x += vel
			
		if Input.is_action_pressed("ui_left"):
			$AnimationPlayer.play("RunLeft")
			flip = false
			position.x -= vel
	
		if Input.is_action_pressed("ui_up"):
			if flip:
				$AnimationPlayer.play("RunRight")
			else:
				$AnimationPlayer.play("RunLeft")
			position.y -= vel
		if Input.is_action_pressed("ui_down"):
			if flip:
				$AnimationPlayer.play("RunRight")
			else:
				$AnimationPlayer.play("RunLeft")
			position.y += vel
	else:
		if flip:
			$AnimationPlayer.play("IdleRight")
		else:
			$AnimationPlayer.play("IdleLeft")
		
#	if position.x < -20:
#		get_node("/root/Game/Robot").turn_left()
#
#	if position.x > 20:
#		get_node("/root/Game/Robot").turn_right()
