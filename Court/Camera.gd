extends Camera

var target
var canFilm #Can the camera look at the board?
var shakeTimer = 0
var shakeAmmount = 0.03


func _ready():
	canFilm = get_parent().get_parent().get_parent().get_parent().canPlay
	target = get_parent().get_parent().get_parent().get_parent().get_node("LookPos").translation
	set_physics_process(true)
	pass

func _physics_process(delta):
	canFilm = get_parent().get_parent().get_parent().get_parent().canPlay
	if canFilm:
		look_at(target , Vector3(0,1,0) )
	if !canFilm:
		get_parent().set_offset(get_parent().get_offset() + (delta* 5) )
		if get_parent().get_unit_offset() > 0.5:
			quat(delta)
		if get_parent().get_unit_offset() > 0.3:
			get_parent().get_parent().get_parent().get_parent().showScore = true
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

func quat(dt):
	var pos = get_parent()
	var target = get_parent().get_parent().get_parent().get_node("PlayerBody").transform.origin
	var lookDir =  target - transform.origin
	var rot = transform.looking_at(lookDir , Vector3(0,1,0) )
	var q = Quat(transform.basis).slerp(rot.basis,dt * 0.4)
	transform = Transform(q,transform.origin)
	pass