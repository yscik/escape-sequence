extends "res://Prefabs/Movable.gd"

var OFFSET = Vector2(32,32)
export var tile = -1
export var hideSprite = true
export var on = true
var content = null

var tilemap

func _ready():
	if(on): on()

func off():
	grabbed = true
	if content != null: 
		change_map(content)
	if hideSprite:
		$Sprite.visible = true
		
	get_parent().remove_child(self)
	State.player.grab.add_child(self)

func on():
	content = change_map(tile)
	grabbed = false
	if hideSprite:
		$Sprite.visible = false

	
func change_map(value):
	
	tilemap = get_map()
	
	if !tilemap: return
	
	var pos = tilemap.world_to_map(tilemap.to_local(global_position))
	var prev = tilemap.get_cellv(pos)
	
	if grabbed:
		get_parent().remove_child(self)
		tilemap.get_parent().add_child(self)

	global_position = tilemap.to_global(tilemap.map_to_world(pos) + OFFSET)
	
	tilemap.set_cellv(pos, value)
	tilemap.update_bitmask_area(pos)
	
	return prev
	
func get_map():
		
	var node = State.area if State.area else self
	while(node):
		var map = node.find_node("TileMap")
		if map:
			return map
		node = node.get_parent()
		

	

	
