extends Spatial

signal gimball_update

var rotate_speed = 2


func _ready():
	connect("gimball_update", CameraGlobal, "_on_Gimball_gimball_update")


func _process(delta):
	
	# Input
	var input = Vector2()
	input.x = int(Input.is_action_pressed("camera_right")) - int(Input.is_action_pressed("camera_left"))
	input.y = int(Input.is_action_pressed("camera_up")) - int(Input.is_action_pressed("camera_down"))

	
	rotate_y(input.x * rotate_speed * delta)
	$InnerGimbal.rotate_x(input.y * rotate_speed * delta)
	
	if input:
		emit_signal("gimball_update")


# Received Signals
func _on_Camera_camera_update():
	emit_signal("gimball_update")
