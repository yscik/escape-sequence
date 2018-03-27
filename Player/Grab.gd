
extends Node2D

var grab_offset
var grabbed = null
var target = null
	
func _unhandled_key_input(event):
	if State.player_skills.grab && event.pressed && event.scancode == KEY_SPACE:
		if target && !grabbed:
			grab()
		elif grabbed:
			drop()
	
func _process(delta):
	if grabbed:
		if grabbed.offset:
			grabbed.global_position = State.player.global_position  + grab_offset
		else:
			grabbed.global_position = global_position
	
func grab():
	grabbed = target
	grabbed.grabbed = true
	
	if grabbed.offset:
		grab_offset = grabbed.global_position - State.player.global_position
		
	grabbed.off()
	grabbed.set_collision_mask_bit(4, false)

func drop():
	grabbed.on()
	grabbed.grabbed = false
	grabbed.set_collision_mask_bit(4, true)
	grabbed = null

func can_grab(movable):
	target = movable
	movable.in_grab_range(true)
	

func cant_grab(movable):
	movable.in_grab_range(false)
	target = null

