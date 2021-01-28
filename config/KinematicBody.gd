extends KinematicBody

var motion = Vector3()
var speed = 10
var run = false
var acelerate
var gravity = 1

onready var cam = get_node("Spatial")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		cam.rotation.x += -deg2rad(movement.y * 0.2)
		cam.rotation.x = clamp(cam.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * 0.2)


func _physics_process(delta):
	motion.x = 0
	motion.z = 0
	motion.y -= gravity
	#conditions
	if is_on_floor():
		motion.y = 0
#	else:
#		pass
#	rpc_unreliable()
	#Inputs
	if Input.is_action_pressed("ui_right"):
		motion += transform.basis.x * speed
	if Input.is_action_pressed("ui_left"):
		motion += -transform.basis.x * speed
	if Input.is_action_pressed("ui_down"):
		motion += transform.basis.z * speed
	if Input.is_action_pressed("ui_up"):
		motion += -transform.basis.z * speed
	if Input.is_action_pressed("ui_sprint"):
		speed = 20
	else:
		speed = 5
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			motion.y += 15
	
	motion = move_and_slide(motion,Vector3(0,1,0))
