extends KinematicBody


var dir=0
var character
onready var ButtonLeft = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonLeft")
onready var ButtonRight = get_node("/root/Game/Escena2D/Contenedor/Nave/ButtonRight")
onready var ButtonJump = get_node("/root/Game/Escena2D/Contenedor/Nave/JumpButton")
onready var CrouchButton = get_node("/root/Game/Escena2D/Contenedor/Nave/CrouchButton")
onready var Switch = get_node("/root/Game/Escena2D/Contenedor/Nave/Switch")

onready var checkpoints = get_node("/root/Game/World/checkpoints")
onready var fall_detector = get_node("/root/Game/World/fallDetector")
onready var collision_detector = $collisionDetector
var respawn_point = Vector3(48, 3, -42)

onready var anim_player = $character/AnimationPlayer

var CSHeight
var CSTranslation
var jumping = false
var crouching = false
var fallen = false
var gravity = -2
var sleepiness=100
var velocity_multiplier = 0.9
signal sleepiness_bar
# Called when the node enters the scene tree for the first time.
func _ready():
	CSHeight = $CollisionShape.shape.height
	CSTranslation = $CollisionShape.translation
	
	ButtonLeft.connect("pressed",self,"turn_left")
	ButtonRight.connect("pressed",self,"turn_right")
	ButtonLeft.connect("unpressed",self,"turn_right")
	ButtonRight.connect("unpressed",self,"turn_left")
	
	
	ButtonJump.connect("pressed",self,"jump")
	CrouchButton.connect("pressed",self,"crouch")
	CrouchButton.connect("unpressed",self,"get_up")	
	Switch.connect("new_state", self, "adjust_velocity")
	
	anim_player.get_animation("sleep_walk").set_loop(true)
	anim_player.get_animation("crouch_walk").set_loop(true)
	character = get_node("./character/Armature/Skeleton")
	anim_player.play("sleep_walk")
	
	for checkpoint in checkpoints.get_children():
		checkpoint.connect("body_entered", self, "save_checkpoint", [checkpoint.transform.origin])
	fall_detector.connect("body_entered", self, "drop")
	collision_detector.connect("body_entered", self, "fall")
	anim_player.connect("animation_finished", self, "walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var linear_vel = Vector3()
var speed = 0.5

func adjust_velocity(state):
	# {0: up, 1: center, 2: down}
	if state == 0:
		velocity_multiplier = 1.1
	elif state == 1:
		velocity_multiplier = 1
	else:
		velocity_multiplier = 0.9

func _physics_process(_delta):
		
	var target_vel = Vector3(dir,gravity,1) * speed
	var is_moving = target_vel.x != 0 or target_vel.z != 0
	
	linear_vel = lerp(linear_vel,target_vel*10,0.3) * velocity_multiplier
	if not fallen:
		linear_vel = move_and_slide(linear_vel, Vector3(0, 1, 0))
	
	
	if is_moving:
		var angle = atan2(linear_vel.x, linear_vel.z)
		
		var char_rot = character.get_rotation()
		char_rot.y = angle
		character.set_rotation(char_rot)
		
	if Input.is_action_just_pressed("respawn"):
		respawn(0)
	

func turn_left():
	dir+=1
	rotation_degrees.y +=2
	

func turn_right():
	dir-=1
	rotation_degrees.y -=2

func jump():
	if not (crouching or fallen):
		gravity = 0
		jumping = true
		ButtonJump.set_jumping(jumping)
		anim_player.play("Jump")
	
func crouch():
	if not jumping:
		crouching = true
		anim_player.play("crouch_walk")
		$CollisionShape.translation.y = 0.45
		$CollisionShape.shape.height = 0.3
		print("Collision translation: " + str($CollisionShape.translation.y))
		print("Collision height: " + str($CollisionShape.shape.height))
		$collisionDetector/CollisionShape.shape.height = .1
		$collisionDetector/CollisionShape.translation.z = 0.5
		
	
func resetGravity():
	gravity = -2
	jumping = false
	
func walk(_arg):
	if not fallen:
		anim_player.play("sleep_walk")
		resetGravity()
		ButtonJump.set_jumping(jumping)
		ButtonJump.unpress()

func get_up():
	if not jumping:
		crouching = false
		anim_player.play("sleep_walk")
		$CollisionShape.translation.y = CSTranslation.y
		$CollisionShape.shape.height = CSHeight
		print("Collision translation: " + str($CollisionShape.translation.y))
		print("Collision height: " + str($CollisionShape.shape.height))
		$collisionDetector/CollisionShape.translation.z = 0
		$collisionDetector/CollisionShape.shape.height = 1

func fall(body):
	if body.name != "Character":
		fallen = true
		sleepiness=sleepiness-10
		emit_signal("sleepiness_bar",sleepiness)
		print("you fell by ", body.name)
		anim_player.play("fall")

func drop(_var):
	sleepiness=sleepiness-20
	emit_signal("sleepiness_bar",sleepiness)
	self.transform.origin = respawn_point
	fallen = false
	anim_player.play("sleep_walk")
	
func save_checkpoint(body, point):
	if(body.name == "Character"):
		respawn_point = point#body.transform.origin
	
func respawn(_var):
	if sleepiness==0:
		respawn_point = Vector3(48, 3, -42)
		sleepiness=100
		emit_signal("sleepiness_bar",sleepiness)
	self.transform.origin = respawn_point
	fallen = false
	anim_player.play("sleep_walk")

