extends RigidBody

var wake = false
var alive = false

func _ready():
	get_parent().get_parent().balls.append(self)
	set_physics_process(true)
	pass

func _physics_process(delta):
	rotate_x(5 * delta)
	if wake == false:
		wake = true
		sleeping = true
	pass
