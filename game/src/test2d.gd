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
var SPEED = 300
var linear_vel = Vector2()
func _physics_process(_delta):
	var target_vel = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	linear_vel = lerp(linear_vel, target_vel * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)
	var moving = Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")
	
	if moving:
		if Input.is_action_pressed("ui_right"):
			$AnimationPlayer.play("RunRight")
			flip = true
			
		if Input.is_action_pressed("ui_left"):
			$AnimationPlayer.play("RunLeft")
			flip = false
	
		if Input.is_action_pressed("ui_up"):
			if flip:
				$AnimationPlayer.play("RunRight")
			else:
				$AnimationPlayer.play("RunLeft")
		if Input.is_action_pressed("ui_down"):
			if flip:
				$AnimationPlayer.play("RunRight")
			else:
				$AnimationPlayer.play("RunLeft")
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
