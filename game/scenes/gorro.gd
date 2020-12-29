extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var collision_detector = $collision
onready var gorro = get_node("gorro")

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_detector.connect("body_entered", self, "disappear")

func disappear():
	gorro.visible=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
