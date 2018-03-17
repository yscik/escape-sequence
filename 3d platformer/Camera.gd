extends Camera

signal camera_update


var cam_speed = 2
var zoom_speed = 1


func _input(event):
	if event is InputEventMouseButton:
		var input =  int((event.button_index == BUTTON_WHEEL_DOWN)) - int((event.button_index == BUTTON_WHEEL_UP))
		
		if projection == PROJECTION_ORTHOGONAL:
			# orthoganal
			size += zoom_speed * input
			size = max(1,size)
		else:
			#perspective
			fov += zoom_speed * input
			fov = max(1,fov)
		
		if input:
			emit_signal("camera_update")
		
	
	elif Input.is_action_just_pressed("camera_switch_projection"):
		projection = PROJECTION_PERSPECTIVE if projection == PROJECTION_ORTHOGONAL else PROJECTION_ORTHOGONAL


func _process(delta):

	# Input
	var input = int(Input.is_action_pressed("camera_zoom_in")) - int(Input.is_action_pressed("camera_zoom_out"))

	# orthoganal
	if projection == PROJECTION_ORTHOGONAL:
		size += zoom_speed * 10 * input * delta
		size = max(1,size)
	else:
		#perspective
		fov += zoom_speed * 10 * input * delta
		fov = max(1,fov)
	
	if input:
		emit_signal("camera_update")

