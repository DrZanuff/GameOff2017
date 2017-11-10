extends Position3D

var isJumping = false
var airShotStop = false
var yPivot = 0
var speed = 0 
var maxSpeed = 25 
var acc = 150 #Acceleration
var dcc = 25 #Decelaration
var lastDir = "" #Last dir of the movement

func _ready():
	set_physics_process(true)
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	if get_parent().canPlay:
		isJumping = !get_node("PlayerBody/Rays").isOnFloor
		get_node("PlayerBody").translation.x = get_node("PlayerPos").translation.x #Lock X of the Player
		get_node("PlayerBody").translation.z = get_node("PlayerPos").translation.z #Lock Z of the Player
		if Input.is_action_pressed("ui_right"):
			lastDir = "R"
			speed = min(maxSpeed , speed + (acc * delta) )
		if Input.is_action_pressed("ui_left"):
			lastDir = "L"
			speed = min(maxSpeed , speed + (acc * delta) )
		#Decreasing the speed of the player when releases the key for one quarter
		if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
			speed = (speed * 0.5)
		#Decreases the speed of the player when is not pressing movement keys
		if !Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
			speed = max(0 , speed - (dcc * delta) )
		# If speed greather than 0, modify yPivot
		if speed > 0:
			if lastDir == "R":
				yPivot = min(90,yPivot + (delta * speed) )
			if lastDir == "L":
				yPivot = max(-90,yPivot - (delta * speed) )
		
		rotation_deg = Vector3(0,yPivot,0)
		
		if Input.is_action_just_pressed("ui_select") and get_node("PlayerBody/Rays").isOnFloor:
			get_node("PlayerBody").apply_impulse(Vector3(),Vector3(0,1,0) * 5)
		
		if Input.is_action_just_pressed("shot"):
			shotBall()
		
		if airShotStop:
			speed = (speed * 0.5)
		if get_node("PlayerBody/Rays").isOnFloor:
			airShotStop = false
	
	
	
func shotBall():
	get_parent().totalShots +=1
	if isJumping:
		airShotStop = true
	var b = get_parent().balls.back() #Acess the last ball of the Array
	get_parent().balls.push_front(get_parent().balls.back()) #Reoder the Array
	get_parent().balls.pop_back()
	b.wake()
	b.global_transform = get_node("PlayerBody/Shot").global_transform #Set the position of the current ball to the player
	var target = get_node("ShotAim").global_transform.origin #Assing a target
	var lookDir = b.global_transform.looking_at(target,Vector3(0,1,0)) #Find an angle to look at
	b.global_transform.basis = lookDir.basis #Set the angle of the ball from lookDir 
	var foward = -b.global_transform.basis.z.normalized() #Get the foward of the ball
	b.apply_impulse(Vector3() , foward * 11) #Apply an impulse at the foward of the ball
	pass

