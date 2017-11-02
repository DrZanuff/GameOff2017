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
	get_node("PlayerBody").translation.x = get_node("PlayerPos").translation.x
	get_node("PlayerBody").translation.z = get_node("PlayerPos").translation.z
	if Input.is_action_pressed("ui_right") && !isJumping:
		yPivot = min(90,yPivot + (delta * speed) )
	if Input.is_action_pressed("ui_left") && !isJumping:
		yPivot = max(-90,yPivot - (delta * speed) )
	
	rotation_deg = Vector3(0,yPivot,0)
	
	if Input.is_action_just_pressed("ui_select") and get_node("PlayerBody/Rays").isOnFloor:
		get_node("PlayerBody").apply_impulse(Vector3(),Vector3(0,1,0) * 5)
	
	if Input.is_action_just_pressed("shot"):
		shotBall()
	
func shotBall():
	var target = get_node("ShotAim").global_transform.origin
	var ball = ballClass.instance()
	ball.global_transform.origin = get_node("PlayerBody/Shot").global_transform.origin
	look_at(target,Vector3(0,1,0))
	get_parent().add_child(ball)
	ball.apply_impulse(Vector3() , Vector3(0,1,-1) * 8)
	pass

