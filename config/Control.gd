extends Control

var Vector = Vector2()
var noise = OpenSimplexNoise.new()

func _process(delta):
	pass
	
func _ready():
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
