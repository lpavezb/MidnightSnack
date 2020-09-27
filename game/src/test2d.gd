extends KinematicBody2D

var SPEED = Vector2(300,200)
var linear_vel = Vector2()

onready var animation_mode = $AnimationTree.get("parameters/playback")
onready var Nave = get_parent()

signal drop_box
signal pick_box
signal position

var box = false
var still = false
var stopped = true
var target_vel
var dir
var box_near
var look

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	Nave.connect("box_near", self, "pick_box")
	

func _on_Timer_timeout():
	stopped=true
	
func pick_box(near):
	if near:
		box_near=true
	else:
		box_near=false

func _physics_process(_delta):
	emit_signal("position",$Position2D.position)
	var target_vel = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	var moving = Input.is_action_pressed("right") or Input.is_action_pressed("left") or Input.is_action_pressed("up") or Input.is_action_pressed("down")
	if still:
		pass
	else:
		linear_vel = lerp(linear_vel, target_vel * SPEED, 0.5)
		linear_vel = move_and_slide(linear_vel)
		if linear_vel.x<0:
			look=Vector2(-1,0)
		elif linear_vel.x>0:
			look=Vector2(1,0)
		else:
			pass
	
	$AnimationTree.set("parameters/Run/blend_position",look)
	$AnimationTree.set("parameters/Idle/blend_position",look)
	$AnimationTree.set("parameters/PushButton/blend_position",look)
	$AnimationTree.set("parameters/RunBox/blend_position",look)
	$AnimationTree.set("parameters/IdleBox/blend_position",look)
	
	if box:
		if still:
			linear_vel=Vector2(0,0)
			if stopped:
				emit_signal("drop_box")
				still=false
				box=false
				
		elif Input.is_action_just_pressed("action"):
			$AnimationTree.set("parameters/DropBox/blend_position",look)
			animation_mode.travel("Idle")
			$Timer.start()
			still=true
			stopped=false
			
		elif moving:
			animation_mode.travel("RunBox")
		else:
			animation_mode.travel("IdleBox")
			
	else:
		if still:
			linear_vel=Vector2(0,0)
			if stopped:
				box=true
				box_near=false
				still=false
				
		elif Input.is_action_just_pressed("action"):
			$AnimationTree.set("parameters/PickBox/blend_position",look)
			if box_near:
				$Timer.start()
				animation_mode.travel("IdleBox")
				emit_signal("pick_box")
				still=true
				stopped=false
				
			else:
				pass
		elif moving:
			animation_mode.travel("Run")
		else:
			animation_mode.travel("Idle")
	
	

