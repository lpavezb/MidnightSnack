extends Spatial


var ground_size = Vector2(5, 10)
var next_chunk_coord = Vector3(-10, -2, 0)

onready var map = $World/Ground
onready var robot = $Robot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#create_chunk(ground_size.x, ground_size.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(_delta):
#	var next_trigger = (next_chunk_coord.z * 10) - (ground_size.y * 10)
#	if robot.translation.z > next_trigger:
#		create_chunk(ground_size.x, ground_size.y)

func create_chunk(w, h):
	var block_num
	var blocks_in_row
	var width = range(-w/2, w/2)
	var tile = 0
	var next_block = 0
	for z in h:
		if next_block == 2:
			next_block = 0
			block_num = randi() % 3
			blocks_in_row = 0
			for x in width:
				tile = 1 - tile
				if randi() % 2 and blocks_in_row <= block_num:
					map.set_cell_item(x, next_chunk_coord.y + 5, z + next_chunk_coord.z + 1, tile + 2)
					blocks_in_row += 1
				else:
					map.set_cell_item(x, next_chunk_coord.y, z + next_chunk_coord.z + 1, tile)
		else:
			next_block += 1
			for x in width:
				tile = 1 - tile
				map.set_cell_item(x, next_chunk_coord.y, z + next_chunk_coord.z + 1, tile)
		tile = 1 - tile	
			
	next_chunk_coord.z += h
