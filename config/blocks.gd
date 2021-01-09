extends GridMap

var random = RandomNumberGenerator.new()
var mutiplier = 10
var divider = 8
var chunk = 5
var speed = 10
onready var player = $KinematicBody
var noise = OpenSimplexNoise.new()
#
func _ready():
	random.randomize()
	noise.seed = random.randi()
	noise.persistence = 1
	print("seed:", random.randi())
	

func create_world(x_trans,y_trans,z_trans,x_size,y_size,z_size):
	for x in range(x_trans,x_size):
		for y in range(y_trans,y_size):
			for z in range(z_trans,z_size):
				if y < noise.get_noise_2d(x,z)*noise.get_noise_3d(x,y,z)-noise.get_noise_3d(x,y,z)*mutiplier+15:
					if get_cell_item(x,y,z) == -1:
						set_cell_item(x,y,z,0)
					
					
#	if not range(x_trans,x_size):
#		if not range(y_trans,y_size):
#			if not range(z_trans,z_size):
#				set_cell_item(x,y,z,-1)


func _process(delta):
	create_world(player.translation.x/divider-chunk,0,player.translation.z/divider-chunk,player.translation.x/divider+chunk,100,player.translation.z/divider+chunk)
	noise.persistence = 15
	
