extends KinematicBody


var dir=0
var character
onready var ButtonLeft = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonLeft")
onready var ButtonRight = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonRight")
# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonLeft.connect("pressed",self,"turn_left")
	ButtonRight.connect("pressed",self,"turn_right")
	ButtonLeft.connect("unpressed",self,"turn_right")
	ButtonRight.connect("unpressed",self,"turn_left")
	var anim = $AnimationPlayer.get_animation("Robot_Walking")
	anim.set_loop(true)
	character = get_node("./Skeleton")
	$AnimationPlayer.play("Robot_Walking")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var linear_vel = Vector3()
var speed = 1.5

func _physics_process(_delta):
	var target_vel=Vector3(dir,-2,1) * speed
	var is_moving = target_vel.x != 0 or target_vel.z != 0
	
	linear_vel=lerp(linear_vel,target_vel*10,0.3)
	linear_vel=move_and_slide(linear_vel, Vector3(0, 1, 0))
	
	if is_moving:
		var angle = atan2(linear_vel.x, linear_vel.z)
		
		var char_rot = character.get_rotation()
		char_rot.y = angle
		character.set_rotation(char_rot)
	
func turn_left():
	dir+=1
	rotation_degrees.y +=2

func turn_right():
	dir-=1
	rotation_degrees.y -=2
