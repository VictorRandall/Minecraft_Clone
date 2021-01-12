extends KinematicBody

enum {
	IDLE,
	ATTACK,
	
}

var state = IDLE

func _ready():
	pass 


func _physics_process(delta):
	match state:
		IDLE:
			pass
		ATTACK:
			pass
