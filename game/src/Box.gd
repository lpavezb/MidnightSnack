extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var box_modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	box_modulate = $Sprite.modulate
	
func set_gravity(gravity):
	if gravity:
		$Sprite.modulate = box_modulate
		$Area2D.monitorable = true
		$Area2D/CollisionShape2D.disabled = false
	else:
		$Sprite.modulate = Color( 0.25, 0.88, 0.82, 0.8 )
		$Area2D.monitorable = false
		$Area2D/CollisionShape2D.disabled = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
