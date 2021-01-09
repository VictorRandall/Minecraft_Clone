extends KinematicBody

enum{
	PAUSED = 0
	UNPAUSED = 1
}
var water = 100
var life = 100
var speed = 32
var menu = false
var jump = 80
var gravity = 5
var motion = Vector3()
var mouse_sensitivity = 0.5
onready var head = $Spatial
const UP = Vector3(0,1,0)
var pause = 0

func _ready():
	if menu == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
 
func _input(event):
	if menu == false:
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _process(delta):
#	if is_network_master():
	motion = move_and_slide(motion,UP)
	motion.x = 0
	motion.z = 0
	
	if Input.is_action_pressed("ui_left_click"):
		pass
		
	
	if not is_on_floor():
		motion.y += -gravity
		
	else:
		if Input.is_action_pressed("ui_jump"):
			motion.y += jump
			
			
	
	if Input.is_action_pressed("ui_up"):
		motion += -transform.basis.z * speed
		
	if Input.is_action_pressed("ui_down"): 
		motion += transform.basis.z * speed
		
	
	if Input.is_action_pressed("ui_right"):
		motion += transform.basis.x * speed
	
	if Input.is_action_pressed("ui_left"):
		motion += -transform.basis.x * speed
	
	if Input.is_action_pressed("ui_sprint"):
		speed = 16
	elif Input.is_action_pressed("ui_crouch"):
		speed = 4
	else:
		speed = 8
		
	
	
	
	
