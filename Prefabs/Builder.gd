extends Node2D

signal built

var moved_block

onready var current_pos = global_position

func _ready():
	
	pass

func tween(method, from, to):
	$Tween.interpolate_method(self, method, from, to, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	
var i = 0
func build_block(pos):
	
	if $Tiles.get_child_count() <= i: return
	
	var block = $Tiles.get_child(i)
	i += 1
	
	if(!block): 
		tween("move_to", current_pos, global_position)
		return

	print("starting %s" % block.name)
	
	tween("move_to", current_pos, block.global_position)
	yield($Tween, "tween_completed")
	$Tween.stop(self, "move_to")

	moved_block = block
	update_moved_block()

	tween("move_to", current_pos, pos)	
	yield($Tween, "tween_completed")
	$Tween.stop(self, "move_to")
	
	moved_block = null

	print("built %s" % block.name)
	block.visible = false
	#block.queue_free()
	emit_signal("built")
	
	pass

func move_to(pos):
	$ArmRot.look_at(pos)
	var length = (global_position - pos).length()
	$ArmRot/Arm.rect_size.y = length
	current_pos = pos
	update_moved_block()
	
func update_moved_block():
	if(moved_block): 
		moved_block.global_position = current_pos

	