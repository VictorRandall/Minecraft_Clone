extends Spatial

var n = 2
onready var player = get_node("KinematicBody")
var chunk_size = 16
var nchunk_size = 10
onready var chunk = get_node("MeshInstance")
onready var b = get_node("GridMap")
var noise = OpenSimplexNoise.new()
var noise2 = OpenSimplexNoise.new()

func set_chunk(trans_x, trans_z):
#	trans_x * 16
#	trans_z * 16
	b.clear()
	
	var start_x = trans_x / 2 - chunk_size
	var end_x = trans_x / 2 + chunk_size
	var start_z = trans_z / 2 - chunk_size
	var end_z = trans_z / 2 + chunk_size
	
	
	
	for x in range(start_x,end_x):
		for y in range(0,100):
			for z in range(start_z,end_z):
				if y < noise.get_noise_2d(x,z)*2+3:
					b.set_cell_item(x,0+noise.get_noise_2d(x,z)*8,z,1)
#					b.set_cell_item(x,y-1,z,2)
				noise.period = 25
	for x in range(start_x,end_x):
		for z in range(start_z,end_z):
			if not b.get_cell_item(x,0,z) >= 0:
				b.set_cell_item(x,0,z,0)

func _process(delta):
	pass


func _on_Timer_timeout():
	$Timer.start()
	set_chunk(player.translation.x, player.translation.z)
	
