extends Node2D

signal built

var moved_block

onready var current_pos = global_position

func _ready():

	pass

func tween(method, from, to):
	$Tween.interpolate_method(self, method, from, to, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	
func build_block(pos):
	
	var block = $Tiles.find_node("Tile*")
	
	if(!block): 
		tween("move_to", current_pos, global_position)
		return
	
	tween("move_to", current_pos, block.global_position)
	yield($Tween, "tween_completed")

	$Tiles.remove_child(block)
	add_child(block)
	moved_block = block

	tween("move_to", current_pos, pos)	
	yield($Tween, "tween_completed")
	
	remove_child(block)
	moved_block = null
	block.queue_free()
	
	emit_signal("built")
	
	pass

func move_to(pos):
	$ArmRot.look_at(pos)
	var length = (global_position - pos).length()
	$ArmRot/Arm.rect_size.y = length
	current_pos = pos
	if(moved_block): 
		moved_block.global_position = pos

	