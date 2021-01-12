extends KinematicBody

onready var life_bar = $Control/TextureProgress
onready var thirst_bar = $Control/TextureProgress2
onready var hunger_bar = $Control/TextureProgress3
onready var raycast = $Spatial/RayCast
var ded = false
var VectorBlock = Vector3()
var thirst = 100
var hunger = 100
var life = 100
var speed = 32
var menu = false
var jump = 90
var gravity = 1
var motion = Vector3()
var mouse_sensitivity = 0.5
onready var head = $Spatial
const UP = Vector3(0,1,0)
var pause = 0

remote func _set_position(pos):
	global_transform.origin = pos

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

func _physics_process(delta):
	move_and_slide(motion, Vector3.UP)
	motion.x = 0
	motion.z = 0
	
	life_bar.value = life
	thirst_bar.value = thirst
	hunger_bar.value = hunger
	
	if Input.is_action_pressed("ui_left_click"):
		VectorBlock = raycast.get_collision_point()
		
	
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
		speed = 32
		$Spatial.translation.y = 1.228
		$CollisionShape.scale.y = 1
		$CollisionShape.translation.y = 0
	elif Input.is_action_pressed("ui_crouch"):
		speed = 4
		$Spatial.translation.y = -0.041
		$CollisionShape.scale.y = 0.7
		$CollisionShape.translation.y = -0.75
	else:
		speed = 8
		$Spatial.translation.y = 1.228
		$CollisionShape.scale.y = 1
		$CollisionShape.translation.y = 0
		
	if life == 0:
		ded = true
	else:
		ded = false
