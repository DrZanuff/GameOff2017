extends Control

var arr = []

func _ready():
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		var myColor = arr.back()
		arr.push_front(arr.back())
		arr.pop_back()
		print(str("My color ",myColor.get_name()))
		for i in range(arr.size()):
			print(arr[i].get_name())
	pass
