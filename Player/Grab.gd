
extends Node2D

var grabbed = null
var target = null
	
func _unhandled_key_input(event):
	if event.pressed && event.scancode == KEY_SPACE:
		if target && !grabbed:
			grab()
		elif grabbed:
			drop()
	
func _process(delta):
	if grabbed:
		grabbed.global_position = global_position
	
func grab():
	grabbed = target
	grabbed.off()
	grabbed.set_collision_mask_bit(4, false)
	#grabbed.find_node("Movable").visible = true

func drop():
	grabbed.on()
	#grabbed.find_node("Movable").visible = false
	grabbed.set_collision_mask_bit(4, true)
	grabbed = null

func can_grab(area):
	target = area
	pass # replace with function body


func cant_grab(area):
	target = null
