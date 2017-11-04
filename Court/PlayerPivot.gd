extends Position3D

var isJumping = false
var yPivot = 0
var speed = 25
var ballClass

func _ready():
	ballClass = load("res://Court/Ball.tscn")
	set_physics_process(true)
	pass

func _physics_process(delta):
	isJumping = !get_node("PlayerBody/Rays").isOnFloor
	get_node("PlayerBody").translation.x = get_node("PlayerPos").translation.x #Travando o X do Player
	get_node("PlayerBody").translation.z = get_node("PlayerPos").translation.z #Travando o Z do Player
	if Input.is_action_pressed("ui_right") && !isJumping:
		yPivot = min(90,yPivot + (delta * speed) )
	if Input.is_action_pressed("ui_left") && !isJumping:
		yPivot = max(-90,yPivot - (delta * speed) )
	
	rotation_deg = Vector3(0,yPivot,0)
	
	if Input.is_action_just_pressed("ui_select") and get_node("PlayerBody/Rays").isOnFloor:
		get_node("PlayerBody").apply_impulse(Vector3(),Vector3(0,1,0) * 5)
	
	if Input.is_action_just_pressed("shot"):
		shotBall()
	
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	
func shotBall():
	var ball = ballClass.instance()
	ball.global_transform.origin = get_node("PlayerBody/Shot").global_transform.origin
#	ball.transform.origin = get_node("PlayerBody/Shot").transform.origin
	get_parent().call_deferred("add_child",ball)
	var target = get_node("ShotAim").global_transform.origin
	var shot = get_node("PlayerBody/Shot").global_transform.origin
	var impulse = shot.linear_interpolate(target,0.5).normalized()
#	var impulse = target.linear_interpolate(shot,0.5).normalized()
	impulse.x = impulse.x * -1
	impulse.z = impulse.z * -1
	impulse.y = impulse.y * 3.5
	var lookDir = ball.global_transform.looking_at(target,Vector3(0,0,0))
	ball.global_transform.basis = lookDir.basis
#	ball.transform.looking_at(target,Vector3(0,1,0))
	var foward = -ball.global_transform.basis.z.normalized()
	ball.apply_impulse(Vector3() , foward * 30)
	pass
