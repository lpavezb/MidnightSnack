extends KinematicBody


var dir=0
var character
onready var ButtonLeft = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonLeft")
onready var ButtonRight = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonRight")
#Se debe crear un boton de salto, que emita una señal como las de los otros dos
#onready var ButtonJump = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonJump")

onready var anim_player = $character/AnimationPlayer
var jumping = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonLeft.connect("pressed",self,"turn_left")
	ButtonRight.connect("pressed",self,"turn_right")
	ButtonLeft.connect("unpressed",self,"turn_right")
	ButtonRight.connect("unpressed",self,"turn_left")
	
	#Una vez creado el boton de salto, con esto se conecta a la funcion.
	#ButtonJump.connect("pressed",self,"jump")
	
	
	
	anim_player.get_animation("sleep_walk").set_loop(true)
	character = get_node("./character/Armature/Skeleton")
	anim_player.play("sleep_walk")
	
	anim_player.connect("animation_finished", self, "walk")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var linear_vel = Vector3()
var speed = 0.3

func _physics_process(_delta):
	var target_vel = Vector3(dir,-2,1) * speed
	var is_moving = target_vel.x != 0 or target_vel.z != 0
	
	linear_vel = lerp(linear_vel,target_vel*10,0.3)
	linear_vel = move_and_slide(linear_vel, Vector3(0, 1, 0))
	
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

func jump():
	jumping = true
	anim_player.play("Jump")
	
func walk(current_animation):
	if(current_animation == "Jump"):
		jumping = false
		anim_player.play("sleep_walk")
