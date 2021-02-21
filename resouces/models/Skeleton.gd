extends Skeleton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	physical_bones_start_simulation()
	
func _process(delta):
	if Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("ui_jump"):
		translation.y += 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
