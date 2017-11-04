extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_parent().arr.append(self)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
