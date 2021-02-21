extends KinematicBody

var motion = Vector3()
var speed = 10
var run = 35
var walk = 10
var jump_hight = 18
var max_speed = 20
var aceleration = Vector3()
onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") 
onready var raycast = get_node("RayCast")
onready var cam = $Spatial
onready var b = 1
onready var b_xyz = Vector3(0,100,0)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y * 0.2)
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * 0.2)

func player_inputs():
	if Input.is_action_pressed("ui_right"):
		motion += transform.basis.x * speed
	if Input.is_action_pressed("ui_left"):
		motion -= transform.basis.x * speed
	if Input.is_action_pressed("ui_down"):
		motion += transform.basis.z * speed
	if Input.is_action_pressed("ui_up"):
		motion -= transform.basis.z * speed
	
#	if (motion.x >= max_speed):
#		motion.x = aceleration.x
	
	
	
	
	if Input.is_action_pressed("ui_sprint"):
		speed = run
	else:
		speed = walk
	
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			motion.y += jump_hight
	
	if Input.is_action_pressed("ui_left_click"):
		if raycast.is_colliding():
			var block_pos = (raycast.get_collision_point() - raycast.get_collision_normal() / 2 )
			var collision_obj = raycast.get_collider_shape()
			print(collision_obj)
	if Input.is_action_pressed("ui_right_click"):
		if raycast.is_colliding():
			var block_pos = (raycast.get_collision_point() + raycast.get_collision_normal() / 2 )
			var collision_obj = raycast.get_collider_shape()
			print(collision_obj)

func _process(delta):
	var delta2 = delta* 2
	motion.x = 0
	motion.z = 0
	#conditions
	motion.y -= gravity * delta2
#	if not is_on_floor():
#		Engine.time_scale = 0.1
#	else:
#		Engine.time_scale = 1
	
	raycast.rotation = cam.rotation
	
			
#	rpc_unreliable()
	#Inputs
	player_inputs()
	
	motion = move_and_slide(motion,Vector3(0,1,0))
