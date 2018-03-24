
extends Node2D

var grab_offset
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
		grabbed.global_position = global_position + grab_offset
	
func grab():
	grabbed = target
	grab_offset = grabbed.global_position - global_position 
	grabbed.off()
	grabbed.set_collision_mask_bit(4, false)
#	grabbed.find_node("Movable").visible = true

func drop():
	grabbed.on()
	grabbed.find_node("Movable").visible = false
#	grabbed.set_collision_mask_bit(4, true)
	grabbed = null

func can_grab(area):
	target = area

func cant_grab(area):
	target = null

