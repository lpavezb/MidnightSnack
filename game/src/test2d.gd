extends KinematicBody2D

onready var animation_mode = $AnimationTree.get("parameters/playback")
var box = false
var SPEED = 300
var linear_vel = Vector2()
signal drop_box
signal pick_box
var still=false
var stopped=true
var target_vel
var dir

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	stopped=true

func _physics_process(_delta):
	var target_vel = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	var moving = Input.is_action_pressed("right") or Input.is_action_pressed("left") or Input.is_action_pressed("up") or Input.is_action_pressed("down")
	if still:
		pass
	else:
		linear_vel = lerp(linear_vel, target_vel * SPEED, 0.5)
		linear_vel = move_and_slide(linear_vel)
	
	$AnimationTree.set("parameters/Idle/blend_position",linear_vel.normalized())
	$AnimationTree.set("parameters/Run/blend_position",linear_vel.normalized())
	$AnimationTree.set("parameters/PushButton/blend_position",linear_vel.normalized())
	$AnimationTree.set("parameters/RunBox/blend_position",linear_vel.normalized())
	$AnimationTree.set("parameters/IdleBox/blend_position",linear_vel.normalized())
	
	if box:
		if still:
			linear_vel=Vector2(0,0)
			emit_signal("pick_box",dir)
			if stopped:
				still=false
				
		if Input.is_action_just_pressed("action"):
			$AnimationTree.set("parameters/DropBox/blend_position",linear_vel.normalized())
			animation_mode.travel("Idle")
			$Timer.start(1.1)
			
			still=true
			stopped=false
			box=false
			
		if moving:
			animation_mode.travel("RunBox")
		else:
			animation_mode.travel("IdleBox")
			
	else:
		if still:
			linear_vel=Vector2(0,0)
			if stopped:
				dir=$Position2D.position
				emit_signal("drop_box",dir)
				still=false
				
		if Input.is_action_just_pressed("action"):
			$AnimationTree.set("parameters/PickBox/blend_position",linear_vel.normalized())
			animation_mode.travel("IdleBox")
			$Timer.start(1.1)
			still=true
			stopped=false
			box=true
			
		if moving:
			animation_mode.travel("Run")
		else:
			animation_mode.travel("Idle")
	
	

