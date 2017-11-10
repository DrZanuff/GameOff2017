extends RigidBody

var wake = false
var alive = false
var aliveTime = 0
var fadeTime = 1
var initialPos
var missedBall = true

func _ready():
	randomize()
	initialPos = translation
	get_parent().get_parent().balls.append(self) #Insert the ball in the array
	$Model/MeshInstance.material_override = $Model/MeshInstance.material_override.duplicate() #Make the Material Unique
	var color = Vector3(rand_range(0.2,0.9),rand_range(0.2,0.9),rand_range(0.2,0.9)) #Generate a random color
	$Model/MeshInstance.material_override.set("shader_param/color",color) #Apply the random color to the ball
	set_physics_process(true)
	pass

func _physics_process(delta):
	if alive:
		var speed = ((linear_velocity.x + linear_velocity.y + linear_velocity.z) * 0.3) * 4 # Calculate the average speed of the ball
		$Model.rotate_x(speed * delta)
		if aliveTime > 0:
			aliveTime = max(0,aliveTime-delta)
		if aliveTime == 0: #Start fade
			fadeTime = max(0,fadeTime-(delta*1.0))
			$Model/MeshInstance.material_override.set("shader_param/alpha",fadeTime)
			if fadeTime == 0:
				sleep()
	elif !alive:
		if sleeping == false:
			sleeping = true

	if wake == false:
		wake = true
		sleeping = true
	pass

func wake():
	alive = true
	aliveTime = 4.0
	pass

func score():
	missedBall = false

func sleep():
	if missedBall:
		get_parent().get_parent().shotsMissed += 1
	alive = false
	fadeTime = 1
	$Model/MeshInstance.material_override.set("shader_param/alpha",fadeTime)
	translation = initialPos
	linear_velocity = Vector3()
	set_axis_velocity(Vector3())
	sleeping = true
	missedBall = true
	get_parent().get_parent().printScore()
	pass