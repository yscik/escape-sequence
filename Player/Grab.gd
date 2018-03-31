
extends Node2D

var grab_offset
var grabbed = null
var target = null

func _ready():
	
	pass
	
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
	if target:
		$Mark.global_position = target.global_position
		$Mark.global_rotation = 0

func grab():
	grabbed = target
	grabbed.grabbed = true
	$Mark.visible = false
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
	if !State.player_skills.grab: return
	
	target = movable
	movable.in_grab_range(true)
	if !grabbed:
		focus()

func cant_grab(movable):
	movable.in_grab_range(false)
	$Mark.visible = false
	target = null

func focus():
	var targetBounds = target.find_node("Movable")
	var mark = $Mark/MoveMark
	mark.rect_size = targetBounds.rect_size
	mark.rect_position = targetBounds.rect_position
	
	$Mark/Animation.play("Focus")
	
	$Mark.visible = true
	