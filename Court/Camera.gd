extends Camera

var target

func _ready():
	set_physics_process(true)
	target = get_parent().get_parent().get_node("LookPos").translation
	pass

func _physics_process(delta):
	look_at(target , Vector3(0,1,0) )