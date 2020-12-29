extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var character = get_node("/root/Game/Character")
onready var collision_detector = $collision
onready var gorro = get_node("gorro")

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_detector.connect("body_entered", self, "disappear")
	var anim =  get_node("AnimationPlayer").get_animation("Hover")
	anim.set_loop(true)
	$AnimationPlayer.play("Hover")
	

func disappear(_arg):
	character.recover()
	self.queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
