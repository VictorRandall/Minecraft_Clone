extends Control

var Vector = Vector2()
var noise = OpenSimplexNoise.new()

func _process(delta):
	Vector.y += 0.1
	$Camera.rotation.y = noise.get_noise_2dv(Vector)*2
	$DirectionalLight.rotation.x += 0.001
	

func _ready():
	for x in range(-30,30):
		for y in range(50):
			for z in range(-30,30):
				if y < noise.get_noise_2d(x,z)*noise.get_noise_3d(x,y,z)-noise.get_noise_3d(x,y,z)*25+10:
						$GridMap.set_cell_item(x,y,z,0)
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Button_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(6969,2)
	get_tree().set_network_peer(net)
	print("hosting")


func _on_Button2_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("127.0.0.1", 6969)



func _on_Button3_pressed():
	get_tree().change_scene("res://SingleplayerWorld.tscn")
	print("opening world")
	

func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://MultiplayerWorld.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	


func _on_Button4_pressed():
	get_tree().quit()
