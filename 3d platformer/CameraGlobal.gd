extends Node

signal camera_global_facing_changed

var camera_facing = Vector2(1,0)

onready var camera = get_tree().root.get_camera()


func _ready():
	print("CameraGlobal Singleton loaded")



# Received Signals
func _on_Gimball_gimball_update():
	if camera != null:
		var cam_euler = camera.get_global_transform().basis.get_euler()
		camera_facing = Vector2(1,0).rotated(-cam_euler.y)
	
	emit_signal("camera_global_facing_changed")
