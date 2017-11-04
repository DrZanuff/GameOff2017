extends RigidBody

var wake = false
var alive = false

func _ready():
	get_parent().get_parent().balls.append(self)
	set_physics_process(true)
	pass

func _process(delta):
#	if wake == false:
#		wake = true
#		sleeping = true
	pass
