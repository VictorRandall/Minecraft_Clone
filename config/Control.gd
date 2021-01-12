extends Control

onready var blocks = $GridMap
var mutiplier = 5
var n = 40
var Vector = Vector2()
var noise = OpenSimplexNoise.new()

func _process(delta):
	Vector.x += 0.01
	$Camera.rotation.y = noise.get_noise_2dv(Vector)
#	$Camera.translation.y = noise.get_noise_2dv(Vector)
	
func _ready():
	for x in range(-n, n):
		for y in range(0, 100):
			for z in range(-n-10, 5):
					if y < noise.get_noise_2d(x,z)*mutiplier+10:
						if blocks.get_cell_item(x,y,z) == -1:
							blocks.set_cell_item(x,y,z,0)
#							set_cell_item(x,y-1,z,DIRT)
#							set_cell_item(x,y-9,z,STONE)
							noise.persistence = 20
	get_tree().connect("network_peer_connected", self, "_player_connected")


func _on_Button_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(6969, 2)
	get_tree().set_network_peer(net)
	print("hosting")

func _on_Button2_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(net)

func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://MultiplayerWorld.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()



func _on_Button3_pressed():
	get_tree().change_scene("res://SingleplayerWorld.tscn")
	print("opening world")
	
	


func _on_Button4_pressed():
	get_tree().quit()
