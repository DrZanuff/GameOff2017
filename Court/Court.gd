extends Spatial

var balls = []
var score = 0
var shotsMade = 0
var shotsMissed = 0
var totalShots = 0
var percentage = 0
export(float) var time = 25.0
var canPlay = true #Can the player play? Based on time

func _ready():
	set_process(true)
	print(str( "um numero %02d e outro numero %02d" % [9 % 60, 10 % 60] ))
	pass

func _process(delta):
	if time > 0:
		time = max(time-delta, 0)
		get_node("UI/Timer").text = str("%02d : %02d" % [float(time) / 60, int(time) % 60] )
	if time == 0:
		get_node("UI/Timer").text ="00:00"
		canPlay = false
		get_node("UI/Performance").text = str("FG ",shotsMade," Miss ",shotsMissed," / \n Total Shots: ",totalShots)
	$UI/Label.text = str("Score ",score)
	pass


func _on_Area_area_entered( col ):
	var h = get_node("Basket/Torus/Area/H_Check").global_transform.origin.y
	print(h)
	if col.global_transform.origin.y >= h and col.is_in_group("ball"):
		col.get_parent().score()
		shotsMade += 1
		get_node("Basket/Torus/Cena/Scene Root/AnimationPlayer").play("Net")
		score +=1
		get_viewport().get_camera().shake()
		var ui = get_node("UI/AnimationPlayer")
		randomize()
		var i = floor(rand_range(1,8))
		ui.play(str("shake",i))
		printScore()
	pass # replace with function body

func printScore():
	print( str("FG ",shotsMade," Miss ",shotsMissed," / \n Total Shots: ",totalShots) )
	pass
