extends CollisionObject2D


func click():
	
	$Tween.interpolate_property(self, "rotation", rotation, rotation + deg2rad(90), 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func _input_event(viewport, event, shape_idx):
	print("pi")
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		click()

func _unhandled_key_input(event):
	if event.pressed && event.scancode == KEY_ENTER:
		click()