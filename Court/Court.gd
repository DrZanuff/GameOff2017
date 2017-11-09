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
		score +=1
	pass # replace with function body
