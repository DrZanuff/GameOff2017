extends Spatial

var isOnFloor = false

func _ready():
	set_physics_process(true)
	pass

func _physics_process(delta):
	if get_node("Ray1").is_colliding() or get_node("Ray2").is_colliding():
		isOnFloor = true
	if !get_node("Ray1").is_colliding() and !get_node("Ray1").is_colliding():
		isOnFloor = false
