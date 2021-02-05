extends Spatial

var n = 2
onready var player = get_node("KinematicBody")
var nchunk_size = 20
var chunk_size = 40
var render_distance = 2
var chunks = {}
var uchunks = {}
onready var chunk = get_node("MeshInstance")
onready var b = get_node("GridMap")
var noise = OpenSimplexNoise.new()
var RNG = RandomNumberGenerator.new()

func create_chunk(x, z, chunk):
#	trans_x * 8
#	trans_z * 8
	b.clear()
	var uchunk = chunk 
	
	var start_x = x / 4 - uchunk
	var start_z = z / 4 - uchunk
	var end_x = x / 4 + uchunk
	var end_z = z / 4 + uchunk
	
	
	var water_level = 7
	

	for chunk_x in range(start_x,end_x):
		for chunk_y in range(0,100):
			for chunk_z in range(start_z,end_z):
				var used_noise = noise.get_noise_2d(chunk_x,chunk_z)*10+15
				if chunk_y < used_noise:
					if b.get_cell_item(chunk_x,0+used_noise,chunk_z) <= -1:
						b.set_cell_item(chunk_x,0+used_noise,chunk_z,0)
#						b.set_cell_item(chunk_x,0+used_noise-1,chunk_z,1)
#						if not b.get_cell_item(x,water_level,z) >= 0:
#							b.set_cell_item(x,water_level,z,0)
				noise.period = 40
	
func set_chunks(x, z):
	
#	var start_x = x - chunk_size * render_distance
#	var start_z = z - chunk_size * render_distance
#	var end_x = x + chunk_size * render_distance
#	var end_z = z + chunk_size * render_distance
	
	for render_distance_x in range(x,z):
		for render_distance_z in range(x,z):
			create_chunk(render_distance_x + render_distance, render_distance_z + render_distance, nchunk_size)
			print(render_distance_x,", ",render_distance_z)

func _ready():
#	create_chunk(0, 0, chunk_size)
	RNG.randomize()
	noise.seed = RNG.randi()
	$AnimationPlayer.playback_speed = 4
	

func _process(delta):
#	create_chunk(player.translation.x, player.translation.z, nchunk_size)
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		
		
	

func _on_Timer_timeout():
	$Timer.start()
	create_chunk(player.translation.x, player.translation.z, nchunk_size)
	
	
