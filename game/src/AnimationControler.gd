extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var character = get_node("/root/Game/Character")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func resetGravity():
	character.resetGravity()

func walk():
	character.walk()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
