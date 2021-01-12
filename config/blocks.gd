extends GridMap

var file = File.new()
var data = {}
var path = "res://worlds/world_data.json"
var default_data = {
	"blockidk": 100,
	"block2": 100,
	"block3": 100,
	
}
var n = 45
const GRASS = 0
const STONE = 2
const DIRT = 1
const SAND = 3
var biomes_selected = 'flat'
var random = RandomNumberGenerator.new()
var mutiplier = 5
var divider = 8
var chunk = 2
var speed = 10
onready var player = $KinematicBody
onready var pos = $Position3D
var noise = OpenSimplexNoise.new()
#
func _ready():
	$Control.hide()
	random.randomize()
	noise.seed = random.randi()
	noise.persistence = 1
	print("seed:", random.randi())
#	for x in range(-n, n):
#		for y in range(0, 100):
#			for z in range(-n, n):
#					if y < noise.get_noise_2d(x,z)*mutiplier+10:
#						if get_cell_item(x,y,z) == -1:
#							set_cell_item(x,y,z,GRASS)
#							set_cell_item(x,y-1,z,DIRT)
#							set_cell_item(x,y-9,z,STONE)
#							noise.persistence = 20

func save_world_data(x_start, y_start, z_start, x_end, y_end, z_end, biomes_name):
	
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()
	
#	set_cell_item(x,y,z,GRASS)
#	set_cell_item(x,y-1,z,DIRT)
#	set_cell_item(x,y-9,z,STONE)
#	noise.persistence = 10
	

func load_world_data(x_start, y_start, z_start, x_end, y_end, z_end, biomes_name):
	for x in range(x_start, x_end):
		for y in range(y_start, y_end):
			for z in range(z_start, z_end):
				var biomes = {
						'mountains': noise.get_noise_2d(x,z)*noise.get_noise_3d(x,y,z),
						'chaos': noise.get_noise_2d(x,z)-noise.get_noise_3d(x,y,z)+noise.get_noise_3d(x,y,z)*noise.get_noise_3d(x,y,z),
						'flat': noise.get_noise_2d(x,z),
						'hills': noise.get_noise_2d(x,z),
					}
				if y < biomes[biomes_name]*mutiplier+10:
					if get_cell_item(x,y,z) == -1:
						
						
						file.open(path, File.WRITE)
						file.store_line(to_json(data))
						file.close()
						
						set_cell_item(x,y,z,GRASS)
						set_cell_item(x,y-1,z,DIRT)
						set_cell_item(x,y-9,z,STONE)
						noise.persistence = 10
						
						
						
						
#	if not range(x_trans,x_size):
#		if not range(y_trans,y_size):
#			if not range(z_trans,z_size):
#				set_cell_item(x,y,z,-1)


func _process(delta):
#	create_world(player.translation.x/divider-chunk-1, 0, player.translation.z/divider-chunk-1, player.translation.x/divider+chunk, 100, player.translation.z/divider+chunk, biomes_selected)
	if player.translation.y <= 0:
		 player.life = 0
		
	var Block = world_to_map(player.VectorBlock)
#	set_cell_item(Block.x,Block.y,Block.z,-1) 
	if player.ded == true:
		player.translation = pos.translation
		player.life = 100
		
	
	$DirectionalLight.rotation.x += 0.0001
	if $WorldEnvironment.get_environment().get_sky().sun_latitude == 180:
		$WorldEnvironment.get_environment().get_sky().sun_latitude = 0
	else:
		$WorldEnvironment.get_environment().get_sky().sun_latitude += 0.01
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		$Control.show()
		
	
	if Input.is_action_just_pressed("ui_test"):
		if biomes_selected == 'flat':
			biomes_selected = 'mountains'
		elif biomes_selected == 'mountains':
			biomes_selected = 'chaos'
		elif biomes_selected == 'chaos':
			biomes_selected = 'hills'
		else:
			biomes_selected = 'flat'
		print(biomes_selected)


func _on_Button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	$Control.hide()

func _on_Button2_pressed():
	get_tree().quit()
