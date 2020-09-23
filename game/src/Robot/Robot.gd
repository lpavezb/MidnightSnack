extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var character

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = $AnimationPlayer.get_animation("Robot_Walking")
	anim.set_loop(true)
	character = get_node("./Skeleton")
	$AnimationPlayer.play("Robot_Walking")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var linear_vel = Vector3()
var speed = 2

func _physics_process(_delta):
	var target_vel=Vector3(Input.get_action_strength("ui_left")-Input.get_action_strength("ui_right"),
	-2,Input.get_action_strength("ui_up")-Input.get_action_strength("ui_down")) * speed
	var is_moving = target_vel.x != 0 or target_vel.z != 0
	
	linear_vel=lerp(linear_vel,target_vel*10,0.3)
	linear_vel=move_and_slide(linear_vel, Vector3(0, 1, 0))
	
	if is_moving:
		var angle = atan2(linear_vel.x, linear_vel.z)
		
		var char_rot = character.get_rotation()
		char_rot.y = angle
		character.set_rotation(char_rot)
	
func turn_left():
	rotation_degrees.y +=2

func turn_right():
	rotation_degrees.y -=2
	
