extends Camera

var target
var shakeTimer = 0
var shakeAmmount = 0.03


func _ready():
	set_physics_process(true)
	target = get_parent().get_parent().get_node("LookPos").translation
	pass

func _physics_process(delta):
	look_at(target , Vector3(0,1,0) )
	if shakeTimer > 0 :
		randomize()
		shakeTimer = max( 0 , shakeTimer - delta)
		set_h_offset( rand_range(-1.0,1.0) * shakeAmmount)
		set_v_offset( rand_range(-1.0,1.0) * shakeAmmount)
	if shakeTimer == 0:
		set_h_offset(0)
		set_v_offset(0)

func shake():
	shakeTimer = 0.3
	pass