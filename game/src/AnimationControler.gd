extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var character = get_node("/root/Game/Character")
onready var ButtonJump = get_node("/root/Game/Escena2D/Contenedor/Nave/JumpButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func resetGravity():
	character.resetGravity()

func walk():
	character.walk()

func unpressButton():
	ButtonJump.unpress()

func respawn():
	print("alksdj")
	character.respawn(0)
