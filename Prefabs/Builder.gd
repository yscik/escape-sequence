extends Node2D

signal built

var moved_block
var tiles_scene = preload("res://Levels/Workshop/BuilderTiles.tscn")

onready var current_pos = global_position

func _ready():
	
	pass

func move_to(pos):
	$Tween.interpolate_method(self, "set_pos", current_pos, pos, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	
var i = 0

func build_block(pos):
	
	if $Tiles.get_child_count() <= i: 
		click_add_tiles(pos)
		return
	
	var block = $Tiles.get_child(i)
	i += 1
	
	if(!block): 
		reset_pos()
		return
	
	move_to(block.global_position)
	yield($Tween, "tween_completed")

	block.set_collision_mask_bit(4, false)
	if State.player.grab.grabbed == block:
		State.player.grab.drop()
		
	moved_block = block
	update_moved_block()

	move_to(pos)	
	yield($Tween, "tween_completed")
	
	moved_block = null

	print("built %s" % block.name)
	block.visible = false
	emit_signal("built")
	
	pass

func reset_pos():
	move_to(global_position)
	
func set_pos(pos):
	
	if !$Cursor || !$Cursor.working:
		$Tween.stop(self)
		moved_block = null
		return
		
	current_pos = pos
	$Cursor.global_position = pos
	update_moved_block()
	
func update_moved_block():
	if(moved_block): 
		moved_block.global_position = current_pos

func click_add_tiles(pos):

	var tiles_node = $Tiles
	remove_child(tiles_node)
	tiles_node.queue_free()
	
	move_to($ToolbarUi/Button.global_position)
	yield($Tween, "tween_completed")
	
	var tiles = tiles_scene.instance()
	add_child(tiles)
	i = 0
	build_block(pos)
	
	pass
	
var manual_count = 0
func manual_add_tiles():
	var tiles = tiles_scene.instance()
	tiles.position.x = manual_count * 140
	manual_count += 1
	add_child(tiles)
	
	
	