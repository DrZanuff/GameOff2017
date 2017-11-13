extends Spatial

var balls = []
var score = 0
var shotsMade = 0.0
var shotsMissed = 0.0
var totalShots = 0.0
var percentage = 0.0
export(float) var time = 120.0
var canPlay = true #Can the player play? Based on time
var showScore = false # Diz se pode mostar o Score

func _ready():
	set_process(true)
	pass

func _process(delta):
	if time > 0:
		time = max(time-delta, 0)
		get_node("UI/Timer").text = str("%02d : %02d" % [float(time) / 60, int(time) % 60] )
	if time == 0:
		get_node("UI/Timer").text ="00:00"
		canPlay = false
		if totalShots>0:
			percentage = floor( ( shotsMade / totalShots ) * 100 )
		else:
			percentage = 0
		get_node("UI/Perf/Text").text = printScore()
		if showScore:
			$UI/Perf.modulate.a = min(1,$UI/Perf.modulate.a + (delta))
			get_node("UI/Label").modulate.a = max(0,get_node("UI/Label").modulate.a -(delta * 3))
			get_node("UI/Timer").modulate.a = max(0,get_node("UI/Timer").modulate.a -(delta * 3))
	$UI/Label.text = str("Score ",score)
	pass


func _on_Area_area_entered( col ):
	var h = get_node("Basket/Torus/Area/H_Check").global_transform.origin.y
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
	return(str("Shots Made: ",shotsMade,"\n\nMiss: ",shotsMissed,"\n\nTotal Shots: ",totalShots,"\n\nEfficiency: ",percentage,"%\n\n\nTotal Score: ",score) )
	pass
