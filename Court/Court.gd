extends Spatial

var balls = []
var score = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	$UI/Label.text = str("Score ",score)
	pass


func _on_Area_area_entered( area ):
	if area.global_transform.origin.y >= 2.2 and area.is_in_group("ball"):
		get_node("Basket/Torus/Cena/Scene Root/AnimationPlayer").play("Net")
		score +=1
		get_viewport().get_camera().shake()
		var ui = get_node("UI/AnimationPlayer")
		randomize()
		var i = floor(rand_range(1,8))
		ui.play(str("shake",i))
	pass # replace with function body
